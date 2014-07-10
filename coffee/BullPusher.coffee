AbstractPusher = require './AbstractPusher'

module.exports = class BullPusher extends AbstractPusher

  constructor: (props = {}) ->
    @queue = props.queue

  push: (command, callback) ->

    onSuccess = (result) ->
      console.log "queue push success:", result
      callback()
      return result

    console.log "Command", command
    @queue.add(command).then(onSuccess).catch (error) ->
      console.log error
      throw error

    return undefined
