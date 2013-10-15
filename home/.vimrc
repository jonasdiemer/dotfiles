" vim:fdm=marker   

" Platform independent vim folder{{{1
if has("win32")
    " define in 'outer' vimrc which sources this one
    set langmenu=en_US
    let $LANG = 'en_US'
    source $VIMRUNTIME\delmenu.vim
    source $VIMRUNTIME\menu.vim
elseif has("unix")
  let g:VIMFILES='~/.vim'
endif

" Vundle {{{1
set nocompatible               " be iMproved
filetype off                   " required!

let &rtp.=','.g:VIMFILES.'/bundle/vundle/'
call vundle#rc()

" let Vundle manage Vundle. required!
Bundle 'gmarik/vundle'

" My Bundles here
" original repos on github
" Appearance {{{2
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'mbbill/VimExplorer'
Bundle 'Lokaltog/vim-powerline'
Bundle 'moll/vim-bbye'
Bundle 'ervandew/supertab'
Bundle 'basepi/vim-conque'
Bundle 'bronson/vim-visual-star-search'
"Bundle 'mivok/vimtodo'
Bundle 'freitass/todo.txt-vim'
Bundle 'davidoc/taskpaper.vim'
"Bundle 'plasticboy/vim-markdown'
Bundle 'tpope/vim-markdown'
Bundle 'nelstrom/vim-markdown-folding'
"Bundle 'joeytwiddle/sexy_scroller.vim'
"Bundle 'bling/vim-airline'
"Bundle 'bling/vim-bufferline'
Bundle 'Lokaltog/vim-easymotion'
" Development {{{2
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/vcscommand.vim'
if !has("win32")
    Bundle 'basilgor/vim-autotags'
endif
" Language-specific {{{2
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'klen/python-mode'
Bundle 'davidoc/taskpaper.vim'
Bundle 'plasticboy/vim-markdown'

filetype plugin indent on     " required!

" Basic stuff {{{1
" Appearance {{{2
set nocompatible            	" choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
set relativenumber 			" enable relative line numbers
set t_Co=256
colorscheme xoria256 " also nice: wombat256mod, inkpot, pablo, torte
"let &colorcolumn="81,".join(range(81,511),",")  " highlight every col past 80
" Highlighting more than one column masks any other background highlighting,
" such as whitespace or TODO markers... So, highlight only the 81st column
let &colorcolumn="81"
highlight ColorColumn guibg=#2d2d2d ctermbg=235
set laststatus=2 		" enable status line always
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
else
  " This is console Vim.
  "if exists("+lines")
    "set lines=50
  "endif
  "if exists("+columns")
    "set columns=100
  "endif
endif
" Basic Behavior {{{2
set hidden          " don't close buffers
set clipboard=unnamed   " copy/paste works with rest of system
autocmd! bufwritepost .vimrc source %   " automatically reload vimrc on changes
set mouse=a " enable mouse
set ttymouse=xterm2 " enable dragging
" visually select pasted text
nnoremap gp `[v`]
" Diff {{{2
" turn wrap back on for diffs
autocmd FilterWritePre * if &diff | set wrap | endif

