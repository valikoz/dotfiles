" source $VIMRUNTIME/defaults.vim

filetype plugin indent on
syntax on

" set autochdir
if exists("&autocomplete")
  set autocomplete
endif
set belloff=all
set incsearch
set breakindent
set clipboard=unnamedplus
set cmdheight=1
set cmdwinheight=3
set completeopt=menu,menuone,noselect,noinsert
set conceallevel=0
set confirm
set cursorline
set expandtab
set foldlevel=99
set foldlevelstart=4
set foldmethod=expr
set foldnestmax=4
set formatoptions+=j
set grepprg=grep\ -rn\ $*\ /dev/null
set hidden
set hlsearch
set ignorecase
set infercase
set laststatus=1
set lcs=tab:│→,trail:·
set linebreak
set list
set mouse=a
set nocopyindent
set nomodelineexpr
set nostartofline
"set notimeout
" set number
set preserveindent
set pumheight=10
" set relativenumber
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize,globals,localoptions,tabpages
set scrolloff=0
set shiftwidth=0
set showbreak=↪\ " keep space
set showtabline=2
set signcolumn=no
set smartcase
set splitbelow
set splitkeep=screen
set splitright
set swapfile
set tabstop=2
set timeout timeoutlen=3000 ttimeoutlen=100
set title
set undofile
set updatetime=300
set virtualedit=block "allow virtual editing in Visual block mode
set wrap
set wildmode=full:lastused

if has('unix')
  if !isdirectory($HOME . "/.vim/swap")
    call mkdir($HOME . "/.vim/swap", "p", 0700)
  endif
  set dir=~/.vim/swap
  if !isdirectory($HOME . "/.vim/undo")
    call mkdir($HOME . "/.vim/undo", "p", 0700)
  endif
  set undodir=~/.vim/undo
endif

let g:netrw_banner=0
let g:netrw_keepdir=0
" let g:netrw_hide=1
" let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
"Change the cursor between normal and insert modes
let &t_SI="\e[6 q"
let &t_EI="\e[2 q"

if $TERM_PROGRAM!='Apple_Terminal'
  set termguicolors "enable 24-bit RGB color in the TUI
endif

if has("gui_running")
  if has("gui_macvim")
    :set guifont=JetBrainsMonoNLNFM-Regular:h16
    :set lines=999 columns=9999
    :set macmeta
  endif
endif

command Delm :delm a-zA-Z
command Vimrc :e ~/.vimrc
command Config :e ~/.vim
command Bashrc :e ~/.bashrc
command Tmux :e ~/.tmux.conf
command Format :silent! %s/\s\+$//e
command Date :norm msHmtgg/Last [cC]hange:\s*/e+1<CR>"_D"=strftime("%Y %b %d")<CR>p'tzt`s
command SnipMateEditSnippets :e ~/.vim/pack/_/start/snipmate.vim/snippets/

command Retab
  \ if &expandtab == v:true
  \ |   set noexpandtab | retab!
  \ | else
  \ |   set expandtab | retab
  \ | endif

"Toggle line numbers
command Ln
  \ if &rnu != 1 && &nu != 1
  \ |   set nu rnu
  \ | else
  \ |   set nonu nornu
  \ | endif

function! Synctex(filepath)
  execute "call system('zathura --synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . " -x \"vim --servername gvim --remote +%{line} %{input}\" " . a:filepath . " &')"
  redraw!
endfunction

command -nargs=1 -complete=file Synctex :call Synctex(fnamemodify(<q-args>, ":p"))

nnoremap <space>w <Cmd>w<CR>
nnoremap <space>m <Cmd>make!<CR>
"Highlight a word under cursor
nnoremap <space>* <Cmd>let @/=expand('<cword>') <bar> set hls<CR>
"Toggle netrw
nnoremap <space>e <Cmd>exe (&ft == 'netrw' ? 'sil! e #' : 'e %:p:h')<CR>
nnoremap <space>s :sil cex system('')<C-F><Left>i

" function! AsyncJob(cmd)
"   let s:buf_name = 'dummy'
"   if bufexists(s:buf_name)
"     let s:bufnr = bufnr(s:buf_name)
"   endif

"   let g:dummy = job_start(a:cmd, { 'err_io': 'buffer', 'out_io': 'buffer', 'err_name': s:buf_name, 'out_name': s:buf_name, 'pty': 1, 'out_msg': 0})
" endfunction

" command -nargs=* -complete=shellcmd Dummy :call AsyncJob(<q-args>)

tmap <C-H> <C-\><C-n>
imap <S-Tab> <C-V><Tab>

"" Uncomment, when switch to a better terminal

