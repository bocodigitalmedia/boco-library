NotImplemented = require './NotImplemented'
Validation = require './Validation'

class Command

  constructor: (props = {}) ->
    @id = props.id
    @name = props.name
    @setParameters props.parameters
    @setDefaults()

  setDefaults: ->
    @name = @constructor.name unless @name?

  setParameters: (params) ->
    @parameters = new Command.Parameters params

  validateParameters: ->
    @parameters.validate()

class Command.Parameters
  constructor: (props = {}) ->
    this[key] = value for own key, value of props

  validate: ->
    validation = new Validation subject: this

module.exports = Command
