uuid = require 'node-uuid'
drivers = require '../drivers'
exports = module.exports

exports.index = (req, res)->
  res.render 'connections/list', connections: req.session.driver[req.params.driver]

exports.add = (req, res)->
  # TODO test connection

  # TODO Extract save Method?
  if not req.session.driver[req.body.driver]?
    req.session.driver[req.body.driver] = {}

  conId = uuid.v1();
  req.session.driver[req.body.driver][conId] = {}
  req.session.driver[req.body.driver][conId].host = req.body.host or 'localhost'
  req.session.driver[req.body.driver][conId].user = req.body.user or 'root'
  req.session.driver[req.body.driver][conId].pass = req.body.pass or 'root'

  res.redirect req.url

exports.show = (req, res)->
  if req.session.driver[req.params.driver]?
    if req.session.driver[req.params.driver][req.params.connectionId]?
      # dummy test
      drivers.testConnection req.params.driver, req.session.driver[req.params.driver][req.params.connectionId], (err)->
        console.log err

      dbDriver = drivers.getDriver req.params.driver
      
      return res.render 'connections/view'
  res.render '404'
exports.new = (req, res)->
  res.render 'forms/'+req.params.driver+'_form', driver: req.params.driver

exports.edit = (req, res)->
  if req.session.driver[req.params.driver]?
    if req.session.driver[req.params.driver][req.params.connectionId]?
      return res.render 'forms/'+req.params.driver+'_form', 
        driver: req.params.driver
        connectionId: req.params.connectionId
        host: req.session.driver[req.params.driver][req.params.connectionId].host
        user: req.session.driver[req.params.driver][req.params.connectionId].user
        pass: req.session.driver[req.params.driver][req.params.connectionId].pass
 
  res.render '404'

exports.update = (req, res)->
  if req.session.driver[req.params.driver]?
    if req.session.driver[req.params.driver][req.params.connectionId]?
      req.session.driver[req.params.driver][req.params.connectionId].host = req.body.host or 'localhost'
      req.session.driver[req.params.driver][req.params.connectionId].user = req.body.user or 'root'
      req.session.driver[req.params.driver][req.params.connectionId].pass = req.body.pass or 'root'
      return res.redirect req.url
  res.render '404'

exports.delete = (req, res)->
