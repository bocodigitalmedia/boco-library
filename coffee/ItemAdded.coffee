module.exports = class ItemAdded
  constructor: (props = {}) ->
    @url = props.url
    @mimeType = props.mimeType
    @name = props.name
