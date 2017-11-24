"
"Core Stuff
set et
set sts=4
set sw=4
set nolist
set nocompatible

set wildmode=longest,list,full
set wildmenu
colorscheme desert
" set showbreak=↪\ 
" set listchars=tab:▶
" set listchars+=trail:◥
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
"
""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default


if v:version < 800
    finish
endif

map <leader>p "+p

nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>


function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

call plug#begin()
Plug 'rust-lang/rust.vim'
Plug 'will133/vim-dirdiff'
Plug 'vim-scripts/dbext.vim'
Plug 'mjbrownie/swapit'
if filereadable('Cargo.toml')
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim'

" (Optional) Completion integration with deoplete.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" (Optional) Completion integration with nvim-completion-manager.
Plug 'roxma/nvim-completion-manager'

" (Optional) Showing function signature and inline doc.
Plug 'Shougo/echodoc.vim'
else
Plug 'valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'tenfyzhong/CompleteParameter.vim'
endif
"Plug 'mjbrownie/YouCompleteMe', { 'do': function('BuildYCM') }
"Plug 'roxma/nvim-completion-manager'
Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'mjbrownie/vim-surround_django'
Plug 'mjbrownie/snipmate_for_django'
Plug 'mjbrownie/browser.vim'
Plug 'mjbrownie/vim-relativize'
Plug 'mjbrownie/swapit'
Plug 'mjbrownie/delete-surround-html'
Plug 'mjbrownie/django-template-textobjects'
Plug 'mjbrownie/html-textobjects'
Plug 'mjbrownie/snipmate_for_django'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'vim-syntastic/syntastic'
Plug 'sjl/gundo.vim'
Plug 'justinj/vim-react-snippets'
Plug 'kana/vim-textobj-user'
" Plug 'mjbrownie/vim-relafile'
" Plug 'mjbrownie/vim-relafile-django'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/tpope-vim-abolish'
Plug 'jiangmiao/auto-pairs'
Plug 'narfdotpl/selfdot.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'wlemuel/vim-ultisnips-redux'
Plug 'scrooloose/NerdTree'
Plug 'mjbrownie/GetFilePlus'
Plug 'junegunn/vim-easy-align'
Plug 'flazz/vim-colorschemes'
Plug 'adelarsq/vim-matchit'
Plug 'gcmt/taboo.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/QuickBuf'
"Plug 'powerline/powerline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle'  }
Plug 'mgedmin/pythonhelper.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-unimpaired'
"Plug 'roxma/vim-paste-easy'
Plug 'bps/vim-textobj-python'
Plug 'mattn/webapi-vim'
Plug 'tyru/open-browser.vim'
Plug 'Shougo/unite.vim'
Plug 'rafi/vim-unite-issue'
Plug 'machakann/vim-colorscheme-tatami'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/CmdlineComplete'
Plug 'benmills/vimux'
Plug 'tpope/vim-tbone'
Plug 'w0rp/ale'
Plug 'lifepillar/vim-solarized8'
Plug 'python-rope/ropevim'
Plug 'racer-rust/vim-racer'
call plug#end()

let g:NERDTreeUpdateOnCursorHold = 0
let g:airline#extensions#tabline#enabled = 1

" Add the virtualenv's site-packages to vim path
if has("python")
py << EOF
import os.path
import sys
import vim

if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))

#Old school project assumptions. Note This assumes pwd is project dir
if os.path.exists('settings.py'):
    os.environ['DJANGO_SETTINGS_MODULE'] = 'settings'
else:
    #look for django 1.4 style settings eg /<project>/<project>/settings.py
    #created by a django_admin.py startproject
    cur_dir = os.path.join(os.getcwd().split('/').pop())
    if os.path.exists(os.path.join(cur_dir,'settings.py')):
        os.environ['DJANGO_SETTINGS_MODULE'] = '%s.settings' % cur_dir
    # https://github.com/scottwoodall/django-react-template
    elif os.path.exists('backend/settings/devl.py'):
        os.environ['DJANGO_SETTINGS_MODULE'] = 'backend.settings.devl'
        #Your on your own. Set to fail loudly
    else:
        os.environ['DJANGO_SETTINGS_MODULE'] = 'webapp.settings'



#add the pwd to sys path as it is not appearing in
sys.path.insert(0,os.getcwd())
EOF
endif

map <F11> :!ctags -R -f ./tags `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`<CR>
command! -nargs=0 Ctags AsyncRun ~/bin/gen_tags.sh
" Load up virtualenv's vimrc if it exists
"
"nnoremap \ap :%!autopep8 --aggressive --aggressive %<cr>

