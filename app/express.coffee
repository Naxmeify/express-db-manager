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
favicon = require 'serve-favicon'

i18n = require 'i18n'
i18n.configure
    locales:['en']
    directory: __dirname + '/locales'

# config
log 'configure express'
log 'set port ' + (process.env.PORT || 3000)

app.set 'port', process.env.PORT || 3000

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.set 'view options',
  layout: true

app.locals.pretty = true

app.use (req, res, next)->
  next()

 app.use i18n.init

app.use favicon path.join __dirname, '../public/img/logo/favicon.ico'
app.use morgan('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded
  extended: true

if process.env.NODE_ENV is 'development'
  livereload = require('express-livereload')
  livereload app, 
    port: process.env.LIFERELOAD_PORT || 35728
    watchDir: __dirname

app.use '/', express.static(path.join(__dirname, '../public'))

# spa routes
app.use '/', require './routes/index'

# liste
log 'try to listen on port ' + app.get 'port'
app.listen app.get 'port'
log 'express listen on port ' + app.get 'port'