;; Relied heavily on github.com/tree-sitter-grammars/tree-sitter-odin
;; under queries/locals.scm

(procedure_declaration
  (identifier) @name
  (#set! "kind" "Function")) @symbol

(struct_declaration
  (identifier) @name "::"
  (#set! "kind" "Struct")) @symbol

(const_declaration
  (identifier) @name "::"
  (#set! "kind" "Constant")) @symbol

(enum_declaration
  (identifier) @name "::"
  (#set! "kind" "Enum")) @symbol


; ===================================================================
; ; Scopes
;
; [
;   (block)
;   (declaration)
;   (statement)
; ] @scope
;
; ; References
;
; (identifier) @reference
;
; ; Definitions
;
; (package_declaration (identifier) @definition.namespace)
;
; (import_declaration alias: (identifier) @definition.namespace)
;
; (procedure_declaration (identifier) @definition.function)
;
; (struct_declaration (identifier) @definition.type "::")
;
; (enum_declaration (identifier) @definition.enum "::")
;
; (union_declaration (identifier) @definition.type "::")
;
; (bit_field_declaration (identifier) @definition.type "::")
;
; (variable_declaration (identifier) @definition.var ":=")
;
; (const_declaration (identifier) @definition.constant "::")
;
; (const_type_declaration (identifier) @definition.type ":")
;
; (parameter (identifier) @definition.parameter ":"?)
;
; (default_parameter (identifier) @definition.parameter ":=")
;
; (field (identifier) @definition.field ":")
;
; (label_statement (identifier) @definition ":")
