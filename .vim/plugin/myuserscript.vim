" ============================================================================
" File:        myuserscript.vim
" Description:
" Maintainer:
" Version:     0.2
" Last Change:
" License:
" Author:      Tatsuo Ikeda
"
" ============================================================================

" rsync
function Rsync_gigacast_local_dev()
  !rsync_gigacast_local_dev
endfunction

" tmux nw window
function Nwpwd()
  !nw `pwd`
endfunction

" TODO only python setting.
" tags filter function.
command! -nargs=1 MyTagsClass call s:MyTagsClass(<f-args>)
function! s:MyTagsClass(name)
  " Retrieve tags of the 'f' kind
  let tags = taglist('^'.a:name)
  let tags = filter(tags, 'v:val["kind"] == "c"')

  " Prepare them for inserting in the quickfix window
  let qf_taglist = []
  for entry in tags
    call add(qf_taglist, {
          \ 'pattern':  entry['cmd'],
          \ 'filename': entry['filename'],
          \ })
  endfor

  " Place the tags in the quickfix window, if possible
  if len(qf_taglist) > 0
    call setqflist(qf_taglist)
    copen
  else
    echo "No tags found for ".a:name
  endif
endfunction


" tags filter Class
command! -nargs=1 MyTagsFunction call s:MyTagsFunction(<f-args>)
function! s:MyTagsFunction(name)
  " Retrieve tags of the 'f' kind
  let tags = taglist('^'.a:name)
  let tags = filter(tags, 'v:val["kind"] == "f"')

  " Prepare them for inserting in the quickfix window
  let qf_taglist = []
  for entry in tags
    call add(qf_taglist, {
          \ 'pattern':  entry['cmd'],
          \ 'filename': entry['filename'],
          \ })
  endfor

  " Place the tags in the quickfix window, if possible
  if len(qf_taglist) > 0
    call setqflist(qf_taglist)
    copen
  else
    echo "No tags found for ".a:name
  endif
endfunction


" tags filter class member.
command! -nargs=1 MyTagsClassMember call s:MyTagsClassMember(<f-args>)
function! s:MyTagsClassMember(name)
  " Retrieve tags of the 'f' kind
  let tags = taglist('^'.a:name)
  let tags = filter(tags, 'v:val["kind"] == "m"')

  " Prepare them for inserting in the quickfix window
  let qf_taglist = []
  for entry in tags
    call add(qf_taglist, {
          \ 'pattern':  entry['cmd'],
          \ 'filename': entry['filename'],
          \ })
  endfor

  " Place the tags in the quickfix window, if possible
  if len(qf_taglist) > 0
    call setqflist(qf_taglist)
    copen
  else
    echo "No tags found for ".a:name
  endif
endfunction


" -------
" keymaps
"--------
" deploy window
" map <silent> <Leader>r :call Rsync_gigacast_local_dev()<cr>
map <silent> <Leader>c :call Nwpwd()<cr>
" tags
" nnoremap <silent> <C-c>c :<C-u>MyTagsClass<Space>
" nnoremap <silent> <C-c>m :<C-u>MyTagsClassMember<Space>
" nnoremap <silent> <C-c>f :<C-u>MyTagsFunction<Space>


