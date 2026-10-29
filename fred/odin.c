#include "lex-helpers.h"

typedef struct OdinPathResult {
  String8 path;
  String8 line;
  String8 column;
  String8 message;
} OdinPathResult;
OdinPathResult OdinMatchPathLine(String8 line_txt) {
  OdinPathResult result = {0};
  // We are trying to match:
  // <path>(<line>:<column>) <message>
  
  String8 path_txt         = {0};
  String8 open_paren       = {0};
  String8 line_num_txt     = {0};
  String8 colon_txt        = {0};
  String8 column_num_txt   = {0};
  String8 close_paren      = {0};
  String8 message_txt  = {0};
  uint64_t start = 0;
  uint64_t end = 0;
  
  end = lex_skip_pred(line_txt, end, lex_is_space);
  start = end;
  // <path>
  // Parse until we hit a '('.
  // This could break paths that have quotes but... w.e...
  for (;end < line_txt.size; ++end) {
    if (line_txt.str[end] == '(') {
      path_txt = str8_substr(line_txt, .off = start, .len = end - start);
      break;
    }
  }
  start = end;

  // opening '('.
  if (path_txt.size != 0 && end < line_txt.size) {
    if (line_txt.str[end] == '(') {
      // Skip the '('.
      ++end;
      // Eat any whitespace.
      end = lex_skip_pred(line_txt, end, lex_is_space);
      open_paren = str8_substr(line_txt, .off = start, .len = end - start);
      start = end;
    }
  }

  // <line>
  for (;end < line_txt.size; ++end) {
    if (line_txt.str[end] == ':') {
      line_num_txt = str8_substr(line_txt, .off = start, .len = end - start);
      break;
    }
  }
  start = end;
  
  // ':'.
  if (path_txt.size != 0 && end < line_txt.size) {
    if (line_txt.str[end] == ':') {
      // Skip the ':'.
      ++end;
      // Eat any whitespace.
      end = lex_skip_pred(line_txt, end, lex_is_space);
      colon_txt = str8_substr(line_txt, .off = start, .len = end - start);
      start = end;
    }
  }
  
  // <column>
  for (;end < line_txt.size; ++end) {
    if (line_txt.str[end] == ')') {
      column_num_txt = str8_substr(line_txt, .off = start, .len = end - start);
      break;
    }
  }
  start = end;
  
  // closing ')'.
  if (path_txt.size != 0 && end < line_txt.size) {
    if (line_txt.str[end] == ')') {
      // Skip the ')'.
      ++end;
      // Eat any whitespace.
      end = lex_skip_pred(line_txt, end, lex_is_space);
      close_paren = str8_substr(line_txt, .off = start, .len = end - start);
      start = end;
    }
  }
  
  // <message>
  end = line_txt.size;
  message_txt = str8_substr(line_txt, .off = start, .len = end - start);

  result.path = path_txt;
  result.line = line_num_txt;
  result.column = column_num_txt;
  result.message = message_txt;
  return result;
}

void OutputMatcherOdin(SMCLICtx* ctx, SMCLIMatcherResult* result, String8 output) {
  uint64_t start = 0;
  uint64_t end = 0;
  String8 line_txt = {0};
  OdinPathResult working_line = {0};
  for (; end < output.size; ++end) {
    if (output.str[end] == '\n') {
      line_txt = str8_substr(output, .off = start, .len = end - start);
      working_line = OdinMatchPathLine(line_txt);
      if (working_line.path.size > 0 && working_line.line.size > 0) {
        // Make this line our diagnostic.
        SMCLIMatcherClickablePath click_path = {0};
        click_path.path.off = working_line.path.str - output.str;
        click_path.path.size = working_line.path.size;
        click_path.diag.off = working_line.message.str - output.str;
        click_path.diag.size = working_line.message.size;
        click_path.line = u64_from_str8(working_line.line, 10);
        click_path.sev_cat = SMCLI_MATCHER_CAT_Error;
        smcli_add_clickable_path(ctx, result, &click_path);
        // Decorate the line.
        SMCLIMatcherDecoration dec_txt = {0};
        // Same location as the diag.
        dec_txt.string = click_path.diag;
        dec_txt.sev_cat = click_path.sev_cat;
        smcli_add_text_decoration(ctx, result, &dec_txt);
        // Clear working path.
        working_line = (OdinPathResult){0};
        
        working_line = (OdinPathResult){0};
      }
      // The start should be past this newline.
      start = end + 1;
    }
  }
}