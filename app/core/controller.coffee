class CoreController extends Marionette.Controller
  initialize: (options) ->
    {application} = options

    # TODO Layout/Regions

    application.on 'initialize:after', ->
      @history = Backbone.history

      @freeze?()

      @history.start pushState: true
      @history.navigate @defaultComponent

module.exports = CoreController
