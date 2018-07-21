" Name: Vim Configuration
" Author: Nicholas Truong
"===============================================================================

"===============================================================================
""" BASIC OPTION SETTING:
set encoding=utf-8          " Use UTF-8
set previewheight=20        " Preview window height
set cursorline              " Highlight current line
set scrolloff=3             " Keep 3 lines above and below cursor
set wrap                    " Word wrap
set expandtab               " Insert tabs as spaces
set inccommand=nosplit      " Incremental commands
set tabstop=2               " Number of spaces a tab counts for
set shiftwidth=2            " Number of spaces a tab counts for
set noswapfile              " No swapfile
"===============================================================================

"===============================================================================
""" KEYMAPS:
" Leader
let mapleader = "\<Space>"
" Escape
inoremap jk <Esc>
" Localize directory
nnoremap <silent> <Leader>cd :lcd %:p:h<CR>:echo "Localized directory."<CR>
" File opening: [open in window], [save], [save and exit], [exit]
nnoremap <Leader>o :edit<Space>
nnoremap <Leader>s :write<CR>
nnoremap <Leader>q :quit!<CR>
nnoremap <Leader>Q :tabclose!<CR>
" Tabbing: [new tab], [next tab], [previous tab]
nnoremap <Leader>t :tabedit<CR>:edit<Space>
" Split window navigation: [left] [down] [up] [right]
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
" Search and replace
nnoremap <Leader>r :%s//g<Left><Left>
vnoremap <Leader>r :s//g<Left><Left>
" Keep only important jumps on the jumplist
nnoremap  / m`:keepjumps /
nnoremap <silent> { :keepjumps normal! {<CR>
nnoremap <silent> } :keepjumps normal! }<CR>
nnoremap <silent> # :keepjumps normal! *#<CR>
nnoremap <silent> * :keepjumps normal! #*<CR>
" Make and quickfix stuff
nnoremap <silent> <Leader>mk :make!<CR>
nnoremap <Leader>cc :tabnew<CR>:copen<CR>
nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprev<CR>
"===============================================================================

"===============================================================================
""" TEXT FUNCTIONS:
" Autocomplete
function! TabToAutocomplete() abort
  if col(".")>1 && strpart(getline("."), col(".") - 2, 3) =~ '^\w'
    return "\<C-n>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-r>=TabToAutocomplete()<CR>
" Autoclose braces
function! Match_Close(open, close) abort
  let l:str = getline(".")
  let l:value = a:close
  if strpart(l:str, col(".") - 1, 1) == a:close
    let i = 0
    let len = strlen(str)
    let matches = 0
    while i < len
      let c = strpart(str, i, 1)
      if c == a:open
        let matches += 1
      elseif c == a:close
        let matches -= 1
      endif
      let i += 1
    endwhile
    if matches == 0
      let value = "\<Right>"
    endif
  endif
  return value
endfunction
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap } <C-r>=Match_Close("{", "}")<CR>
inoremap ) <C-r>=Match_Close("(", ")")<CR>
inoremap ] <C-r>=Match_Close("[", "]")<CR>
" Autoclose quotes
function! Match_Quote(ch) abort
  let line = getline(".")
  let value = ""
  let i = 0
  let len = strlen(line)
  let chcount = 0
  while i < len
    let c = strpart(line, i, 1)
    if c == a:ch
      let chcount += 1
    endif
    let i += 1
  endwhile
  if (chcount % 2 == 0)
    if strpart(line, col(".") - 1, 1) == a:ch
      let value = "\<Right>"
    else
      let value = a:ch.a:ch."\<Left>"
    endif
  else
    let value = a:ch
  endif
  return value
endfunction
inoremap " <C-r>=Match_Quote("\"")<CR>
inoremap ' <C-r>=Match_Quote("\'")<CR>
" Autoremove paired braces and quotes
function! Match_Remove() abort
  let pair_dict = {"{": "}", "(": ")", "[": "]", "\"": "\"", "\'": "\'"}
  let fst = strpart(getline("."), col(".") - 2, 1)
  let snd = strpart(getline("."), col(".") - 1, 1)
  if has_key(pair_dict, fst) && (pair_dict[fst] == strpart(getline("."), col(".") - 1, 1))
    return "\<Right>\<BS>\<BS>"
  endif
  return "\<BS>"
endfunction
inoremap <BS> <C-r>=Match_Remove()<CR>
" Autoindent and open braces
function! Brace_Opener() abort
  let fst = strpart(getline("."), col(".") - 2, 1)
  if (strpart(getline("."), col(".") - 2, 1) == "{") && (strpart(getline("."), col(".") - 1, 1) == "}")
    return "\<CR>\<CR>\<Up>\<Tab>"
  endif
  return "\<CR>"
endfunction
inoremap <CR> <C-r>=Brace_Opener()<CR>
" Autocommenting
function! Autocomment() abort
  if !exists("b:comment")
    return
  endif
  let l:line  = getline(".")
  let l:begin = strpart(l:line, match(l:line, '\S'), strlen(b:comment))
  let l:c     = col(".")
  let l:cmd   = ""
  if l:begin == b:comment
    let l:c -= strlen(b:comment) + 1
    let l:c = (l:c > 0) ? l:c : 0
    execute "normal! _dW"
  else
    let l:c += strlen(b:comment) + 1
    execute "normal! I" . b:comment . " "
  endif
  call cursor(".", l:c)
endfunction
nnoremap <silent> <C-_> :call Autocomment()<CR>
" Strip trailing whitespace
function! StripTrail() abort
  let search=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=search
  call cursor(l, c)
endfunction
nnoremap <silent> <Leader><BS> :call StripTrail()<CR>
" Primitive surrounding capability
function! Surround() abort
  let l:pairs = {
  \ "(" : "()",
  \ "[" : "[]",
  \ "{" : "{}",
  \ "<" : "<>"
  \ }
  let l:char = nr2char(getchar())
  let l:pair = has_key(l:pairs, l:char) ? l:pairs[l:char] : l:char . l:char
  let l:obj = nr2char(getchar())
  if index(["w", "W"], l:obj) >= 0
    execute "normal! ci" . l:obj . l:pair . "\<Esc>P"
  elseif index(["(", "[", "{"], l:obj) >= 0
    execute "normal! ca" . l:obj . l:pair . "\<Esc>P"
  endif
endfunction
nnoremap <silent> ys :call Surround()<CR>
"===============================================================================

"===============================================================================
""" AESTHETICS:
set background=dark
" Colorscheme
set termguicolors
colorscheme oblivion
" Display characters over 80th column
augroup au_display
  autocmd!
  " Trailing whitespace
  autocmd InsertEnter * setlocal nolist
  autocmd InsertLeave * setlocal list
  " Cursorline on active window
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END
" Buffer flags
function! Modifiers() abort
  let l:flags = ""
  let l:flags .= (&modified ? " [+] " : "")  " Modified flag
  let l:flags .= (&readonly ? " [-] " : "")  " Readonly flag
  let l:flags .= (&pvw ? " [preview] " : "") " Preview flag
  return l:flags
endfunction
" Statusline
set statusline=
set statusline+=\ %y\                    " File type
set statusline+=\ %.40f\                 " File path
set statusline+=%{Modifiers()}           " Flags
set statusline+=%=                       " Right side
set statusline+=\ [%3l                   " Current line
set statusline+=/%-3L]:                  " Total lines
set statusline+=[%2v]\                   " Virtual column number
set statusline+=\ %{&fileformat}         " File format
set statusline+=/%{&fileencoding?&fileencoding:&encoding}\  " File encoding
" Tabline
function! Tabline() abort
  let tl = ""
  for i in range(tabpagenr("$"))
    let tabnr   = i + 1
    let winnr   = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr   = buflist[winnr - 1]
    let file    = fnamemodify(bufname(bufnr), ":t")
    let tl .= (tabnr == tabpagenr()) ? "%#TabLineSel# " : "%#TabLine# "
    let tl .= empty(file) ? "[blank]" : file
    let tl .= " %*"
  endfor
  let tl .= "%#TabLineFill#"
  return tl
endfunction
set showtabline=2
if exists("+showtabline")
  set tabline=%!Tabline()
endif
" Colorscheme tools
nnoremap <silent> <Leader>S :echo
      \"<".synIDattr(synID(line("."),col("."),1),"name").">".
      \"<".synIDattr(synID(line("."),col("."),0), "name").">".
      \"<".synIDattr(synIDtrans(synID(line("."),col("."),1)),"name").">"<CR>
nnoremap <Leader>;; yy:@"<CR>
"===============================================================================

"===============================================================================
""" TAGGING:
set tags=./tags;,tags;./.tags;,.tags;
command! MakeTags !ctags -Rf .tags *
" Keymaps: [make tags], [next tag], [previous tag], [preview tag]
nnoremap <silent> <Leader>[] :MakeTags<CR><CR>:echo "Made tags."<CR>
nnoremap <Leader>] <C-w>}
"===============================================================================

"===============================================================================
""" FILETYPE SPECIFIC:
augroup Commenting
  autocmd!
  autocmd filetype c,cpp   let b:comment = "//"
  autocmd filetype haskell let b:comment = "--"
  autocmd filetype java    let b:comment = "//"
  autocmd filetype tex     let b:comment = "%"
  autocmd filetype python  let b:comment = "#"
  autocmd filetype r       let b:comment = "#"
  autocmd filetype vim     let b:comment = "\""
  let g:tex_flavor = "latex"
augroup END
"===============================================================================
