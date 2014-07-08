express = require 'express'
router = express.Router()
path = require 'path'
i18n = require 'i18n'
pkg = require '../../package.json'

i18n.configure
    locales:['en']
    directory: __dirname + '/../locales'

# breadcrump
router.use (req, res, next)->
  res.locals.breadcrump = []
  console.log req.url.split('/')[1]
  console.log i18n._(req.url.split('/')[1])
  next()

router.get '/mysql', (req, res)->
  res.render 'index'
router.get '/', (req, res)->
  res.render 'index'

module.exports = router