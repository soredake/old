set mouse=a             " enable mouse
set number              " show line numbers
set cursorline          " highlight current line
set list                " http://www.chrispian.com/quick-vi-tip-show-hidden-characters/
set listchars=tab:▸\ ,eol:¬  " https://git.sr.ht/~sircmpwn/dotfiles/tree/.vimrc#n122

" https://neovim.io/doc/user/provider.html#provider-clipboard
set clipboard+=unnamedplus

" https://neovim.io/doc/user/options.html#%27copyindent%27
set copyindent
" http://vim.wikia.com/wiki/Converting_tabs_to_spaces
set expandtab
"set tabstop=2
"set softtabstop=2
set shiftwidth=2

" load plugins from portage
let &runtimepath.=',/usr/share/vim/vimfiles/'

" statusline settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
" %* is black background
" 2nd is default statusline https://neovim.io/doc/user/options.html#%27statusline%27
set statusline+=%*
set statusline+=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" fix windows-1251 encoding in files
set fencs=ucs-bom,utf-8,windows-1251,default,latin1
" XDG
let g:netrw_home=$XDG_DATA_HOME.'/nvim'
" end line on 9999
set textwidth=9999

" faster?
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'
