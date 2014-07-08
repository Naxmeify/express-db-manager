exports = module.exports
mysql = require 'mysql'

exports.test = (credentials, cb)->
  console.log credentials
  connection = mysql.createConnection credentials
  connection.connect (err)->
    return cb err, false if err
    cb err, true unless err
    connection.destroy()