BocoError = require 'boco-error'

module.exports = class AbstractPusher
  push: (command, callback) -> throw new BocoError.NotImplemented()