" Autocompletion similar to bash {{{2
set wildmenu
set wildmode=longest,list "completion like bash, cycle through options
set completeopt=longest,menu
" Whitespace {{{2
set wrap                      " wrap lines...
set linebreak  " ... at word borders
set textwidth=0                 " don't wrap during insert mode
set tabstop=4 shiftwidth=4      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
"smart indent/tab
" disabled, because it sucks in python set smartindent
"set smartindent
set smarttab
" show trailing white space 
highlight ExtraWhitespace ctermbg=235 guibg=#4d4d4d  
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
" Searching {{{2
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
" reset highlights
nmap <leader>/ :nohlsearch<CR>
" Spell Checking {{{2
" English by default
set spell spelllang=en_us
" Limit number of suggestions
set spellsuggest=fast,10
" mappings to switch
nmap <F12>us :setlocal spell spelllang=en_us <CR>
nmap <F12>c :setlocal nospell <CR>
nmap <F12>de :setlocal spell spelllang=de <CR>
" quick fix last mistake
imap <c-f> <c-g>u<Esc>[s1z=`]a<c-g>u
nmap <c-f> [s1z=<c-o>
" color of spelling mistakes
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
"set mousemodel=popup_setpos 	" right click -> popup
" find and highlight duplicate words TODO: only for latex
autocmd Syntax * syn match SpellRare /\v<(\w+)\_s+\1>/ containedin=ALL
" Misc {{{2

" Navigate with j,k in Insert Mode Completion (also for spell check)
"inoremap <expr> j pumvisible() ? "\<C-N>" : "j"
"inoremap <expr> k pumvisible() ? "\<C-P>" : "k"
" easier split/tab navigation {{{2
" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>
" tab navigation using tab
nnoremap <S-tab> :tabprevious<CR>
nnoremap <tab>   :tabnext<CR>
" Open existing tabs instead of creating duplicates
set switchbuf=usetab 

" Experimental {{{1
set so=7 "keep some lines visible on scroll

" Unbind cursor/arrow keys for training
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

" Store swap/backup files in central position
"exe 'silent !mkdir '.g:VIMFILES.'/backup/ 2>/dev/null'
let &backupdir = expand(g:VIMFILES.'/backup/')
let &directory = expand(g:VIMFILES.'/backup/')

" This allows for change paste motion cp{motion}
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction

" Plugin-Options {{{1
" EasyTags {{{2
let g:easytags_by_filetype = "~/.vimtag"
" follow tag more like eclipse
:map <S-F3> :sp<CR><C-]>
" Disable automatic highlighting
"let b:easytags_auto_highlight = 0

" Supertab {{{2
" Use omnicompletion by default.
let g:SuperTabDefaultCompletionType="<c-x><c-o>"

" NERDTree {{{2
:nmap <C-n> :NERDTreeTabsToggle<CR>
let NERDTreeIgnore = ['\~$', '\.pyc$'] 

" CtrlP {{{2
" ctrlp: keep cache
let g:ctrlp_clear_cache_on_exit = 0
" define working path mode
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'
" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$\|\.gvfs$\|\.cache$\|\.thumbnails$\|temp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$\|\.pdf$\|\.pyc$\|\.aux$'
  \ }
" ignore dotfiles/dotdirs
let g:ctrlp_dotfiles = 0
" speed up
let g:ctrlp_max_files = 10000
" Optimize file searching
" can not use g:ctrlp_custom_ignore['dir'] in grep...
let g:user_cmd_ignore = g:ctrlp_custom_ignore['file'] . '\|\.git\|\.hg\|\.svn'
if has("unix")
    let g:ctrlp_user_command = {
                \   'types': {
                \       1: ['.git/', 'cd %s && git ls-files']
                \   },
                \   'fallback': 'find %s -type f | grep -v "' . g:user_cmd_ignore .'" | head -' .  g:ctrlp_max_files,
                \   'ignore': 0
                \ }
endif

" Python Mode {{{2
if has('win32')
    " somehow broken on windows
    let g:pymode_lint_write = 0
endif
let g:pymode_folding = 1        " disable if slow 
let g:pymode_lint_checker = 'pylint' "'pyflakes,pep8,mccabe,pylint'

" Ultisnips {{{2
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsListSnippets = "<s-tab>"
let g:UltiSnipsNoPythonWarning = 1

" LatexBox {{{2
let g:LatexBox_Folding = 1
" disable folding of environments
let g:LatexBox_fold_env = 0
if has('mac')
  let g:LatexBox_viewer = 'open'
endif
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Taskpaper.vim {{{2
" do not follow moved tasks
let g:task_paper_follow_move = 0
" Hide done tasks during search
let g:task_paper_search_hide_done = 1

" Sexy Scroller {{{2
let g:SexyScroller_EasingStyle=2
let g:SexyScroller_MaxTime=400
let g:SexyScroller_ScrollTime=10

" Markdown {{{2
let g:markdown_fold_style = 'nested'

" Archive{{{1
" LATEX support for tagbar
let g:tagbar_type_tex = {
            \ 'ctagstype' : 'latex',
            \ 'kinds'     : [
                \ 's:sections',
                \ 'g:graphics:0:0',
                \ 'l:labels',
                \ 'r:refs:1:0',
                \ 'p:pagerefs:1:0'
            \ ],
            \ 'sort'    : 0,
        \ }

" TeX Suite default to PDF
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'dvi,pdf'

