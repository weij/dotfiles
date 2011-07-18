" Use Pathogen:
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" ================
" Ruby stuff
" ================
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END
" ================

let mapleader = ","

vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
vmap <Leader>bed "td?describe<cr>obed<tab><esc>"tpkdd/end<cr>o<esc>:nohl<cr>
map <Leader>cc :!cucumber %<CR>
map <Leader>co :TComment<CR>
map <Leader>d odebugger<cr>puts 'debugger'<esc>:w<cr>
map <Leader>gac :Gcommit -m -a ""<LEFT>
map <Leader>gc :Gcommit -m ""<LEFT>
map <Leader>gs :Gstatus<CR>
map <Leader>f :sp spec/factories.rb<CR>
map <Leader>fix :cnoremap % %<CR>
map <Leader>fa :sp test/factories.rb<CR>
map <Leader>h :CommandT<CR>
map <Leader>i mmgg=G`m<CR>
map <Leader>l :!ruby -I"test" -I"spec" %<CR>
map <Leader>m :Rmodel 
map <Leader>n :set nopaste<cr>
map <Leader>o ?def <CR>:nohl<CR>w"zy$:!ruby -I"test" <C-r>% -n <C-r>z<CR>
map <Leader>p :set paste<CR>i
map <Leader>rd :!bundle exec rspec % --format documentation<CR>
map <Leader>rf :CommandTFlush<CR>
map <Leader>rw :%s/\s\+$//
map <Leader>sc :sp db/schema.rb<cr>
map <Leader>se :let file_to_run = "<c-r>%"<cr>
map <Leader>sm :RSmodel 
map <Leader>snip :e ~/.vim/snippets/ruby.snippets<CR>
map <Leader>su :RSunittest 
map <Leader>sv :RSview 

" Execute the results of concatenating the strings below. last_run_file is set
" above.
map <Leader>r :exe '!ruby -I"test" -I"spec"' file_to_run<cr>

map <Leader>t :!ruby -I"test" -I"spec" %<CR>
map <Leader>u :Runittest 
map <Leader>vc :RVcontroller 
map <Leader>vf :RVfunctional 
map <Leader>vi :tabe ~/.vimrc<CR>
map <Leader>vu :RVunittest<CR>
map <Leader>vm :RVmodel 
map <Leader>vv :RVview 
map <Leader>w <C-w>w

map <C-h> :nohl<cr>
imap <C-l> <Space>=><Space>
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
map <C-t> <esc>:tabnew<CR>
map <C-x> <C-w>c
map <C-n> :cn<CR>
map <C-p> :cp<CR>

" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^

set nocompatible
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=500		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set autoindent
set showmatch
set nowrap
set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files
set autoread
set wmh=0
set viminfo+=!
set guioptions-=T
set guifont=Triskweline_10:h10
set et
set sw=2
set smarttab
set noincsearch
set ignorecase smartcase
set laststatus=2  " Always show status line.
set number 
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoindent " always set autoindenting on
set bg=light

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

" Set the tag file search order
set tags=./tags;

" Use _ as a word-separator
set iskeyword-=_

" Use Ack instead of grep
set grepprg=ack-grep

" Make the omnicomplete text readable
:highlight PmenuSel ctermfg=black

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

" Highlight the status line
highlight StatusLine ctermfg=blue ctermbg=yellow

" Format xml files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null" 

set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.

set nofoldenable " Say no to code folding...

command Q q " Bind :Q to :q
command Qall qall 

set statusline+=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Disable that goddamn 'Entering Ex mode. Type 'visual' to go to Normal mode.'
" that I trigger 40x a day.
map Q <Nop>

" Disable K looking stuff up
map K <Nop>

let g:CommandTMaxHeight=50
let g:CommandTMatchWindowAtTop=1

" When loading text files, wrap them and don't split up words.
au BufNewFile,BufRead *.txt setlocal wrap 
au BufNewFile,BufRead *.txt setlocal lbr



"
" ========================================================================
" End of things set by me.
" ========================================================================
















" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

endif " has("autocmd")
