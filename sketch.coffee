Bull = require 'bull'
Express = require 'express'
BodyParser = require 'body-parser'
HTTP = require 'http'
Library = require './coffee/index'

# Configuration
config =
  port: process.env.PORT or 3000

# Service dependencies
queue = Bull 'commands', 6379, '127.0.0.1'
factory = new Library.CommandFactory()
pusher = new Library.BullPusher
  queue: queue

# Configure the service
service = new Library.CommandService
  factory: factory
  pusher: pusher

# Command routes
commands = new Express.Router()

commands.post '/addItem', (request, response) ->
  params = request.body
  service.addItem params, (error, command) ->
    return response.send 400, error if error
    response.send 202, command

# Configure app
app = Express()
app.use BodyParser.json()
app.use '/commands', commands

# Create the HTTP Server
server = HTTP.createServer app

# Start the server on the given port
server.listen config.port
