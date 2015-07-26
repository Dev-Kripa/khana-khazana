global.__sRoot = __dirname
server = require "./app/server.coffee"

app = server()
console.log "listening on port 4000"
app.listen 4000
