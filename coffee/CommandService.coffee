InvalidCommand = require './InvalidCommand'

module.exports = class CommandService

  constructor: (props = {}) ->
    @pusher = props.pusher
    @factory = props.factory

  execute: (command, params, callback) ->
    command.setParameters params
    validation = command.validateParameters()

    if validation.isInvalid()
      error = new InvalidCommand()
      error.setPayload validation: validation
      return callback error

    @pusher.push command, (error) ->
      return callback error if error?
      callback null, command

  addItem: (params = {}, callback) ->
    @execute @factory.addItem(), params, callback
