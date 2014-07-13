BocoCommand = require 'boco-command'

class AddItem extends BocoCommand.Command

  setParameters: (params = {}) ->
    @parameters =
      url: params.url
      mimeType: params.mimeType
      name: params.name

  validateParameters: ->
    v = validation = super()
    p = @parameters
    v.addError 'url', 'must be present' unless p.url?
    v.addError 'mimeType', 'must be present' unless p.mimeType?
    v.addError 'name', 'must be present' unless p.name?
    return validation

module.exports = AddItem
