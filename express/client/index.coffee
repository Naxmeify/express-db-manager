path = require 'path'

express = require 'express'
routesmanager = require 'express-routes-manager'

favicon = require 'serve-favicon'
ConnectMincer = require 'connect-mincer'

LOG = require('debug') 'express:db-manager:client'

LOG "init express application"
app = express()
app.on 'mount', (parent) ->
  app.set 'parent', parent

LOG "set views folder"
app.set 'views', path.resolve __dirname, 'views'

LOG "set view engine"
app.set 'view engine', 'jade'
app.locals.pretty = true

LOG "run routesmanager for app"  
routesmanager app

LOG "use favicon"
app.use favicon path.resolve __dirname, '..', 'public', 'favicon.ico'

LOG "use static for public folder"
app.use express.static path.resolve(__dirname, 'public'),
    redirect: false
    
LOG "use mincer for assets"
connectMincer = new ConnectMincer
  root: __dirname
  production: app.get('env') is 'production'
  mountPoint: '/assets'
  manifestFile: path.resolve __dirname, 'public/assets/manifest.json'
  paths: [
    'assets/css'
    'assets/js'
    'assets/templates'
    'assets/vendor'
  ]
app.use connectMincer.assets()
app.use '/assets', connectMincer.createServer() unless app.get('env') is 'production'

LOG "load routes"
app.loadRoutes 
  '/': (req, res) -> res.render 'application'
  
LOG "export application"
module.exports = app;