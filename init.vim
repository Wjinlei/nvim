" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" Author: fock of @theniceboy with my private modifiactons


" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===
" === Create a _machine_specific.vim
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
    let has_machine_specific_file = 0
    silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim

" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
    exec "e ~/.config/nvim/_machine_specific.vim"
endif

" ===
" === Necessary Commands to Execute
" ===
exec "nohlsearch"


" ====================
" === Editor Setup ===
" ====================


" ===
" === System
" ===
set clipboard=unnamed
let &t_ut=''
set autochdir


" ===
" === Editor behavior
" ===
set hidden
set number
set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu
set hlsearch
set incsearch
set ignorecase
set smartcase
set encoding=utf-8
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=30
set tw=0
set indentexpr=
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
set autoindent
set laststatus=2
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set shortmess+=c
set inccommand=split
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set regexpengine=1
set visualbell
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
    set undofile
    set undodir=~/.config/nvim/tmp/undo,.
endif
set colorcolumn=80
set updatetime=100
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" === Terminal Behaviors
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'


" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "

" Save & quit
noremap q :q!<CR>
noremap Q :qa!<CR>
noremap w :w!<CR>
noremap W :w!<CR>

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" Search
noremap <LEADER><CR> :nohlsearch<CR>

" Back normal mode
inoremap jj <Esc>


" ===
" === Cursor Movement
" ===
noremap <silent> K 5k
noremap <silent> J 5j
noremap <silent> H b
noremap <silent> L w
noremap <silent> <C-h> ^
noremap <silent> <C-l> $


" ===
" === Window management
" ===
" Disable the default s key
noremap s <nop>
" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap spk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap spj :set splitbelow<CR>:split<CR>
noremap sph :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap spl :set splitright<CR>:vsplit<CR>
noremap smv <C-w>t<C-w>K
noremap smh <C-w>t<C-w>H
" moving the cursor around windows
noremap sk <C-w>k
noremap sj <C-w>j
noremap sh <C-w>h
noremap sl <C-w>l
noremap <Up> :res +5<CR>
noremap <Down> :res -5<CR>
noremap <Left> :vertical resize-5<CR>
noremap <Right> :vertical resize+5<CR>
" tab management
noremap stt :tabe<CR>
noremap sth :-tabnext<CR>
noremap stl :+tabnext<CR>
noremap stmh :-tabmove<CR>
noremap stml :+tabmove<CR>


" ===
" === Other useful stuff
" ===
" Opening a terminal window
noremap <LEADER>/ :term<CR>

" Open up lazygit
"noremap <silent> <LEADER>lg :term lazygit<CR>

" Press space twice to jump to the next '<++>' and edit it
"noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" find and replace
noremap \s :%s//g<left><left>

" Compile function
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        set splitright
        exec "!g++ -std=c++11 % -Wall -o %<"
        :vsp
        :res -15
        :term ./%<
    elseif &filetype == 'python'
        set splitright
        :vsp
        :term python3 %
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'html'
        silent! exec "!".g:mkdp_browser." % &"
    elseif &filetype == 'go'
        set splitright
        :vsp
        :term go run %
    elseif &filetype == 'vue'
        set splitright
        :vsp
        :term npm run build
    elseif &filetype == 'rust'
        "exec "!cargo run"
        exec "!rustc % -o %<"
        exec "!time ./%<"
    endif
endfunc


" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.config/nvim/plugged')

" Pretty Dress
"Plug 'theniceboy/nvim-deus'
Plug 'dracula/vim'
"Plug 'joshdick/onedark.vim'
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'cocopon/iceberg.vim'
"Plug 'ayu-theme/ayu-vim'
"Plug 'jacoborus/tender.vim'
"Plug 'sainnhe/sonokai'
"Plug 'connorholyday/vim-snazzy'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ojroques/vim-scrollstatus'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter' " need nvim 0.5
Plug 'nvim-treesitter/playground'

" File navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Find & Replace
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }
Plug 'kevinhwang91/rnvimr'

" Git
Plug 'kdheepak/lazygit.nvim' " need nvim 0.5

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Autoformat
Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'
Plug 'google/vim-codefmt'

" Genreal Highlighter
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'RRethy/vim-illuminate'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'dkarter/bullets.vim'
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }

" Rust
Plug 'rust-lang/rust.vim'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Debuger
Plug 'puremourning/vimspector'

" Editor Enhancement
Plug 'lambdalisue/suda.vim' " 使用 :sudow 以root身份保存文件
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Other
Plug 'wincent/terminus'
Plug 'luochen1990/rainbow'
Plug 'mg979/vim-xtabline'

call plug#end()
call glaive#Install()

