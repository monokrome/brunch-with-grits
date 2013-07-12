# Deep merge objects
# TODO: This is shoddy.  Boofs arrays because they're treated as dicts.
merge = (target, source) ->
  targetKeys = _.keys target
  for key, value of source
    if key in targetKeys and _.isObject value
      merge target[key], value
    else
      target[key] = value


# Application.
class Application extends Backbone.Marionette.Application

  # Constructor.
  constructor: (@options) ->
    super @options

    @initialize()

  # Setup initializers and start the application.
  initialize: ->
    @addInitializer @initOptions
    @addInitializer @initComponents
    @addInitializer @initRegions
    @addInitializer @initHistory

    @start()

  # Ensure reliable defaults.
  initOptions: ->
    @options ?= {}

    merge @options,
      components:
        primary: ''
        active: []

      core:
        history:
          pushState: off
          navToPrimary: off

    merge @options, require 'options'

  # Load active components.
  initComponents: ->
    @routers = {}

    for component in @options.components.active
      controller = new (require component + '/controller') application: @
      router = new (require component + '/router') {controller}

      @routers[component] = router

      isPrimary = component is @options.components.primary

      # Prefix routes with component name.
      for route, handler of router.appRoutes?
        prefix = component + '/'
        newRoute = prefix + route + ('/' if route.length)

        router.appRoutes[newRoute] = handler

        # Don't delete '' route if isPrimary.
        if route.length or (not route.length and isPrimary)
          delete router.appRoutes[route]

      router.processAppRoutes controller, router.appRoutes

  initRegions: ->
    @regions ?= {}

    @on 'initialize:after', ->
      @addRegions @regions

    #@regions.layout ?= body: Marionette.Layout

  initHistory: ->
    @history = Backbone.history
    options = @options.core.history

    @on 'initialize:after', ->
      @history.start options
      if @history.location.pathname is '/' and options.navToPrimary
        @history.navigate @options.components.primary


module.exports = Application
