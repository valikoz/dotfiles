" source $VIMRUNTIME/defaults.vim

" set nocompatible
" set autochdir
if exists("&autocomplete")
  set autocomplete
endif
set belloff=all
set dir=/var/tmp//,/tmp
set incsearch
set breakindent
set clipboard=unnamedplus
set cmdheight=1
set cmdwinheight=3
"set completeopt=fuzzy,menu,menuone,noselect,noinsert "preview
set completeopt=menu,menuone,noselect,noinsert
set conceallevel=0
set confirm
set cursorline
set expandtab
set foldlevel=99
set foldlevelstart=4
set foldmethod=expr
set foldnestmax=4
"set grepformat=%f:%l:%c:%m
"set grepprg=rg\ --vimgrep\ -uu
set hlsearch
set ignorecase
set infercase
set laststatus=1
set lcs=tab:│→,trail:·
set linebreak
set list
set mouse=a
set nocopyindent
"set notimeout
set number
set preserveindent
set pumheight=10
set relativenumber
set scrolloff=4
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
"set rtp+=/opt/local/share/fzf/vim

let g:netrw_banner=0
" let g:netrw_hide=1
" let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
"Change the cursor between normal and insert modes
let &t_SI="\e[6 q"
let &t_EI="\e[2 q"

if $TERM_PROGRAM!='Apple_Terminal'
  set termguicolors "enable 24-bit RGB color in the TUI
endif
" Macvim
" set lines=35 columns=115
" set gfn=JetBrainsMonoNLNFM-Regular:h16
" set gfw=JetBrainsMonoNLNFM-Bold

command DelMarks :delm a-zA-Z
command Vimrc :e ~/.vimrc
command Config :e ~/.vim
command Bashrc :e ~/.bashrc
command Tmux :e ~/.tmux.conf
command Rustup :silent!! rustup doc
command SnipMateEditSnippets :e ~/.vim/pack/msanders/start/snipmate.vim/snippets/ | sp ~/.vim/snippets/
command Format :silent! %s/\s\+$//e

command Retab
  \ if &expandtab == v:true
  \ |		set noexpandtab  | retab!
  \ |	else
  \ |		set expandtab | retab
  \ |	endif

"Toggle line numbers
command Ln
  \ if &rnu != 1 && &nu != 1
  \ |		set   nu   rnu
  \ |	else
  \ |		set nonu nornu
  \ |	endif

nnoremap <space>w <Cmd>w<CR>
nnoremap <space>m <Cmd>make!<CR>
"Highlight a word under cursor
nnoremap <space>* <Cmd>let @/=expand('<cword>') <bar> set hls<CR>
"Toggle netrw
nnoremap <space>e	<Cmd>exe (&ft == 'netrw' ? 'sil! e #' : 'e %:p:h')<CR>
noremap ' `

noremap <C-s> :sh<cr>
tmap <C-H>	<C-\><C-n>
imap <S-Tab>	<C-V><Tab>

inoremap <C-]>	<C-X><C-]>
inoremap <C-F>	<C-X><C-F>
inoremap <C-L>	<C-X><C-L>

function! s:BlankUp() abort
  return 'put!=repeat(nr2char(10), v:count1)|silent '']+'
endfunction

function! s:BlankDown() abort
  return 'put =repeat(nr2char(10), v:count1)|silent ''[-'
endfunction

nnoremap <silent> [<Space> :<C-U>exe <SID>BlankUp()<CR>
nnoremap <silent> ]<Space> :<C-U>exe <SID>BlankDown()<CR>
nnoremap ]q :cn<cr>
nnoremap [q :cp<cr>

"Expand Enter
"imap <M-CR>	<c-g>u<CR><Cmd>normal! ====<CR><up><end><CR>

vmap <S-Tab>	<gv
vmap <Tab>	>gv
xmap +	g<C-a>gv
xmap -	g<C-x>gv

"Resize windows
"The .. operator is preferred, but only supported in since Vim 8.1.1114
nmap <M-e>	<cmd>execute 'resize -' . (v:count > 0 ? v:count : '2')<CR>
nmap <M-s>	<cmd>execute 'vertical resize -' . (v:count > 0 ? v:count : '2')<CR>
nmap <M-d>	<cmd>execute 'resize +' . (v:count > 0 ? v:count : '2')<CR>
nmap <M-f>	<cmd>execute 'vertical resize +' . (v:count > 0 ? v:count : '2')<CR>

"Keep selection while moving cursor
"With <Cmd> tricks with |gv| are not needed, see :h <Cmd>.
"The command is also not echo'ed, no need for <silent>.
vnoremap <C-j>	<Cmd>execute 'normal ' . v:count1 . 'jo' . v:count1 . 'jo'<CR>
vnoremap <C-k>	<Cmd>execute 'normal ' . v:count1 . 'ko' . v:count1 . 'ko'<CR>
vnoremap <C-l>	<Cmd>execute 'normal ' . v:count1 . 'lo' . v:count1 . 'lo'<CR>
vnoremap <C-h>	<Cmd>execute 'normal ' . v:count1 . 'ho' . v:count1 . 'ho'<CR>

"Move lines up/down with no indentation
"silent! to hide Invalid range error
nnoremap <A-j>	<Cmd>silent! exe "m .+" . v:count1<CR>
nnoremap <A-k>	<Cmd>silent! exe "m .-" . (v:count1 + 1)<CR>
inoremap <A-j>	<Cmd>silent! m .+1<CR>
inoremap <A-k>	<Cmd>silent! m .-2<CR>
vnoremap <silent> <A-j>	:<C-u>sil! exe "'<,'>m '>+" . v:count1<CR><ESC>gv
vnoremap <silent> <A-k>	:<C-u>sil! exe "'<,'>m '<-" . (v:count1 + 1)<CR><ESC>gv
"Move lines up/down with indentation (might be slow)
nmap <A-J>	<A-j>==
nmap <A-K>	<A-k>==
"imap <A-J>	<A-j><Esc>==gi
"imap <A-K>	<A-k><Esc>==gi
vmap <silent> <A-J>	<A-j>=gv
vmap <silent> <A-K>	<A-k>=gv

"Original cursor location in the line (or selection) by first getting it with
"virtcol() then can be restoring with |{col}.
function SwapAll() range
  if a:firstline != a:lastline
    if a:firstline < a:lastline
      let first=a:firstline
      let last=a:lastline
    else
      let first=a:lastline
      let last=a:firstline
    endif
    while first < last
      exec first.'m'.last.'|'.(last-1).'m'.(first-1)
      let first=first+1
      let last=last-1
    endwhile
  endif
endfunction

vnoremap <silent> <M-x>	:call SwapAll()<CR>

augroup Custom_Colors
    autocmd!
    " autocmd ColorScheme * hi Visual ctermfg=NONE guifg=NONE guibg=#4f5258
    autocmd ColorScheme * hi! link netrwMarkFile Search
augroup END

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

filetype plugin indent on
syntax on
colorscheme habamax
