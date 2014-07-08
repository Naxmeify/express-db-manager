# logger
log = require('debug') 'damncreative:api'

# requirements
log 'init requirements'
express = require 'express'
app = express()

path = require 'path'
mongoose = require 'mongoose'

# middleware
log 'init middleware'
bodyParser = require 'body-parser'
morgan = require 'morgan'
cookieParser = require 'cookie-parser'
session = require 'express-session'
favicon = require 'serve-favicon'
dm = require 'damn-middleware'
MongoStore = require('connect-mongo')(session)

i18n = require 'i18n'
i18n.configure
  locales:['en']
  directory: __dirname + '/locales'
  cookie: 'damndatabasesi18n'
  updateFiles: false

# config
log 'configure express'
log 'set port ' + (process.env.PORT || 3000)

app.set 'port', process.env.PORT || 3000

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.set 'view options',
  layout: true

app.locals.pretty = true

app.use favicon path.join __dirname, '../public/img/logo/favicon.ico'
app.use '/', express.static(path.join(__dirname, '../public'))

app.use morgan('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded
  extended: true
app.use cookieParser()
app.use session
  secret: 'damndatabases'
  store: new MongoStore
    url: 'mongodb://localhost:27017/damndatabases/sessions'

app.use i18n.init

if process.env.NODE_ENV is 'development'
  livereload = require('express-livereload')
  livereload app, 
    port: process.env.LIFERELOAD_PORT || 35728
    watchDir: __dirname

app.use (req, res, next)->
  if not req.session.driver?
    req.session.driver = {}
  next()

# breadcrump
app.use dm.view.breadcrumbs

# spa routes
app.use '/', require './routes/index'

app.use (req, res)->
  res.render '404'

# liste
log 'try to listen on port ' + app.get 'port'
app.listen app.get 'port'
log 'express listen on port ' + app.get 'port'