" vim:fdm=marker

" Platform independent vim folder
if has("win32")
    " define in 'outer' vimrc which sources this one
else
    if has("unix")
        let g:VIMFILES='~/.vim'
    endif
endif
" Vundle {{{
set nocompatible               " be iMproved
filetype off                   " required!

let &rtp.=','.g:VIMFILES.'/bundle/vundle/'
call vundle#rc()

" let Vundle manage Vundle. required!
Bundle 'gmarik/vundle'

" My Bundles here
" original repos on github
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Lokaltog/vim-powerline'
Bundle 'SirVer/ultisnips'
Bundle 'ervandew/supertab'
"Bundle 'jonasdiemer/LaTeX-Box'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'klen/python-mode'
Bundle 'bronson/vim-visual-star-search'
Bundle 'basilgor/vim-autotags'

" vim-scripts repos
"Bundle 'FuzzyFinder'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required!
" }}}

" Basic stuff {{{
" Appearance {{{
set nocompatible            	" choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
set number 			" enable line numbers
set t_Co=256
colorscheme xoria256 " also nice: wombat256mod, inkpot, pablo, torte            
let &colorcolumn="81,".join(range(81,511),",")  " highlight every col past 80
highlight ColorColumn guibg=#2d2d2d ctermbg=235
set laststatus=2 		" enable status line always
" }}}
" Basic Behavior {{{
set hidden          " don't close buffers
set clipboard=unnamed   " copy/paste works with rest of system
autocmd! bufwritepost .vimrc source %   " automatically reload vimrc on changes
set mouse=a " enable mouse
set ttymouse=xterm2 " enable dragging
" visually select pasted text
nnoremap gp `[v`]
"}}}
" Diff {{{
" turn wrap back on for diffs
autocmd FilterWritePre * if &diff | set wrap | endif
"}}}
" Autocompletion similar to bash {{{
set wildmenu
set wildmode=longest,list "completion like bash, cycle through options
set completeopt=longest,menu
" }}}
" Whitespace {{{
set wrap                      " wrap lines...
set linebreak  " ... at word borders
set textwidth=0                 " don't wrap during insert mode
set tabstop=4 shiftwidth=4      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
"smart indent/tab
set smartindent
set smarttab
" show trailing white space 
highlight ExtraWhitespace ctermbg=235 guibg=lightgreen 
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
"}}}
" Searching {{{
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
" reset highlights
nmap <leader>/ :nohlsearch<CR>
" }}}
" Spell Checking {{{
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
"set mousemodel=popup_setpos 	" right click -> popup
" find and highlight duplicate words TODO: only for latex
autocmd Syntax * syn match SpellRare /\v<(\w+)\_s+\1>/ containedin=ALL
" }}}
" Misc {{{

" Navigate with j,k in Insert Mode Completion (also for spell check)
"inoremap <expr> j pumvisible() ? "\<C-N>" : "j"
"inoremap <expr> k pumvisible() ? "\<C-P>" : "k"
"}}}
" easier split/tab navigation {{{
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
"}}}
" }}}

" Experimental {{{
set so=7 "keep some lines visible on scroll

" Unbind cursor/arrow keys for training
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

" Store swap/backup files in central position
exe 'silent !mkdir '.g:VIMFILES.'/backup/ 2>/dev/null'
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

" This allows for change paste motion cp{motion}
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction

" }}}

" EasyTags {{{
let g:easytags_by_filetype = "~/.vimtag"
" follow tag more like eclipse
:map <S-F3> :sp<CR><C-]>
" Disable automatic highlighting
"let b:easytags_auto_highlight = 0
" }}}

" NERDTree {{{
:nmap <C-n> :NERDTreeTabsToggle<CR>
let NERDTreeIgnore = ['\~$', '\.pyc$'] 
" }}}

" CtrlP {{{
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
" }}}

" Python Mode {{{
let g:pymode_lint_write = 1
let g:pymode_folding = 0        " disable slow folding
let g:pymode_lint_checker = 'pylint' "'pyflakes,pep8,mccabe,pylint'
" }}}

" Ultisnips {{{
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsListSnippets = "<s-tab>"
let g:UltiSnipsNoPythonWarning = 1
" }}}

" LatexBox {{{
let g:LatexBox_Folding = 1
" disable folding of environments
let g:LatexBox_fold_env = 0
" }}}

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

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

" syntastic on load
let g:syntastic_check_on_open=1
