app = require('express')()
express = require('express')
http = require('http').Server(app)
io = require('socket.io')(http)
path = require 'path'

port = 3001

app.use(express.static('public'))

app.get '/', (req, res) ->
  res.sendFile('index.html', root: path.join(__dirname, '../public'))

http.listen port, ->
  console.log("listening on *:#{port}")
