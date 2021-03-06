" Name: Nvim Configuration
" Author: Nicholas Truong

""" Option settings.
colorscheme iridescence
set hidden                    " Hide buffers with changes
set textwidth=80              " Keep columns legible
set scrolloff=3               " Keep 3 lines above and below cursor
set inccommand=nosplit        " Incremental commands
set expandtab                 " Insert tabs as spaces
set tabstop=2                 " Number of spaces a tab counts for
set shiftwidth=2              " Number of spaces a tab counts for
set nojoinspaces              " No double space when joining lines
set noswapfile                " No swapfile
set wildignorecase            " Ignore case in wildmenu
set showtabline=2             " Tabline always visible
set fillchars=vert:\ ,diff:\  " Make split separators invisible
let g:tex_flavor = "latex"    " Default tex flavor is LaTeX

""" Keymaps.
" Escape.
tnoremap <Esc> <C-\><C-n>

" Clear highlighting.
nnoremap <silent> <Esc> :nohlsearch<CR>

" Localize directory.
nnoremap <silent> <Space>cd :lcd %:p:h<CR>:echo "Localized directory."<CR>

" Buffer switching.
nnoremap gb :ls<CR>:buffer
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>

" Split window navigation.
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
nnoremap S :%s//g<Left><Left>
vnoremap S :s//g<Left><Left>

" Make.
nnoremap <silent> <Space>mk :Make<CR>

" Autoexpand braces on enter.
inoremap {<CR> {}<C-g>U<Left><CR><C-o>O

" Automatically correct spelling mistakes.
inoremap <C-l> <C-g>u<Esc>[s1z=`]a<C-g>u

" Align text using column (and use only one space to separate).
let &equalprg='column -t | sed "s/\( *\) /\1/g"'

" Scratch buffer.
command! New :new | setlocal nobuflisted noswapfile buftype=nofile

" Primitive surrounding/deleting capability.
nmap gs <Plug>Surround

" Commenting.
nmap <silent> <C-_> <Plug>Comment

" Strip trailing whitespace.
nmap <silent> d<BS> <Plug>StripTrail

" Tab triggers text completion.
imap <Tab>   <Plug>Completion
imap <S-Tab> <Plug>PrevCompletion
