walk = (path) ->
  fs.readdirSync(path).forEach (file) ->
    sub = path + "/" + file
    stat = fs.statSync(sub)
    if stat.isFile()
      name = file.split(".")[0]
      exports[name] = require(sub)

fs = require("fs")
exports = module.exports
walk __dirname + "/drivers"

exports.getDriver = (driver)->
  switch driver
    # SQL
    when 'mysql'
      return @MySQLDriver
    when 'postgresql'
      return @PostgreSQLDriver
    when 'mssql'
      return @MSSQLDriver
    when 'sqlite'
      return @SQLiteDriver

    # NoSQL
    when 'mongodb'
      return @MongoDBDriver
    when 'couchdb'
      return @CouchDBDriver

    # Key-Value
    when 'redis'
      return @RedisDBDriver
    
  

exports.testConnection = (driver, credentials, cb)->
  console.log credentials
  DBDriver = @getDriver driver

  DBDriver.test credentials, cb