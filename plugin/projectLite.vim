" ============================================================================
" File:        projectLite.vim
" Description: This plugin provides a function to get a root project
"              directory based on a given directory.
"              It has other features, see
"
" Maintainer:  Krzysztof Kanas <k2k_chris //at// o2.pl>
" Last Change: 2020 Dec 11
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
"
" ============================================================================

if exists("projectLiteLoaded")
  finish
endif

let g:projectLiteLoaded = 1

let g:project_file_name = '.projectLite.vim'

" seraches for project_file_name in current dir, and higher paths to find
" file .projectLite.vim or .git directory
" Doesn't work on windows
function! projectLite#find()
  let l:current_dir = getcwd()
  while len(l:current_dir) > 1
		if filereadable(l:current_dir.'/'.g:project_file_name)
			let g:current_project_file = l:current_dir.'/'.g:project_file_name
				execute ':source '.g:current_project_file
				execute ':cd '. l:current_dir
				return 0
		endif
		if isdirectory(l:current_dir.'/.git')
			execute ':cd '. l:current_dir
			return 0
		endif
		let l:current_dir=fnamemodify(l:current_dir,':p:h:h')
  endwhile
  return 1
endfunction


function! ProjectReload()
  call projectLite#find()
endfunction

command! ProjectLiteReload call projectLite#find()

augroup ProjectLite
  autocmd VimEnter * call projectLite#find()
augroup END
