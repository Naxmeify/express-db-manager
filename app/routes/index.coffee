express = require 'express'
router = express.Router()
path = require 'path'
pkg = require '../../package.json'

router.get '/', (req, res)->
  res.render 'index'

module.exports = router