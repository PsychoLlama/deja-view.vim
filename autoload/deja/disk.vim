" Read and write to the file system under a user-configurable directory. File
" names are escaped and written flat, much like vim's 'undodir' option.

func! deja#disk#write(path, data) abort
  let l:file_path = deja#disk#get_path(a:path)
  let l:serialized = json_encode(a:data)

  call writefile([l:serialized], l:file_path)
endfunc

func! deja#disk#read(path) abort
  let l:file_path = deja#disk#get_path(a:path)

  if !filereadable(l:file_path)
    return v:null
  endif

  let l:file_contents = join(readfile(l:file_path), '\n')
  return json_decode(file_contents)
endfunc

func! deja#disk#get_path(file_name) abort
  return s:get_backup_dir() . '/' . s:escape_path(a:file_name)
endfunc

func! deja#disk#get_driver() abort
  let l:driver = {}
  let l:driver.read = function('deja#disk#read')
  let l:driver.write = function('deja#disk#write')

  return l:driver
endfunc

" Turn '/path/to/file' into '%path%to%file'.
func! s:escape_path(path) abort
  let l:l1 = substitute(a:path, '%', '%%', 'g')
  let l:l2 = substitute(l:l1, '/', '%', 'g')
  return l:l2
endfunc

func! s:get_backup_dir() abort
  let l:backup_dir = get(g:, 'deja#backup_path', '/tmp')

  " This is fast enough that it might as well be free.
  call mkdir(l:backup_dir, 'p')

  return substitute(l:backup_dir, '\v/$', '', '')
endfunc
