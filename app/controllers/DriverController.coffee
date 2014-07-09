uuid = require 'node-uuid'
drivers = require '../drivers'
exports = module.exports

exports.index = (req, res)->
  res.render 'connections/list', connections: req.session.driver[req.params.driver]

exports.add = (req, res)->
  # TODO test connection
  drivers.testConnection req.params.driver, req.body, (err)->
    if err
      body = req.body
      body.err = err
      req.session.newbody = body
      return res.redirect req.url + '/new'
      #return res.render 'forms/'+req.params.driver+'_form', body

    # TODO Extract save Method?
    if not req.session.driver[req.body.driver]?
      req.session.driver[req.body.driver] = {}

    conId = uuid.v1();
    req.session.driver[req.params.driver][conId] = {}
    req.session.driver[req.params.driver][conId].host = req.body.host or 'localhost'
    req.session.driver[req.params.driver][conId].port = req.body.port or '3306'
    req.session.driver[req.params.driver][conId].user = req.body.user or 'root'
    req.session.driver[req.params.driver][conId].password = req.body.password or 'root'

    res.redirect req.url + '/' + conId

exports.show = (req, res)->
  if req.session.driver[req.params.driver]?
    if req.session.driver[req.params.driver][req.params.connectionId]?
      dbDriver = drivers.getDriver req.params.driver
      console.log dbDriver
      return dbDriver.getDatabases req.session.driver[req.params.driver][req.params.connectionId], (err, rows)->
        res.render 'connections/view', 
          databases: rows
          err: err
  res.render '404'

exports.new = (req, res)->
  body = req.session.newbody
  delete req.session.newbody if req.session.newbody
  res.render 'forms/'+req.params.driver+'_form', body

exports.edit = (req, res)->
  if req.session.driver[req.params.driver]?
    if req.session.driver[req.params.driver][req.params.connectionId]?
      return res.render 'forms/'+req.params.driver+'_form',
        connectionId: req.params.connectionId
        host: req.session.driver[req.params.driver][req.params.connectionId].host
        port: req.session.driver[req.params.driver][req.params.connectionId].port
        user: req.session.driver[req.params.driver][req.params.connectionId].user
        password: req.session.driver[req.params.driver][req.params.connectionId].password
 
  res.render '404'

exports.update = (req, res)->
  if req.session.driver[req.params.driver]?
    if req.session.driver[req.params.driver][req.params.connectionId]?
      req.session.driver[req.params.driver][req.params.connectionId].host = req.body.host or 'localhost'
      req.session.driver[req.params.driver][req.params.connectionId].port = req.body.port or '3306'
      req.session.driver[req.params.driver][req.params.connectionId].user = req.body.user or 'root'
      req.session.driver[req.params.driver][req.params.connectionId].password = req.body.password or 'root'
      return res.redirect req.url
  res.render '404'

exports.delete = (req, res)->
  if req.session.driver[req.params.driver]?
    if req.session.driver[req.params.driver][req.params.connectionId]?
      delete req.session.driver[req.params.driver][req.params.connectionId]
      return res.redirect '/'+req.params.driver
  res.render '404'