# coffeelint: disable=no_debugger
fs = require('fs')
path = require('path')

{ spawn, spawnSync } = require 'child_process'

src = 'cs'
dest = 'src'

destFrom = (src) ->
  # split the src path up and replace the beginning with the dest
  pathArray = src.split('/')
  pathArray[0] = dest
  # put it back together
  pathArray.join('/')

copy = (src) ->
  if path.extname(src) is '.coffee'
    return
  localDest = destFrom src
  paths = path.dirname(localDest).split('/')
  currentPath = ''
  for folder, i in paths
    currentPath +=
      if i is 0
        folder
      else
        "/#{folder}"
    fs.mkdirSync currentPath if not fs.existsSync currentPath
  console.log "Copying #{src} to #{localDest}"
  fs.createReadStream(src)
    .pipe(fs.createWriteStream(localDest))
  # fs.copyFileSync(src, localDest)

rm = (name) ->
  spawnSync 'rm', ['-rf', name]

copyDecaf = (src) ->
  list = fs.readdirSync src
  for value in list when path.extname(value) isnt '.coffee'
    # get the full source path
    srcPath = "#{src}/#{value}"
    # get the stats for said path
    stats = fs.statSync srcPath

    # Get the destination from the srcPath
    destPath = destFrom srcPath

    if stats.isDirectory()
      unless fs.existsSync destPath
        fs.mkdirSync destPath
      copyDecaf srcPath
    else
      copy srcPath

watchDecaf = (src) ->
  console.log "watching #{src} -- beginning --"
  files = fs.watch src, { recursive: true }, (eventType, filename) ->
    filename = 'cs/' + filename
    if fs.existsSync filename
      copy filename
    else
      localDest = destFrom(filename)
      if fs.existsSync localDest
        rm localDest

build = (callback) ->
  # copy build files from src directory
  rm dest
  unless fs.existsSync dest
    fs.mkdirSync dest
  copyDecaf src

  # compile coffee files
  coffee = spawnSync 'coffee', ['-cb', '-o', dest, src]
  console.log coffee.stderr.toString() # in case there is an error

  # once that is done start the react server
  react = spawn 'react-scripts', ['build']
  react.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  react.stdout.on 'data', (data) ->
    console.log data.toString()
  react.on 'exit', (code) ->
    callback?() if code is 0

start = (callback) ->
  rm dest
  unless fs.existsSync dest
    fs.mkdirSync dest
  copyDecaf src
  watchDecaf src

  # start watching coffeescripts
  coffee = spawn 'coffee', ['-cbw', '-o', dest, src]
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    console.log data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0

  # start watching javascripts
  react = spawn 'react-scripts', ['start']
  react.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  react.stdout.on 'data', (data) ->
    console.log data.toString()
  react.on 'exit', (code) ->
    callback?() if code is 0

brew = (callback) ->
  rm dest
  unless fs.existsSync dest
    fs.mkdirSync dest
  copyDecaf src
  watchDecaf src

  # start watching coffeescripts
  coffee = spawn 'coffee', ['-cbw', '-o', dest, src]
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    console.log data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0

task 'brew', 'compiling coffee files only', -> brew()
task 'build', 'Build src/ from cs/', -> build()
task 'start', 'Watch src/ and compile into cs/', ->
  start()
