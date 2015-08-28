module.exports = (app) ->
  'get /': (req, res) ->
    res.json 
      info: res.locals.manifest.name
      version: res.locals.manifest.version