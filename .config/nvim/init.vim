" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rakr/vim-one'
" Plug 'shougo/deoplete.nvim'
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'lambdalisue/suda.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-highlightedyank'
Plug 'nelstrom/vim-markdown-folding'
Plug 'frazrepo/vim-rainbow'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'udalov/kotlin-vim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'ryanoasis/vim-devicons'
" Plug 'preservim/nerdtree' |
"             \ Plug 'Xuyuanp/nerdtree-git-plugin' |
"             \ Plug 'ryanoasis/vim-devicons'
call plug#end()

let mapleader = " "

" Highlight the line on which the cursor lives.
set nocursorline

" Disable autocomment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Auto delete all trailing whitespace characters on save
autocmd BufWritePre * %s/\s\+$//e

" Always show at least one line above/below the cursor.
set scrolloff=1

" Always show at least one line left/right of the cursor.
set sidescrolloff=5

" Relative line numbers
set number relativenumber

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Use system clipboard
set clipboard=unnamedplus

" Remove timeout for partially typed commands
set notimeout

" F keys
" Quick write session with F2
map <F2> :mksession! ~/.vim_session<cr>
" And load session with F3
map <F3> :source ~/.vim_session<cr>

" Fix indentation
map <F7> gg=G<C-o><C-o>
" Toggle auto change directory
map <F8> :set autochdir! autochdir?<CR>

" Quit all (!!! without saving !!!)
nmap <C-Q> :qa!<cr>
vmap <C-Q> <esc>:qa!<cr>
imap <C-Q> <esc>:qa!<cr>


" Toggle vertical line
set colorcolumn=
fun! ToggleCC()
  if &cc == ''
    " set cc=1,4,21
    set cc=80
  else
    set cc=
  endif
endfun
nnoremap <silent> <F9> :call ToggleCC()<CR>

" Beginning and end of line
imap <C-a> <home>
imap <C-e> <end>
cmap <C-a> <home>
cmap <C-e> <end>

" Control-S Save
nmap <C-S> :w<cr>
vmap <C-S> <esc>:w<cr>
imap <C-S> <esc>:w<cr>
" Save + back into insert
" imap <C-S> <esc>:w<cr>a

" Control-S System Cut in visual mode
vmap <C-X> "+d

" Control-C System Copy in visual mode
vmap <C-C> "+y

" Control-V System Paste in insert and command mode
imap <C-V> <esc>"+P
cmap <C-V> "+P

" Window Movement
nmap <M-h> <C-w>h
nmap <M-j> <C-w>j
nmap <M-k> <C-w>k
nmap <M-l> <C-w>l

" Resizing
nmap <C-M-H> 2<C-w><
nmap <C-M-L> 2<C-w>>
nmap <C-M-K> <C-w>-
nmap <C-M-J> <C-w>+

" Insert mode movement
imap <M-h> <left>
imap <M-j> <down>
imap <M-k> <up>
imap <M-l> <right>
imap <M-f> <C-right>
imap <M-b> <C-left>

" Make ci( work like quotes do
function! New_cib()
    if search("(","bn") == line(".")
        sil exe "normal! f)ci("
        sil exe "normal! l"
        startinsert
    else
        sil exe "normal! f(ci("
        sil exe "normal! l"
        startinsert
    endif
endfunction

" And for curly brackets
function! New_ciB()
    if search("{","bn") == line(".")
        sil exe "normal! f}ci{"
        sil exe "normal! l"
        startinsert
    else
        sil exe "normal! f{ci{"
        sil exe "normal! l"
        startinsert
    endif
endfunction

nnoremap ci( :call New_cib()<CR>
nnoremap cib :call New_cib()<CR>
nnoremap ci{ :call New_ciB()<CR>
nnoremap ciB :call New_ciB()<CR>

" Alt-m for creating a new line in insert mode
imap <M-m> <esc>o

" Cycle windows
nmap <M-o> <C-W>w
vmap <M-o> <C-W>w
tmap <M-o> <esc><C-W>w
imap <M-o> <esc><C-W>w

" Command mode history
cmap <M-p> <up>
cmap <M-n> <down>
cmap <M-k> <up>
cmap <M-j> <down>

" Back to normal mode from insert
" inoremap jk <esc>
" inoremap JK <esc>

" Manually refresh file
nmap <F5> :e!<cr>

" Indentation
set smarttab
set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4

"set smartindent
set autoindent

"set cindent
set nocompatible
filetype plugin indent on

" Write buffer through sudo (works on vim but not neovim)
" cnoreabbrev w!! w !sudo -S tee % >/dev/null
" Neovim: suda plugin
cnoreabbrev w!! w suda://%

" Allow switching between buffers without saving
set hidden

" Mouse support
set mouse=a

"Case insensitive searching
set ignorecase

"Will automatically switch to case sensitive if you use any capitals
set smartcase

" Auto toggle smart case of for ex commands
" Assumes 'set ignorecase smartcase'
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END

" Substitute live preview
set inccommand=nosplit

" Markdown Folding
let g:markdown_fold_style = 'nested'

" Highlighted yank (-1 for persistent)
let g:highlightedyank_highlight_duration = 400

" Shell
set shell=/bin/zsh

" Ctrlp
let g:ctrlp_switch_buffer = '0'
" Useful for large projects
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=10
" So that it does not only index starting from current directory
let g:ctrlp_working_path_mode = ""
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" Use ag AKA the_silver_searcher for indexing. Faster!!!
" TIP: Use ~/.ignore to ignore directories/files
" set grepprg=ag\ --nogroup\ --nocolor
" let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
""if executable('ag')
""  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
""endif
let g:ctrlp_show_hidden =1
let g:ctrlp_clear_cache_on_exit = 0

" deoplete
" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#var('tabnine', {
"             \ 'line_limit': 500,
"             \ 'max_num_results': 20,
"             \ })
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" CoC
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" Clear search highlighting with Escape key
nnoremap <silent><esc> :noh<return><esc>

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

set wildmenu

set encoding=utf8
scriptencoding utf-8

" Airline
let g:airline_theme='one'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1

" Vim Rainbow
let g:rainbow_active = 1

" Hexokinase
let g:Hexokinase_highlighters = ['backgroundfull']

" NerdTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" let NERDTreeShowHidden=1
" map <C-n> :NERDTreeToggle<CR>

" COC-Explorer
let g:coc_explorer_global_presets = {
            \    'floating': {
            \        'position': 'floating',
            \        'open-action-strategy' : 'sourceWindow',
            \    },
            \}
nmap <C-n> :CocCommand explorer --preset floating<CR>

" Goyo + Limelight
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
map <M-z> :Goyo<CR>

" Colorscheme
if (empty($TMUX))
    if (has("nvim"))
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    if (has("termguicolors"))
        set termguicolors
    endif
endif

set background=dark
colorscheme one
let g:one_allow_italics = 1

" Restore last cursor position and marks on open
au BufReadPost *
         \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
         \ |   exe "normal! g`\""
         \ | endif
