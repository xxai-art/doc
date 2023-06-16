#!/usr/bin/env coffee

> @w5/uridir
  path > join
  @w5/write
  @w5/lang
  @w5/read
  ./ORG
  pug

ROOT = uridir(import.meta)

fp = (args...)=>
  join ROOT, ...args

readme = (lang)=>
  "https://github.com/#{ORG}/#{lang}/blob/main/README.md#readme"

txt = [
  pug.compileFile(fp 'doc.head.pug')()+'\n'
]

add = (lang, name)=>
  txt.push "## [#{name}](#{readme lang})"


for [l,name] from lang
  md = (read fp l,'README.md').split '\n'

  add l,name
  for i,pos in md
    if i.startsWith '#'
      break

  for i from md[pos+1...]
    if i.startsWith '#'
      break
    txt.push i

  txt.push "[→ #{read(fp l,'_.link.md').trim()}](#{readme l})\n"

write(
  fp 'README.md'
  txt.join('\n')
)
