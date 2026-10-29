" Vim compiler file
" Compiler: odin
" Language: Odin
" Last changed: 2026-10-05

if exists("current_compiler")
  finish
endif
let current_compiler = "odin"

CompilerSet makeprg=odin\ build\ %:p:h

" Odin prints "file(line:col) Error: message".
" Keeping the severity word in %m lets the plugin classify Error, Warning,
" Syntax Error and Syntax Warning separately.
" The backslash-space is needed because :setlocal would otherwise treat the
" space as the start of another argument.
CompilerSet errorformat=%f(%l:%c)\ %m