module.exports = class ValidationErrors

  constructor: (collection = {}) ->
    this[key] = messages for key, messages of collection

  add: (key, message) ->
    this[key] = [] unless this[key]?
    this[key].push message

  any: ->
    Object.getOwnPropertyNames(this).length > 0
