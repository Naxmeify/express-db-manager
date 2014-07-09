log = require('debug') 'damndatabases:MySQLDriver'
exports = module.exports
mysql = require 'mysql'
_ = require 'lodash'

exports.connect = (credentials, cb)->
  credentials = _.extend credentials, {}
    # debug: true
  connection = mysql.createConnection credentials
  connection.connect (err)->
    cb(err, connection)

exports.getDatabases = (credentials, cb)->
   @connect credentials, (err, connection)->
    connection.query 'SHOW DATABASES', cb

exports.test = (credentials, cb)->
  @connect credentials, (err, connection)->
    cb err, connection
    destroy connection

destroy = (connection)->
  connection.destroy() if connection.state is 'authenticated'
    