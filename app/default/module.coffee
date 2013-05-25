application = require 'application'

class Module extends application.Module
  initialize: ->
    console.log 'default'

module.exports = Module
