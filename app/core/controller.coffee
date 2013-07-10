class CoreController extends Marionette.Controller
  initialize: (options) ->
    {application} = options

    regions = application.regions ? {}
    regions.primary ?= 'body'

    application.regions = regions

    application.on 'initialize:after', ->
      @addRegions @regions

      @history = Backbone.history
      @history.start pushState: true
      @history.navigate @defaultComponent

      @freeze?()


module.exports = CoreController
