merge = (target, source) ->
  for item of source
    if item in target
      # TODO: Not recursing, must misunderstand in operator.
      merge target[item], source[item]
    else
      target[item] = source[item]

# Application.
class Application extends Backbone.Marionette.Application

  # Constructor.
  constructor: (@options) ->
    super @options

    @initialize()

  # Setup initializers and start the application.
  initialize: ->
    @addInitializer @initSettings
    @addInitializer @initComponents
    @addInitializer @initRegions
    @addInitializer @initHistory

    @start()

  # Detects require errors.
  _isRequireError: (err) ->
    err.message.indexOf('Cannot find module') is 0

  # It is what it sounds like.
  _capitalize: (string) ->
    string.charAt(0).toUpperCase() + string.slice 1

  # Ensure reliable default settings.
  initSettings: ->
    @components =
      primary: 'core'
      system: 'core'
      active: ['core']
      core:
        history:
          pushState: off
          navToPrimary: off

    ## Merge settings into Application object.
    #merge Application.prototype, require('settings')

  # Load active components.
  initComponents: ->
    @routers = {}

    for component in @components.active
      # Attempt to require and construct router and controller.
      try
        name = @_capitalize(component) + 'Controller'

        controller = new (require component + '/controllers')[name]
          application: @

        router = new (require component + '/router') {controller}

      # Bubble unrelated errors, continue to next component.
      catch err
        throw err unless @_isRequireError err
        continue

      @routers[component] = router

      isPrimary = component is @components.primary

      # Prefix routes with component name.
      for route, handler of router.appRoutes?
        prefix = component + '/'
        newRoute = prefix + route + ('/' if route.length)

        console.log 'newRoute', newRoute

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
    settings = @components.core.history

    @on 'initialize:after', ->
      @history.start settings
      if @history.location.pathname is '/' and settings.navToPrimary
        @history.navigate @components.primary


module.exports = Application
