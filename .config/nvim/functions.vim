command! -nargs=? -complete=buffer -bang Bonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BOnly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang Bufonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BufOnly
    \ :call BufOnly('<args>', '<bang>')

" Usage:
"
" :Bonly / :BOnly / :Bufonly / :BufOnly [buffer]
"
" Without any arguments the current buffer is kept.  With an argument the
" buffer name/number supplied is kept.
function! BufOnly(buffer, bang)
	if a:buffer == ''
		" No buffer provided, use the current buffer.
		let buffer = bufnr('%')
	elseif (a:buffer + 0) > 0
		" A buffer number was provided.
		let buffer = bufnr(a:buffer + 0)
	else
		" A buffer name was provided.
		let buffer = bufnr(a:buffer)
	endif

	if buffer == -1
		echohl ErrorMsg
		echomsg "No matching buffer for" a:buffer
		echohl None
		return
	endif

	let last_buffer = bufnr('$')

	let delete_count = 0
	let n = 1
	while n <= last_buffer
		if n != buffer && buflisted(n)
			if a:bang == '' && getbufvar(n, '&modified')
				echohl ErrorMsg
				echomsg 'No write since last change for buffer'
							\ n '(add ! to override)'
				echohl None
			else
				silent exe 'bdel' . a:bang . ' ' . n
				if ! buflisted(n)
					let delete_count = delete_count+1
				endif
			endif
		endif
		let n = n+1
	endwhile

	if delete_count == 1
		echomsg delete_count "buffer deleted"
	elseif delete_count > 1
		echomsg delete_count "buffers deleted"
	endif

endfunction

" ===============================
" Close Neo-tree intelligently on exit
" ===============================

command! Q call CloseNeoTreeOnQuit()

function! CloseNeoTreeOnQuit()
  " Проверяем все окна на наличие neo-tree
  let l:neo_wins = filter(range(1, winnr('$')), 'getbufvar(winbufnr(v:val), "&filetype") ==# "neo-tree"')

  if &filetype ==# 'neo-tree'
    " 1) Если текущий буфер - Neo-tree: закрыть его и перейти на предыдущий буфер
    if len(l:neo_wins) > 1
      " Есть другие окна Neo-tree, закрываем только текущее
      exec "bwipeout!"
    else
      " Последний Neo-tree - закрываем и выходим
      exec "bwipeout!"
      quit
    endif
  else
    " 2) Текущий буфер обычный, есть открытый Neo-tree
    if !empty(l:neo_wins)
      " Закрываем все окна Neo-tree
      for win in l:neo_wins
        exec win . "wincmd w"
        exec "bwipeout!"
      endfor
    endif
    " Теперь можно выйти из Neovim
    quit
  endif
endfunction

"set shada=
set exrc
set secure

" Функция для установки project-local shada
function! SetProjectShada()
    " Попробуем git root
    let l:git_root = systemlist('git rev-parse --show-toplevel')[0]
    if v:shell_error != 0 || empty(l:git_root)
        " fallback на cwd
        let l:root = getcwd()
    else
        let l:root = l:git_root
    endif

    " Директория для shada
    let l:shada_dir = stdpath('state') . '/shada'
    if !isdirectory(l:shada_dir)
        call mkdir(l:shada_dir, 'p')
    endif

    " Уникальное имя shada на проект
    let l:id = fnamemodify(l:root, ':t') . '_' . sha256(l:root)[0:7]
    let l:shadafile = l:shada_dir . '/' . l:id . '.shada'

    " Устанавливаем shadafile до открытия буферов
    execute 'set shadafile=' . fnameescape(l:shadafile)
endfunction

" Вызываем сразу при старте, до буферов
call SetProjectShada()
