supertest = require 'supertest'

app = require '../..'
request = supertest app

describe "Main Application", ->
  context "MOUNT /api", ->
    it "should response 200", (done) ->
      request.get '/api'
      .expect 200, done
  context "MOUNT /", ->
    it "should response 200", (done) ->
      request.get '/'
      .expect 200, done