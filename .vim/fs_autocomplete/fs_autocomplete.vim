fun! CompleteWithFileSystemListing(findstart, base)
  if a:findstart
    return GetSlashIndex(getline("."))
  endif
  let l:cwd = GetCompleteDirectoryPath()
  let l:fsListing = GetFileSystemListing(l:cwd)
  let l:pattern = GetCompletePattern()
  let l:filtered = FilterListWithString(l:fsListing, l:pattern)
  echo cwd
  echo "======================="
  echo pattern
  echo "======================="
  echo filtered
  echo "======================="
  return l:filtered
endfun

fun! GetCompleteDirectoryPath()
  let l:path = GetTrimmedLine()
  let l:index = GetSlashIndex(l:path)
  let l:cwd = expand("%:h")
  if(index == 0)
    let l:resultPath = l:cwd
  else
    if(path[0] == "/")
      let l:resultPath = substitute(path, "(.*/).*$", "\1", "")
      return l:resultPath
    elseif(path[0] == ".")
      let l:resultPath = cwd . substitute(path, "^(\.|\./)", "")
    else
      let l:resultPath = cwd . path
    endif
  endif
  return l:resultPath
endfun

fun! GetCompletePattern()
  let l:line = GetTrimmedLine()
  let parts = split(l:line, '/')
  if(len(l:parts) > 0)
    let last = parts[-1]
    return l:last
  endif
  return ""
endfun

fun! GetSlashIndex(line)
  let l:index = strridx(a:line, "\/")
  if(index == -1)
    let index = 0
  endif
  return l:index
endfun

fun! GetTrimmedLine()
  return substitute(getline("."), '^\s*\(.\{-}\)\s*$', '\1', '')
endfun

fun! GetFileSystemListing(path)
  let absoluteFilePath = ConvertRelativePathToAbsolute(a:path)
  let l:fileSystemListing = system("ls -a " . a:path)
  let l:fsListingList = split(fileSystemListing)
  return l:fsListingList
endfun

fun! FilterListWithString(fsListing, pattern)
  let l:filtered = []
  for item in a:fsListing
    echo stridx(item, a:pattern)
    if(stridx(item, a:pattern) != -1)
      call add(l:filtered, item)
    endif
  endfor
  return l:filtered
endfun


fun! ConvertRelativePathToAbsolute(path)
  return system("readlink -f " . a:path)
endfun

set completefunc=CompleteWithFileSystemListing
