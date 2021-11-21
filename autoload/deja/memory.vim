" In-memory backend. Useful for virtual buffers, like help pages, man pages,
" scratch files, file browsers, etc.

let s:VIRTUAL_FS = {}

func! deja#memory#write(file_path, value) abort
  let s:VIRTUAL_FS[a:file_path] = a:value
endfunc

func! deja#memory#read(file_path) abort
  return get(s:VIRTUAL_FS, a:file_path, v:null)
endfunc

func! deja#memory#clear() abort
  let s:VIRTUAL_FS = {}
endfunc

func! deja#memory#get_driver() abort
  let l:driver = {}
  let l:driver.read = function('deja#memory#read')
  let l:driver.write = function('deja#memory#write')

  return l:driver
endfunc
