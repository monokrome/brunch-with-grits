modules = require 'modules'

class Application extends Backbone.Marionette.Application
  initialize: ->
    @on 'initialize:after', @startHistory

    @addInitializer @initializeModules

    @start()
    
  startHistory: (options) -> Backbone.history.start()

  initializeModules: ->
    for name in modules
      module = require name + '/module'

      @module name, new module

class Module
  initialize: ->

  constructor: (@module, @app, @backbone, @marionette, @$, @_) ->
    @initialize()

module.exports = {
  Application
  Module
}