"noremap <C-s> :sh<cr>
""Duplicate line
"inoremap <C-,> <Cmd>t.<CR>
"nnoremap <C-,> <Cmd>t.<CR>
""Move lines up/down with no indentation
""silent! to hide Invalid range error
"nnoremap <M-n> <Cmd>silent! exe "m .+" . v:count1<CR>
"nnoremap <M-p> <Cmd>silent! exe "m .-" . (v:count1 + 1)<CR>
"inoremap <M-n> <Cmd>silent! m .+1<CR>
"inoremap <M-p> <Cmd>silent! m .-2<CR>
"vnoremap <silent> <M-n> :<C-u>sil! exe "'<,'>m '>+" . v:count1<CR><ESC>gv
"vnoremap <silent> <M-p> :<C-u>sil! exe "'<,'>m '<-" . (v:count1 + 1)<CR><ESC>gv
""Move lines up/down with indentation (might be slow)
"nmap <M-N> <M-n>==
"nmap <M-P> <M-p>==
"imap <M-N> <M-n><Esc>==gi
"imap <M-P> <M-p><Esc>==gi
"vmap <silent> <M-N> <M-n>=gv
"vmap <silent> <M-P> <M-p>=gv

"Completion
inoremap <C-]> <C-X><C-]>
inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>

nnoremap <silent> [<Space> :<C-U>exe <SID>BlankUp()<CR>
nnoremap <silent> ]<Space> :<C-U>exe <SID>BlankDown()<CR>

function! s:BlankUp() abort
  return 'put!=repeat(nr2char(10), v:count1)|silent '']+'
endfunction

function! s:BlankDown() abort
  return 'put =repeat(nr2char(10), v:count1)|silent ''[-'
endfunction

nnoremap ]q :cn<cr>
nnoremap [q :cp<cr>

" Readline-style mappings for command-line mode
" start of line
cnoremap <C-A> <Home>
" delete character under cursor
cnoremap <C-D> <Del>
" end of line
cnoremap <C-E> <End>

" Scrolling in Insert mode
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>

vmap <S-Tab> <gv
vmap <Tab> >gv
xmap + g<C-a>gv
xmap - g<C-x>gv

"Keep selection while moving cursor
"With <Cmd> tricks with |gv| are not needed, see :h <Cmd>.
"The command is also not echo'ed, no need for <silent>.
vnoremap <C-j>  <Cmd>execute 'normal ' . v:count1 . 'jo' . v:count1 . 'jo'<CR>
vnoremap <C-k>  <Cmd>execute 'normal ' . v:count1 . 'ko' . v:count1 . 'ko'<CR>
vnoremap <C-l>  <Cmd>execute 'normal ' . v:count1 . 'lo' . v:count1 . 'lo'<CR>
vnoremap <C-h>  <Cmd>execute 'normal ' . v:count1 . 'ho' . v:count1 . 'ho'<CR>

"Resize windows
"The .. operator is preferred, but only supported in since Vim 8.1.1114
nmap <M-e> <cmd>execute 'resize -' . (v:count > 0 ? v:count : '2')<CR>
nmap <M-s> <cmd>execute 'vertical resize -' . (v:count > 0 ? v:count : '2')<CR>
nmap <M-d> <cmd>execute 'resize +' . (v:count > 0 ? v:count : '2')<CR>
nmap <M-f> <cmd>execute 'vertical resize +' . (v:count > 0 ? v:count : '2')<CR>

nnoremap <silent> <C-l> <Cmd>nohl<CR><C-l>

let g:space_char = nr2char(32)
augroup Terminal_Settings
    autocmd!
    autocmd TerminalOpen * setlocal nonu nornu
    autocmd TerminalOpen * setlocal fillchars=eob:\ ",
    autocmd TerminalOpen * setlocal list!
augroup END

augroup Netrw_Mappings
    autocmd!
    autocmd FileType netrw nnoremap <buffer> g? :help netrw-quickmap<CR> | nnoremap <buffer> qo :below copen<CR>
augroup END

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" vim -b : edit binary using xxd-format!
augroup Binary
  autocmd!
  autocmd BufReadPre  *.bin set binary
  autocmd BufReadPost *.bin
    \ if &binary
    \ |   execute "silent %!xxd -c 32"
    \ |   set filetype=xxd
    \ |   redraw
    \ | endif
  autocmd BufWritePre *.bin
    \ if &binary
    \ |   let s:view = winsaveview()
    \ |   execute "silent %!xxd -r -c 32"
    \ | endif
  autocmd BufWritePost *.bin
    \ if &binary
    \ |   execute "silent %!xxd -c 32"
    \ |   set nomodified
    \ |   call winrestview(s:view)
    \ |   redraw
    \ | endif
augroup END

colorscheme habamax
hi! link netrwMarkFile Search
