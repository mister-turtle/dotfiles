call plug#begin()

"Plug '~/code/misc/vcopy.nvim'
"Plug 'ron89/thesaurus_query.vim'
"Plug 'KabbAmine/vCoolor.vim'
"Plug 'srcery-colors/srcery-vim'
Plug 'airblade/vim-gitgutter'
"Plug 'ap/vim-css-color'
"Plug 'cespare/vim-toml'
"Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'fatih/vim-go'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
"Plug 'tikhomirov/vim-glsl'

call plug#end()
