so ~/.config/nvim/plugins.vim


""""""""""""""""""""""
" Settings
""""""""""""""""""""""
set nocompatible                      " Enables VIM specific features
set title                             " Update the title of the terminal
filetype off                          " Reset filetype detection first
filetype plugin indent on             " Enable filetype detection
set ttyfast                           " Fast terminal connection for faster redraw
set laststatus=2                      " Always show the status line
set encoding=utf-8                    " Set encoding to UTF-8
set incsearch                         " Show match whilst typing
set hlsearch                          " Highlight found searches
set noerrorbells                      " Disable beeps
set noswapfile                        " Dont use a swapfile
set nobackup                          " Dont create backup files
set lazyredraw                        " Wait to redraw
set mouse-=a                          " Disable mouse
set number                            " Enable line numbers
set paste                             " Enable paste mode
set hidden                            " TextEdit might fail if hidden is not set
set cmdheight=2                       " TODO: lookup
set updatetime=300                    " Shorter update time for better UX
set shortmess+=c                      " Don't pass messages to |ins-completion-menu|.
set signcolumn=number                 " Merge signcolumn and number column into one


""""""""""""""""""""""
" Plugin Configurations
""""""""""""""""""""""
let g:go_gopls_enabled = 1
let g:go_go_fmt_command="gopls"
let g:go_gopls_gofumpt=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

""""""""""""""""""""""
" Key Bindings
""""""""""""""""""""""
map - : set number!<CR>
map = : set relativenumber!<CR>


""""""""""""""""""""""
" CoC-Vim settings
""""""""""""""""""""""
inoremap <silent><expr> <TAB>
			\ pumvisible() ? coc#_select_confirm() :
			\ coc#expandableOrJumpable() ?
			\ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Map <tab> for trigger completion
let g:coc_snippetnext = '<tab>'

inoremap <silent><expr> <c-space> coc#refresh()
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
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
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

function! s:doHover()
	if coc#rpc#ready()
		let diagnostics = CocAction('diagnosticList')
		if empty(diagnostics)
			call CocActionAsync('doHover')
			return
		endif
		let file = expand('%:p')
		let lnum = line('.')
		let cnum = col('.')
		for v in diagnostics
			if v['file'] != file
						\ || lnum != v['lnum']
						\ || cnum < v['location']['range']['start']['character']
						\ || cnum > v['location']['range']['end']['character']
				call CocActionAsync('doHover')
				return
			endif
		endfor
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
