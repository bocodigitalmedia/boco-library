NotImplemented = require './NotImplemented'

module.exports = class AbstractPusher
  push: (command, callback) -> throw new NotImplemented()
