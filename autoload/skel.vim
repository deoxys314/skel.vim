" Location: autoload/skel.vim

" Section: Load guards {{{

if exists('g:autoloaded_skel')
	finish
endif
let g:autoloaded_skel = 1

" }}}

" Section: Internal Functions {{{

function! s:buffer_empty() abort
	" Checks if the last line of the file is the first line, and
	" if the contents of that line are the empty string.
	return line('$') == 1 && getline(1) == ''
endfunction

function! s:get_sep() abort
	" A best effort attempt to deal with the different
	" conventions on different systems. Based on similar
	" snippets found in many plugins, most notably from Tim
	" Pope. Look him up on Github!
	return !exists('+shellslash') || &shellslash ? '/' : '\'
endfunction

function! s:get_templates() abort
	" Files are returned in the order of the runtimepath, so
	" this list is reversed to ensure we search the user folders
	" (aka after/) first.
	return reverse(globpath(&rtp, 'templates' . s:get_sep() . '*.skel', 0, 1))
endfunction

function! s:log(message) abort
	" If plugin is in verbose mode, log a message. Otherwise, do
	" nothing.
	if get(g:, 'skel_verbose', 0)
		echomsg l:message
	endif
endfunction

" }}}

" Section: Public Functions {{{

" PUBLIC: Autocmd
function! skel#populate_buffer() abort
	" simple wrapper for the autocmd. Will never call with bang,
	" as that could potentially cause unexpected or undesired
	" behavior
	call skel#load_type(&filetype, 0)
endfunction

" PUBLIC: Command Completion
function! skel#list_files(arglead, cmdline, cursorpos) abort
	" uses fnamemodify to get the base names of skeleton files
	" (:t (tail) for filename, :r (root) to drop the extension.
	" Extension will always be '.skel' because of the blob used
	" in s:get_templates()
	return uniq(sort(filter(
				\ map(s:get_templates(), 'fnamemodify(v:val, ":t:r")'),
						\ 'v:val =~? a:arglead')))
endfunction

" PUBLIC: Custom Command
function! skel#load_type(type, bang) abort
	" Core functionality for the plugin. Will read skeleton file
	" of a given type, or default to &filetype if none is
	" provided (Most commonly encountered when using the
	" LoadSkeleton command.)
	if a:type ==? ''
		let l:type = &filetype
	else
		let l:type = a:type
	endif
	for template in s:get_templates()
		if fnamemodify(template, ':t:r') ==? l:type
			if s:buffer_empty() || a:bang
				call s:log('Populating buffer with a ' . a:type . ' skeleton.')
				execute ':silent! 0r ' . template
			else
				echoerr 'Cannot populate a non-empty buffer!'
			endif
			return
		endif
	endfor
endfunction

" }}}
