" Vim compiler file
" Language:    Odin
" Maintainer:  Michael Abayneh (michabay05@gmail.com)
" Based On:    https://github.com/kaarmu/typst.vim
" Last Change: 2025 Aug 05

if exists('current_compiler')
    finish
endif
let current_compiler = get(g:, 'odin_cmd', 'odin')

let s:makeprg = [current_compiler, 'build', '.']

" CompilerSet makeprg=typst
execute 'CompilerSet makeprg=' . join(s:makeprg, '\ ')
CompilerSet errorformat=
    \%E%f(%l:%c)\ Syntax\ Error:\ %m,
    \%E%f(%l:%c)\ Error:\ %m,
    \%+G%m