inoremap {% {%  %}<left><left><left>
"j
"let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '{{':'}}', '{%':'%}'}
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}


"let g:UltiSnipsExpandTrigger="<c-i>""
"let g:UltiSnipsJumpForwardTrigger  = "<c-i>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
"filetype plugin indent on

set hidden

"django stuff
if filereadable('manage.py')
    au FileType python set ft=python.django
    au FileType html set ft=htmldjango
    au FileType haml set ft=htmldjango
    au FileType text set ft=htmldjango
    au FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango

    "Get tag generation out of the way
    if !filereadable('tags')
        norm <f11>
    endif
endif

abbr improt import
abbr ipmort import

"ol'school surround map
vmap s S

"set rtp+=~/.fzf

" ctrl-<j,k> moves current line/block up/down
nnoremap <c-k> ddkP
nnoremap <c-j> ddp
vnoremap <c-j> dp'[V']
vnoremap <c-k> dkP'[V']

" Run command-t file search
map <leader>f :FZF<CR>
" Ack searching
nmap <leader>a <Esc>:Find   
nmap <leader>b <Esc>:Buffer<cr>
nmap <leader>s <Esc>:Snippets<cr>

let g:syntastic_javascript_checkers = ['eslint']

let g:jsx_ext_required = 0

"set mouse=a
"Turn off mouse as I seem to use it for terminal copy more often
let s:mouse_enabled = 0
set mouse=
fun! ToggleMouse ()
    if s:mouse_enabled
        let s:mouse_enabled = 0
        set mouse=
        echo "Mouse Off"
    else
        let s:mouse_enabled = 1
        set mouse=a
        echo "Mouse ON"
    endif
endfun
nnoremap \mo :call ToggleMouse()<cr>

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

"autocmd VimEnter * call StartUp()
"set backup
"set backupdir=./.backupset directory=./.backup
"
function! SimpleLog(notes)
    call system("echo `date` >> LOG.txt")
    call system("echo >> LOG.txt")
    call system("echo '    " . a:notes . "' >> LOG.txt")
    echo a:notes
endfunction

command! LL -nargs=+ -complete=file call SimpleLog(<q-args>)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
inoremap jj <esc>A<cr>
inoremap jk <esc>
inoremap kj <esc>
inoremap kk <esc>O
" inoremap fj <esc>/["',)\]}=]<cr>a
"inoremap jf <esc> ?["',)\]}=]<cr>i
inoremap jl <esc>/[,)\]}=]<cr>a
" inoremap lj <esc> ?[,)\]}=]<cr>i
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

"Session manager
let g:session_directory = '~/.vim/session'
let g:session_autoload = 0
let g:session_autosave = 0

set sessionoptions+=tabpages,globals

let g:syntastic_python_checkers=['python', 'flake8']
let g:syntastic_python_flake8_post_args='--ignore=W391,E123,E128,E121 --max-line-length=100'
let g:ale_python_flake8_args='--ignore=W391,E123,E128,E121 --max-line-length=100'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=3

"toggle mouse

let g:qb_hotkey = '\q'

" if filereadable('~/.vimrc.local.vim')
source ~/.vimrc.local.vim
" endif

