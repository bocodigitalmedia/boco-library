module.exports = class CustomError

  constructor: (props = {}) ->
    Error.call this
    if typeof Error.captureStackTrace is 'function'
      Error.captureStackTrace this, @constructor
    @name = props.name
    @message = props.message
    @occurredAt = props.occurredAt
    @setPayload props.payload
    @setDefaults()

  setDefaults: ->
    @name = @constructor.name unless @name?
    @message = "An error has occurred." unless @message?
    @occurredAt = new Date() unless @occurredAt?

  setPayload: (payload) ->
    @payload = payload
