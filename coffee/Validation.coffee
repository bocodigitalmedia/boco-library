ValidationErrors = require './ValidationErrors'

module.exports = class Validation

  constructor: (props = {}) ->
    @subject = props.subject
    @errors = props.errors
    @setDefaults()

  setDefaults: ->
    @errors = new ValidationErrors() unless @errors?

  addError: (key, message) ->
    @errors.add key, message

  isInvalid: ->
    @errors.any()