inoremap {% {%  %}<left><left><left>
inoremap {{ {{  }}<left><left><left>

"GIT gutter
"
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterUndoHunk
nmap <Leader>hv <Plug>GitGutterPreviewHunk

omap ih <Plug>GitGutterTextObjectInnerPending
omap ah <Plug>GitGutterTextObjectOuterPending
xmap ih <Plug>GitGutterTextObjectInnerVisual
xmap ah <Plug>GitGutterTextObjectOuterVisual

set autoread

set pastetoggle=<F12>

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()


let g:airline_section_x =''
let g:airline_section_y ='%{TagInStatusLine()}'
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#fnamemod = ':t'



" if exists(':Make') == 2
"     noautocmd Make
" else
"     silent noautocmd make!
"     redraw!
"     return 'call fugitive#cwindow()'
" endif

noremap \cc :call asyncrun#quickfix_toggle(8)<cr>

if !filereadable(expand("%:p:h")."/Makefile")
    autocmd FileType c setlocal makeprg=gcc\ -Wall\ -Wextra\ -o\ %<\ %
endif

fun! RunAfter()
    exe 'autocmd! BufWritePost *.py AsyncRun ~/bin/buf_write_post_python %'
    exe 'autocmd User AsyncRunStop  edit'
    exe 'command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>'
    nmap ]f ]pf
    nmap [f [pf
    nmap ]c ]pc
    nmap [c [pc
    return
endfun
autocmd VimEnter * :call RunAfter()
command! -bang -nargs=* WIP AsyncRun -program=~/bin/WIP ~/bin/WIP <args>

autocmd FileType xml setlocal makeprg=xml\ val\ -e\ -s\ ~/src/tickets/IM-1/NIDSv8.xsd

vnoremap \ap !autopep8 --aggressive --ignore=E123 --ignore=E128 --max-line-length=100 -<cr>:w<cr>'.zt

" gui colors if running iTerm
if $TERM_PROGRAM =~ "iTerm"
  set termguicolors
endif
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
set termguicolors
" set term=xterm-256color

nmap \.= o<c-.>=<c-><esc>

nnoremap \t :TagbarToggle<cr>

autocmd FileType jinja setlocal commentstring={#\ %s\ #}

nnoremap \bu <esc>:Buffer<cr>
nnoremap \bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>


nnoremap <expr> \tm &ma?":set nomodifiable<cr>":":set modifiable<cr>"

let g:ultisnips_python_style='google'
let g:pythontagimportkey = "<c-x><c-i>"
let g:pythontagimportcurrentword = "<leader>i"

"inoremap <silent><expr> ( complete_parameter#pre_complete("()")
" smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
" imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
" smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
" imap <c-k> <Plug>(complete_parameter#goto_previous_parameter))
"let g:complete_parameter_use_ultisnips_mapping = 1

"let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
"inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>
"
"
function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R')
  endif

  " \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":r")')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()
nnoremap \z :Tags<cr> 

function! UpdateModifiable()
  if !exists("b:setmodifiable")
    let b:setmodifiable = 0
  endif
  if &readonly
    if &modifiable
      setlocal nomodifiable
      let b:setmodifiable = 1
    endif
  else
    if b:setmodifiable
      setlocal modifiable
    endif
  endif
endfunction
autocmd BufReadPost * call UpdateModifiable()

" set ttymouse=sgr
set mouse=a

" Long line
nnoremap ,ll 100\|F,a<cr><esc>



function! s:agmulti(args)
  call fzf#vim#ag(a:args, {'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all'})
endfun
command! -nargs=1 Mag call s:agmulti('<args>')
nnoremap \x :Mag 

nnoremap \w :Mag <c-r><c-w><cr>


function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>e :call ToggleList("Quickfix List", 'c')<CR>

let g:easy_align_delimiters = {
    \ '>': { 'pattern': '>>\|=>\|>' },
    \ 'a': {
    \     'pattern':         ' as ',
    \     'delimiter_align': 'l',
    \     'ignore_groups':   ['!Comment'] },
    \ '/': {
    \     'pattern':         '\/\*',
    \     'delimiter_align': 'l',
    \     'ignore_groups':   ['!Comment'] },
    \ '.': {
    \     'pattern':         '\*\/',
    \     'delimiter_align': 'l',
    \     'ignore_groups':   ['!Comment'] },
    \ ']': {
    \     'pattern':       '[[\]]',
    \     'left_margin':   0,
    \     'right_margin':  0,
    \     'stick_to_left': 0
    \   },
    \ ')': {
    \     'pattern':       '[()]',
    \     'left_margin':   0,
    \     'right_margin':  0,
    \     'stick_to_left': 0
    \   },
    \ 'd': {
    \     'pattern':      ' \(\S\+\s*[;=]\)\@=',
    \     'left_margin':  0,
    \     'right_margin': 0
    \   }
    \ }

au BufReadCmd *.prpt call zip#Browse(expand("<amatch>"))

set nohlsearch

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

"let g:AutoPairsShortcutToggle = '<leader>\tap'
"
"
let g:tmux_view_session = 't im_a'
let g:tmux_view_window = 'TMUX_VIM_VIEW'
function! s:tmux_view()
    let line = getline('.')
    let filename = getcwd() . split(line, "|")[0]
    let lineno = split(split(line, "|")[1],' ')[0]
    echo filename
    echo lineno
endfunction
autocmd WinEnter * if &buftype == 'quickfix' | nnoremap <buffer> <c-t> call s:tmux_view() | endif

nnoremap \hh :History:<cr>

nnoremap \nt :NERDTreeToggle<cr>

"RLS Stuff
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

au FileType rust set completefunc=LanguageClient#complete
