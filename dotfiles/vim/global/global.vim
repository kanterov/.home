" Author: Susan Potter

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set paste
set viminfo^=!
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" store lots of :cmdline history
set history=2000
set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default
set ignorecase  "ignore case in search...
set smartcase   "except when using caps in the search
set nowrap      "dont wrap lines
set linebreak   "wrap lines at convenient points
set whichwrap+=<,>,[,]
set modelines=5
set cursorline

"set selection=exclusive
"set selectmode=mouse,key
"set mousemodel=popup
"set keymodel=startsel,stopsel

set clipboard+=unnamed  " Yanks go on clipboard instead.
set cf              " Enable error files & error jumping.
set autowrite       " Writes on make/shell commands
set ruler           " Ruler on
set nu              " Line numbers on
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)

" Set the font
set gfn=Inconsolata\ 14

" Formatting (some of these are for coding in C and C++)
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set autoindent
set smarttab
set expandtab

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set list
" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
" No blinking .
set novisualbell
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" gvim specific
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes

" Backups & Files
set backup                   " Enable creation of backup file.
set backupdir=~/.vim/backups " Where backups will go.
set directory=~/.vim/tmp     " Where temporary files will go.

" statusline setup
set statusline=%f       "tail of the filename
set statusline+=%{fugitive#statusline()}
set statusline+=%#warningmsg# " display a warning if fileformat isnt unix
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*
set statusline+=%#warningmsg# " display a warning if file encoding isnt utf-8
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*
set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag
set statusline+=%#error# " display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

set laststatus=2

" indent settings
set shiftwidth=2
set softtabstop=2
set expandtab

" folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=2       "deepest fold is 3 levels
set foldenable        "fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

" display tabs and trailing spaces
set list
set listchars=tab:\ \ ,extends:>,precedes:<

set formatoptions-=o "dont continue comments when pushing o/O

" vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

filetype plugin indent on

"some stuff to get the mouse going in term
set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

" Plugin dependent integration {{{

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Change which file opens after executing :Rails command
let g:rails_default_file='config/application.rb'

" Pathogen integration
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Setup VimChat settings
let g:vimchat_statusicon = 0
let g:vimchat_buddylistwidth = 35

" setup gist plugin settings
let g:gist_browser_command = 'w3m %URL%'
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_use_password_in_gitconfig = 0

" NERDTree settings
let g:NERDTreeChDirMode = '2'
let g:NERDTreeQuitOnOpen = '1'
nmap <silent> <F9> :NERDTreeToggle<CR>
nmap <S-F9> :call LoadProject(input("Project name? "))<CR>

" Session settings
nmap <C-S> :SessionList<CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to bufexplorer
nnoremap <C-B> :BufExplorer<CR>

"map to fuzzy finder text mate stylez
nnoremap <C-F> :FuzzyFinderFile<CR>

" }}}

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"mark syntax errors with :signs
let g:syntastic_enable_signs=1

syntax enable
set background=dark
let g:solarized_termcolors = &t_Co
let g:solarized_termtrans=1
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italics=1
colorscheme solarized

" TaskList keybindings
map <F3> <Esc>:TaskList<CR>

" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <M-p> <Esc>:cp<CR>
map <silent> <M-n> <Esc>:cn<CR>

" use Firefox tab shortcuts in vim
nmap <C-S-]> gt
nmap <C-S-[> gT
nmap <C-S-1> 1gt
nmap <C-S-3> 3gt
nmap <C-S-4> 4gt
nmap <C-S-5> 5gt
nmap <C-S-6> 6gt
nmap <C-S-7> 7gt
nmap <C-S-8> 8gt
nmap <C-S-9> 9gt
nmap <C-S-0> :tablast<CR>

" Wrap stuff...
command! -nargs=* Wrap set wrap linebreak nolist
vmap <M-j> gj
vmap <M-k> gk
vmap <M-0> g0
vmap <M-$> g$
vmap <M-^> g^
nmap <M-j> gj
nmap <M-k> gk
nmap <M-0> g0
nmap <M-$> g$
nmap <M-^> g^

" key bindings
" for tabs
nmap  <C-Tab>    <Esc>:tabn<CR>
nmap  <C-S-Tab>  <Esc>:tabp<CR>
nmap  <C-S-N>    <Esc>:tabnew<CR>

" Tab indenting sections of code
vmap <Tab> >gv
vmap <S-Tab> <gv

" Make highlighted area middle of screen for certain verbs/actions
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

if has("autocmd")
  augroup vimrc_autocmds
    autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
    autocmd BufEnter * match OverLength /\%78v.*/
    autocmd BufWritePre * :%s/\s\+$//e
  augroup END

  augroup fugitive_autocmds
    autocmd User fugitive if fugitive#buffer().type() =~# '^\%(tree\|blob\)' | nnoremap
    autocmd BufReadPost fugitive://* set bufhidden=delete
  augroup END
endif

