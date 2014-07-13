BocoError = require 'boco-error'

module.exports = class InvalidCommand extends BocoError.CustomError
  setPayload: (props = {}) ->
    @payload = validation: props.validation

  setDefaults: ->
    @message = 'Invalid command.' unless @message?
    super()
