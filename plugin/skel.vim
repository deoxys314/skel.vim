" skel.vim - simple file template support
" Maintainer: Cameron Rossington
" Version:    0.2

if exists('g:loaded_skel')
	finish
endif
let g:loaded_skel = 1

let g:skel_verbose = get(g:, 'skel_verbose', 0)

" Section: Commands {{{

command! -nargs=? -bang -bar
		\ -complete=customlist,skel#list_files
		\ SkelLoad call skel#load_type(<q-args>, <bang>0)

" }}}

" Section: Autocmds {{{

augroup skel
	autocmd!
	autocmd BufNewFile * call skel#populate_buffer()
augroup END

" }}}
