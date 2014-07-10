CustomError = require './CustomError'

module.exports = class InvalidCommand extends CustomError
  setPayload: (props = {}) ->
    @payload = validation: props.validation

  setDefaults: ->
    @message = 'Invalid command.' unless @message?
    super
