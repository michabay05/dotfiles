" Vim compiler file
" Compiler: odin
" Language: Odin
" Last changed: 2026-05-20

if exists("current_compiler")
  finish
endif
let current_compiler = "odin"

CompilerSet makeprg=odin\ build\ %:p:h


" TODO: mostly works but it's kinda bad
CompilerSet errorformat=
      \%f(%l:%c)\ %t%*[^:]:\ %m,
      \%f(%l:%c:%*\\d:%*\\d)\ %t%*[^:]:\ %m,
      \%-G%.%#Running%.%#,
      \%-G%.%#