" ===================== Start of Plugin Settings =====================

" ===
" === Dress up my vim
" ===
syntax on
set termguicolors
set background=dark " Setting dark mode
"set background=light " Setting light mode
"colorscheme deus
colorscheme dracula
"colorscheme onedark
"colorscheme PaperColor
"colorscheme iceberg
"colorscheme ayu
"colorscheme tender
"colorscheme sonokai
"colorscheme snazzy

" ===
" === vim-airline
" ===
"let g:airline_theme='deus'
let g:airline_theme='dracula'
"let g:airline_theme='onedark'
"let g:airline_theme='papercolor'
"let g:airline_theme='iceberg'
"let g:airline_theme='ayu'
"let g:airline_theme='tender'
"let g:airline_theme='sonokai'
"let g:airline_theme='snazzy'


" ===
" === 背景透明
" ===
"hi Normal     ctermbg=NONE guibg=NONE
"hi LineNr     ctermbg=NONE guibg=NONE
"hi SignColumn ctermbg=NONE guibg=NONE


" ===
" === 灰色注释
" ===
"hi Comment guifg=#5C6370 ctermfg=59


" ===
" === vim-scrollstatus
" ===
let g:scrollstatus_size = 20
let g:airline_section_x = '%{ScrollStatus()} '
let g:airline_section_y = airline#section#create_right(['filetype'])
let g:airline_section_z = airline#section#create([
            \ '%#__accent_bold#%3l%#__restore__#/%L', ' ',
            \ '%#__accent_bold#%3v%#__restore__#/%3{virtcol("$") - 1}',
            \ ])


" ===
" === rainbow
" ===
let g:rainbow_active = 1


" ===
" === xtabline
" ===
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1


" ===
" === vimspector
" ===
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB','vscode-go' ]
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
    " has to be a function to avoid the extra space fzf#run insers otherwise
    execute '0r ~/.config/nvim/vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
            \   'source': 'ls -1 ~/.config/nvim/vimspector_json',
            \   'down': 20,
            \   'sink': function('<sid>read_template_into_buffer')
            \ })
noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=🛑 texthl=Normal
sign define vimspectorBPDisabled text=🚫 texthl=Normal
sign define vimspectorPC text=👉 texthl=SpellBad


" ===
" === suda.vim
" ===
cnoreabbrev sudow w suda://%


" ===
" === AutoFormat
" ===
Glaive codefmt prettier_options="--print-width=120"
augroup autoformat_settings
  " autocmd FileType bzl AutoFormatBuffer buildifier
  " autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  " autocmd FileType dart AutoFormatBuffer dartfmt
  " autocmd FileType go AutoFormatBuffer gofmt
  " autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json,javascript AutoFormatBuffer js-beautify
  " autocmd FileType java AutoFormatBuffer google-java-format
  " autocmd FileType python AutoFormatBuffer yapf
  " autocmd FileType python AutoFormatBuffer autopep8
  " autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
augroup END


" ===
" === vim-easymotion
" ===
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_do_shade = 0
let g:EasyMotion_smartcase = 1
" Move to {char}
map  ss <Plug>(easymotion-bd-f)


" ===
" === vim-visual-multi
" ===
let g:VM_maps                       = {}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
let g:VM_maps["Find Next"]          = '<C-n>'
let g:VM_maps["Find Prev"]          = '<C-p>'
let g:VM_maps["Goto Next"]          = '<C-j>'
let g:VM_maps["Goto Prev"]          = '<C-k>'
let g:VM_maps['Remove Region']      = 'q'
let g:VM_maps['Skip Region']        = '<C-s>'
let g:VM_maps["Undo"]               = '<C-u>'
let g:VM_maps["Redo"]               = '<C-r>'


" ===
" === Nerdcommenter
" ===
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" ===
" === LazyGit
" ===
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 0.8 " scaling factor for floating window
let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
let g:lazygit_floating_window_use_plenary = 0 " use plenary.nvim to manage floating window if available
let g:lazygit_use_neovim_remote = 1 " fallback to 0 if neovim-remote is not installed
nnoremap <silent> <LEADER>lg :LazyGit<CR>


