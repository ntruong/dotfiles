" Name: Vim Configuration
" Author: Nicholas Truong

""" Option settings.
syntax enable
filetype plugin indent on
colorscheme iridescence
set encoding=utf-8            " Use UTF-8
set hidden                    " Hide buffers with changes
set textwidth=80              " Keep columns legible
set scrolloff=3               " Keep 3 lines above and below cursor
set expandtab                 " Insert tabs as spaces
set tabstop=2                 " Number of spaces a tab counts for
set shiftwidth=2              " Number of spaces a tab counts for
set nojoinspaces              " No double space when joining lines
set noswapfile                " No swapfile
set wildignorecase            " Ignore case in wildmenu
set showtabline=2             " Tabline always visible
set laststatus=2              " Statusline always visible
set hlsearch                  " Highlight all search matches
set incsearch                 " Incrementally update search
set fillchars=vert:\ ,diff:\  " Make split separators invisible

""" Keymaps.
" Leader.
let mapleader = "\<Space>"

" Escape.
inoremap jk <Esc>
tnoremap <Esc> <C-\><C-n>

" Clear highlighting.
nnoremap <silent> <Esc> :nohlsearch<CR>:call clearmatches()<CR>

" Localize directory.
nnoremap <silent> <Leader>cd :lcd %:p:h<CR>:echo "Localized directory."<CR>

" Buffer switching.
nnoremap gb :ls<CR>:buffer

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
nnoremap S :%s//g<Left><Left>
vnoremap S :s//g<Left><Left>

" Make.
nnoremap <silent> <Leader>mk :make!<CR>

" Statusline.
set statusline=
set statusline+=%y        " File type
set statusline+=\ %.40f   " File path
set statusline+=%=        " Right side
set statusline+=\ %3(%m%) " Flags
set statusline+=\ [%3l,   " Line number
set statusline+=%-3.3c]   " Column number

" Tabline.
function! Tabline() abort
  let tl = ""
  for tabnr in range(1, tabpagenr("$"))
    let winnr   = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr   = buflist[winnr - 1]
    let file    = fnamemodify(bufname(bufnr), ":t")
    let file    = empty(file) ? "[No Name]" : file
    if tabnr == tabpagenr()
      let file = "%#TabLineSel#" . file . "%#TabLine#"
    endif
    let tl .= " " . file . " "
  endfor
  return "%#TabLine#" . tl . "%#TabLineFill#"
endfunction
set tabline=%!Tabline()
