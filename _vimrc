"Core Stuff
set et
set sts=4
set sw=4
set list
set nocompatible

set wildmode=longest,list,full
set wildmenu
colorscheme desert

set showbreak=↪\ 
set listchars=tab:▶\ 
set listchars+=trail:◥
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
Plug 'mjbrownie/swapit'
Plug 'mjbrownie/YouCompleteMe', { 'do': function('BuildYCM') }
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
Plug 'mjbrownie/vim-relafile-django'
Plug 'mjbrownie/snipmate_for_django'
Plug 'mjbrownie/snipmate_for_django'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-syntastic/syntastic'
Plug 'sjl/gundo.vim'
Plug 'justinj/vim-react-snippets'
Plug 'kana/vim-textobj-user'
Plug 'mjbrownie/vim-relafile'
Plug 'mjbrownie/vim-relafile-django'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'narfdotpl/selfdot.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'wlemuel/vim-ultisnips-redux'
Plug 'scrooloose/NerdTree'
Plug 'mjbrownie/GetFilePlus'
call plug#end()


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
command Ctags :!ctags -R -f ./tags `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`<CR>
" Load up virtualenv's vimrc if it exists
"
nnoremap \ap :%!autopep8 --aggressive --aggressive %<cr>

inoremap {% {%  %}<left><left><left>
"
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '{{':'}}', '{%':'%}'}


"let g:UltiSnipsExpandTrigger="<c-i>""
"let g:UltiSnipsJumpForwardTrigger  = "<c-i>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
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
nmap <leader>a <Esc>:Ag 
nmap <leader>b <Esc>:Buffer 
nmap <leader>s <Esc>:Snippets 

let g:syntastic_javascript_checkers = ['eslint']

let g:jsx_ext_required = 0

set mouse=a

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

autocmd VimEnter * call StartUp()
