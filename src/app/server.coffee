# s = require 's-core'
connect = require "connect"
render = require "render"
express = require "express"
serveStatic = require "serve-static"
path = require "path"
bodyParser = require('body-parser')
gulp = require "gulp"
runSequence = require "gulp-run-sequence"


module.exports = () ->
  app = express()

  gulp.task "jade", (callback) ->
    return gulp.src("src/views/*.jade")
      .pipe jade()
      .pipe gulp.dest("src/public/html")
    runSequence "jade", [], callback

  console.log '/src/public'
  app
    .set("views", "src/views")
    .set('view engine', 'jade')
    .set("stylesheet", "src/views")
    .use('/', express.static(path.join(__sRoot, 'src/public')))
    .use(bodyParser.json())
    .use(bodyParser.urlencoded({extended: true}))

    .get "/", (req, res)->
      res.render "recepies", {}

  .use (req, res, next) ->
    next()
