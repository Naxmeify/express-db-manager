express = require 'express'
router = express.Router()
path = require 'path'
pkg = require '../../package.json'

# Controller
DriverController = require '../controllers/DriverController'
DriverController = require '../controllers/DriverController'

# Driver and Connection
router.route '/:driver'
.get DriverController.index
.post DriverController.add

router.route '/:driver/new'
.get DriverController.new

router.route '/:driver/:connectionId'
.get DriverController.show
.post DriverController.update

router.route '/:driver/:connectionId/edit'
.get DriverController.edit

router.route '/:driver/:connectionId/delete'
.get DriverController.delete

# Tables
router.route '/:driver/:connectionId/tables/new'

# Dashboard
router.get '/', (req, res)->
  res.render 'index'

module.exports = router