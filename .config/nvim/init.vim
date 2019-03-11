" Name: Vim Configuration
" Author: Nicholas Truong

""" Option settings.
colorscheme iridescence
set encoding=utf-8            " Use UTF-8
set previewheight=20          " Preview window height
set textwidth=80              " Keep columns legible
set scrolloff=3               " Keep 3 lines above and below cursor
set wrap                      " Word wrap
set inccommand=nosplit        " Incremental commands
set expandtab                 " Insert tabs as spaces
set tabstop=2                 " Number of spaces a tab counts for
set shiftwidth=2              " Number of spaces a tab counts for
set nojoinspaces              " No double space when joining lines
set noswapfile                " No swapfile
set wildignorecase            " Ignore case in wildmenu
set showtabline=2             " Tabline always visible
set fillchars=vert:\ ,diff:\  " Make split separators invisible
set splitbelow                " Split below
set splitright                " Split right
let g:tex_flavor = "latex"    " Default tex flavor is LaTeX

""" Keymaps.
" Leader.
let mapleader = "\<Space>"

" Escape.
inoremap jk <Esc>

" Clear highlighting.
nnoremap <silent> <Esc> :nohlsearch<CR>:call clearmatches()<CR>

" Localize directory.
nnoremap <silent> <Leader>cd :lcd %:p:h<CR>:echo "Localized directory."<CR>

" File opening: [open in window], [save], [exit].
nnoremap <Leader>o :edit<Space>
nnoremap <Leader>s :write<CR>
nnoremap <Leader>q :quit!<CR>

" Tabbing.
nnoremap <Leader>t :tabedit<CR>:edit<Space>

" Split window navigation: [left] [down] [up] [right].
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" Make arrows resize splits.
nnoremap <Left>  <C-w><
nnoremap <Down>  <C-w>-
nnoremap <Up>    <C-w>+
nnoremap <Right> <C-w>>

" Search and replace.
nnoremap <Leader>r :%s//g<Left><Left>
vnoremap <Leader>r :s//g<Left><Left>

" Make.
nnoremap <silent> <Leader>mk :Make<CR>

" Primitive surrounding capability.
nmap <silent> gs <Plug>Surround

" Highlight the current match when searching with n/N.
nmap <silent> n <Plug>searchn
nmap <silent> N <Plug>searchN

" Commenting.
nmap <silent> <C-_> <Plug>Comment

" Strip trailing whitespace.
nmap <silent> <Leader><BS> <Plug>StripTrail

" Tab triggers text completion.
imap <Tab>   <Plug>Completion
imap <S-Tab> <Plug>PrevCompletion

" Auto open/close braces.
inoremap { {}<C-g>U<Left>
inoremap ( ()<C-g>U<Left>
inoremap [ []<C-g>U<Left>
imap } <Plug>Match}
imap ) <Plug>Match)
imap ] <Plug>Match]

" Autoindent and open braces.
imap <CR> <Plug>Expand{}

" Auto open/close quotes.
imap " <Plug>Match"
imap ' <Plug>Match'

" Autoremove paired braces and quotes.
imap <BS> <Plug>RemoveMatch
