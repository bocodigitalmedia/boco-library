Command = require './Command'

class AddItem extends Command
  setParameters: (params) ->
    @parameters = new AddItem.Parameters params

class AddItem.Parameters extends Command.Parameters

  constructor: (props = {}) ->
    @url = props.url
    @mimeType = props.mimeType
    @name = props.name

  validate: ->
    v = validation = super
    v.addError 'url', 'must be present' unless @url?
    v.addError 'mimeType', 'must be present' unless @mimeType?
    v.addError 'name', 'must be present' unless @name?
    return validation

module.exports = AddItem
