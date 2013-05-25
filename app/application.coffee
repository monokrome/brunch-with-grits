modules = require 'modules'

class Application extends Backbone.Marionette.Application
  initialize: ->
    @on 'initialize:after', @startHistory

    @addInitializer @initializeModules

    @start()
    
  startHistory: (options) -> Backbone.history.start()

  initializeModules: ->
    @modules = []

    for name in modules
      module = require name + '/module'

      @modules.push new module()

class Module
  constructor: (@module, @app, @backbone, @marionette, @$, @_) ->
    @initialize()

  initialize: ->

module.exports = {
  Application
  Module
}
