CustomError = require './CustomError'

module.exports = class NotImplemented extends CustomError
  setDefaults: ->
    @message = "not implemented."
    super