" ===
" === coc
" ===
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-explorer',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-emmet',
  \ 'coc-vetur',
  \ 'coc-rust-analyzer',
  \ 'coc-vimlsp',
  \ 'coc-lists',
  \ 'coc-yank',
  \ 'coc-git',
  \ 'coc-gitignore',
  \ 'coc-highlight',
  \ 'coc-diagnostic',
  \ 'coc-translator',
  \ 'coc-pairs']

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <C-j> and <C-k> to navigate the completion list:
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <alt+/> to trigger completion.
inoremap <silent><expr> <M-/> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `=` and `-` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<cr>
nmap <silent> = <Plug>(coc-diagnostic-prev)
nmap <silent> - <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Useful commands
" CocCommand
nnoremap <C-c> :CocCommand<CR>
" coc-explorer
nnoremap tt :CocCommand explorer<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)
vmap ts <Plug>(coc-translator-pv)
" coc-snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
let g:coc_snippet_next = '<TAB>' 
let g:coc_snippet_prev = '<S-TAB>'
imap <C-l> <Plug>(coc-snippets-expand)
" coc-yank
nnoremap <silent> <LEADER>y :<C-u>CocList -A --normal yank<cr>


" ===
" === Far.vim
" ===
noremap <LEADER>f :Far  **/*<left><left><left><left><left>
let g:far#enable_undo = 1
let g:far#mapping = {"replace_undo" : ["l"]}


" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
            \ 'mkit': {},
            \ 'katex': {},
            \ 'uml': {},
            \ 'maid': {},
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'middle',
            \ 'hide_yaml_meta': 1
            \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'


" ===
" === vim-table-mode
" ===
noremap <LEADER>mtm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'


" ===
" === Markdown Settings
" ===
" Snippets
source ~/.config/nvim/md-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell


" ===
" === Bullets.vim
" ===
"let g:bullets_set_mappings = 0
let g:bullets_enabled_file_types = [
            \ 'markdown',
            \ 'text',
            \ 'gitcommit',
            \ 'scratch'
            \]


" ===
" === vim-markdown-toc, :GenToGFM 生成目录, :RmoveToc 删除目录, :UpdateToc 手动更新目录
" ===
let g:vmt_auto_update_on_save = 1
let g:vmt_dont_insert_fence = 0
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'


" ===
" === Ultisnips
" ===
"" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<TAB>"
let g:UltiSnipsJumpForwardTrigger="<TAB>"
let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips/', 'UltiSnips']
silent! au BufEnter,BufRead,BufNewFile * silent! unmap <c-r>


" ===
" === FZF
" ===
" Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)
" Fzf layout
let g:fzf_layout = {'window': {'width': 1, 'height': 1 }}

noremap fh  :History<CR>
noremap fr  :Rg<CR>
noremap fs  :Lines<CR>
noremap bb  :Buffers<CR>


" ===
" === rnvimr
" ===
let g:rnvimr_enable_ex = 1
let g:rnvimr_enable_picker = 1
let g:rnvimr_draw_border = 1
"let g:rnvimr_border_attr = {'fg': 80, 'bg': -1}
let g:rnvimr_enable_bw = 1
let g:rnvimr_shadow_winblend = 50
let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'
highlight link RnvimrNormal CursorLine
nnoremap <silent> fd :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
nnoremap <silent> ff :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': &columns,
            \ 'height': &lines,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
let g:rnvimr_presets = [{'width': 0.8, 'height': 0.8}]


" ===
" === treesitter
" ===
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"html","css","javascript","json","vue","bash"},
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  indent = {
    enable = true
  }
}
EOF


" ===
" === vim-go
" ===
let g:go_auto_type_info                      = 1
let g:go_highlight_array_whitespace_error    = 1
let g:go_highlight_build_constraints         = 1
let g:go_highlight_chan_whitespace_error     = 1
let g:go_highlight_extra_types               = 1
let g:go_highlight_fields                    = 1
let g:go_highlight_format_strings            = 1
let g:go_highlight_function_calls            = 1
let g:go_highlight_function_parameters       = 1
let g:go_highlight_functions                 = 1
let g:go_highlight_generate_tags             = 1
let g:go_highlight_methods                   = 1
let g:go_highlight_operators                 = 1
let g:go_highlight_space_tab_error           = 1
let g:go_highlight_string_spellcheck         = 1
let g:go_highlight_structs                   = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types                     = 1
let g:go_def_mapping_enabled                 = 0
let g:go_doc_keywordprg_enabled              = 0
let g:go_imports_autosave                    = 1
let g:go_fmt_autosave                        = 1
let g:go_mod_fmt_autosave                    = 1
"let g:go_metalinter_autosave                 = 1
"let g:go_metalinter_autosave_enabled         = ['vet', 'golint']
autocmd FileType go noremap gk :GoDoc<CR>
autocmd FileType go noremap gta :GoTest<CR>
autocmd FileTYpe go noremap gtt :GoTestFunc<CR>

" ===
" === Rust
" ===
let g:rustfmt_autosave = 1
let g:rust_clip_command = 'xclip -selection clipboard'

" ===================== End of Plugin Settings =====================
