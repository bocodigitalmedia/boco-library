Bull = require 'bull'
Express = require 'express'
BodyParser = require 'body-parser'
HTTP = require 'http'
Library = require './coffee/index'
BocoCommand = require 'boco-command'

# Service dependencies
queue = Bull 'library.commands'

# Command factory for library commands
factory = new BocoCommand.CommandFactory()
factory.register AddItem: Library.AddItem

# Command routes
commands = new Express.Router()

# Ensure json request
commands.use (request, response, next) ->
  return next() if request.is 'application/json'
  error = new Error()
  error.name = "ContentTypeInvalid"
  error.message = "The requested Content-Type MUST be 'application/json'"
  next error

# Parse json request
commands.use BodyParser.json()

# Create a command
commands.post '/', (request, response) ->
  name = request.body.name
  params = request.body.parameters

  command = factory.construct name
  command.setParameters params

  validation = command.validateParameters()

  if validation.isInvalid()
    error = new Error()
    error.name = "CommandParametersInvalid"
    error.message = "One or more parameters supplied for the requested command are invalid."
    error.payload = validation
    throw error

  response.json 200, command

# Handle Errors
commands.use (error, request, response, next) ->
  view = name: error.name, message: error.message
  view.payload = error.payload if error.payload?

  switch error.name
    when "CommandNotRegistered" then response.json 400, view
    when "ContentTypeInvalid" then response.json 406, view
    when "CommandParametersInvalid" then response.json 406, view
    else next error

# Configure app
app = Express()

# Route commands
app.use '/commands', commands

# Create the HTTP Server
server = HTTP.createServer app

# Start the server on the given port
server.listen process.env.PORT, ->
  console.log "Server started", server.address()
