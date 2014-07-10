Bull = require 'bull'
Library = require './coffee/index'

queue = Bull 'commands', 6379, '127.0.0.1'
factory = new Library.CommandFactory()
pusher = new Library.BullPusher queue: queue

service = new Library.CommandService
  factory: factory
  pusher: pusher

params =
  url: 'http://example.com/example.pdf'
  mimeType: 'application/pdf'
  name: 'Example PDF'

handleInvalidCommand = (error) ->
  console.log "Invalid command", error.payload.validation

test = ->
  service.addItem params, (error, command) ->
    if error? and error instanceof Library.InvalidCommand
      return handleInvalidCommand error

    throw error if error?

    console.log "Command accepted", command

test()
