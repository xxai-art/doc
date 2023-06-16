#!/usr/bin/env coffee

> zx/globals:
  @w5/uridir
  path > join
  @w5/lang
  fs > existsSync
  ./ORG

ROOT = uridir(import.meta)

ing = []

for [code] from lang
  dir = join ROOT, code
  if not existsSync dir
    ing.push $"git clone --depth=1 git@github.com:#{ORG}/#{code}.git"

await Promise.all ing
