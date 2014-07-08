express = require 'express'
router = express.Router()
path = require 'path'
pkg = require '../../package.json'

router.route '/:driver'
.get (req, res)->
  res.render 'database'
.post (req, res)->
  res.render 'database'

router.route '/:driver/:table'
.get (req, res)->
  res.render 'table', table: req.params.table
.post (req, res)->
  res.render 'table', table: req.params.table

router.get '/', (req, res)->
  res.render 'index'

module.exports = router