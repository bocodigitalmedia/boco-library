AddItem = require './AddItem'

module.exports = class CommandFactory

  generateId: ->
    require('uuid').v4()

  addItem: (props) ->
    command = new AddItem props
    command.id = @generateId() unless command.id?
    return command
