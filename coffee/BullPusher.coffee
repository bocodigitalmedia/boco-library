AbstractPusher = require './AbstractPusher'

module.exports = class BullPusher extends AbstractPusher

  constructor: (props = {}) ->
    @queue = props.queue

  push: (command, callback) ->
    onSuccess = (result) -> callback()
    onError = (error) -> callback error
    @queue.add(command).then(onSuccess).catch(onError)
    return undefined
