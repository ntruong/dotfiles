" Name: Vim Configuration
" Author: Nicholas Truong
"===============================================================================

"===============================================================================
""" BASIC OPTION SETTING:
set encoding=utf-8          " Use UTF-8
set previewheight=20        " Preview window height
set number                  " Line numbering
set relativenumber          " Relative line numbering
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
nnoremap <Leader>s :w<CR>
nnoremap <Leader>q :q!<CR>
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
" Make and quickfix stuff
nnoremap <silent> <Leader>mk :make!<CR>
nnoremap <Leader>cc :tabnew<CR>:copen<CR>
nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprev<CR>
"===============================================================================

"===============================================================================
""" TEXT FUNCTIONS:
" Autocomplete
function! Tabbed_Autocomplete() abort
  if col(".")>1 && strpart(getline("."), col(".") - 2, 3) =~ '^\w'
    return "\<C-n>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-r>=Tabbed_Autocomplete()<CR>
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
  let begin = strpart(getline("."), 0, strlen(b:commentflag))
  let c = col(".")
  if begin == b:commentflag
    let c -= strlen(b:commentflag) + 1
    let c = (c > 0) ? c : 0
    return "\<Esc>0".(strlen(b:commentflag) + 1)."x".c."|"
  else
    let c += strlen(b:commentflag) + 1
    return "\<Esc>0i".b:commentflag." \<Esc>".c."|"
  endif
endfunction
nnoremap <C-_> i<C-r>=Autocomment()<CR>
inoremap <C-_> <C-r>=Autocomment()<CR>i
" Strip trailing whitespace
function! Strip_Trail() abort
  let search=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=search
  call cursor(l, c)
endfunction
nnoremap <silent> <Leader><BS> :call Strip_Trail()<CR>
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
function! AES_Flags() abort
  let l:flags = ""
  let l:flags .= (&modified ? " [+] " : "")  " Modified flag
  let l:flags .= (&readonly ? " [-] " : "")  " Readonly flag
  let l:flags .= (&pvw ? " [preview] " : "") " Preview flag
  return l:flags
endfunction
" Statusline
function! Git_Branch() abort
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction
function! SL_Git_Branch() abort
  let l:branchname = Git_Branch()
  return (strlen(l:branchname) > 0) ? l:branchname : "local"
endfunction
set statusline=
set statusline+=\ %y\                    " File type
set statusline+=\ %.40f\                 " File path
set statusline+=%{AES_Flags()}           " Flags
set statusline+=%=                       " Right side
set statusline+=\ [%3l                   " Current line
set statusline+=/%-3L]:                  " Total lines
set statusline+=[%2v]\                   " Virtual column number
set statusline+=\ %{&fileformat}         " File format
set statusline+=/%{&fileencoding?&fileencoding:&encoding}\  " File encoding
set statusline+=\ <%{SL_Git_Branch()}\   " Git branch
" Tabline
function! TL_Make() abort
  let tl = ""
  let wn = ""
  let active = tabpagenr()
  let i = 1
  while i <= tabpagenr("$")
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)
    let bufnr = buflist[winnr - 1]
    let file = bufname(bufnr)
    let buftype = getbufvar(bufnr, "buftype")
    if buftype == "nofile"
      if file =~"\/."
        let file = substitute(file, ".*\/\ze.", "", "")
      endif
    else
      let file = fnamemodify(file, ":p:t")
    endif
    if file == ""
      let file = "[blank]"
    endif
    let tl .= (i == active) ? "%#TabLineSel# " : "%#TabLine# "
    let tl .= file
    let tl .= " %*"
    let i += 1
  endwhile
  let tl .= "%#TabLineFill#%=%{AES_Flags()}%*"
  return tl
endfunction
set showtabline=2
if exists("+showtabline")
  set tabline=%!TL_Make()
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
" .vim file loader
function! Load_File(file) abort
  if !empty(globpath(&runtimepath, a:file))
    execute "source " . globpath(&runtimepath, a:file)
  endif
endfunction
if matchstr(&runtimepath, $HOME."/.vim/lang") == ""
  let &runtimepath.=",".$HOME."/.vim/lang"
endif
augroup au_langs
  autocmd!
  " C/C++
  autocmd filetype c,cpp call Load_File("c.vim")
  " Haskell
  autocmd filetype haskell setlocal makeprg=stack\ build
  autocmd filetype haskell setlocal errorformat=
    \%E%>%f:%l:%c:\ error:,
    \%W%>%f:%l:%c:\ warning:,
    \%Z\ %\\+%m,
    \%-G%.#
  autocmd filetype haskell let b:commentflag = "%"
  " Java
  autocmd filetype java call Load_File("java.vim")
  " LaTeX
  let g:tex_flavor = "latex"
  autocmd filetype tex call Load_File("tex.vim")
  " Markdown
  autocmd filetype md,markdown call Load_File("md.vim")
  " Python
  autocmd filetype python call Load_File("python.vim")
  " R
  autocmd filetype r call Load_File("r.vim")
  " VimScript
  autocmd filetype vim call Load_File("vim.vim")
augroup END
"===============================================================================
