" turn off auto adding comments on next line
" so you can cut and paste reliably
" http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set fo=tcq

syntax on

set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2

highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\	/
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

" Show me a ruler
set ruler

" ****************************************************************************
" Misc Stuff
" ****************************************************************************
filetype plugin indent on

au BufRead,BufNewFile *.pp set filetype=puppet

" Because I like using a terminal with a dark background this
" makes it so text isn't set with dark blue.
:color desert
