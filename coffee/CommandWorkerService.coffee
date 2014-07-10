ResourceTypes = require './ResourceTypes'
ItemAdded = require './ItemAdded'

module.exports = class CommandWorkerService

  constructor: (props = {}) ->
    @sourced = props.sourced

  addItem: (command, callback) ->
    params = command.parameters
    revision = @sourced.createRevision ResourceTypes.LibraryItem

    itemAdded = new ItemAdded
      url: params.url
      mimeType: params.mimeType
      name: params.name

    revision.addEvent ItemAdded.name, itemAdded

    @sourced.storeRevision revision, (error) ->
      callback error
