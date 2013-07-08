class Application extends Backbone.Marionette.Application
  components: require 'components'

  regions: {}

  initialize: ->
    @addInitializer @initializeRegions
    @addInitializer @initializeComponents

    @on 'initialize:after', @startHistory

    @start()

  initializeComponents: ->
    routers = {}

    for component in @components
      {Router} = require "#{component}/router"
      {Controller} = require "#{component}/controller"

      initializers = require "#{component}/initializers"

      for name, initializer of initializers
        @addInitializer initializer

      controller = new Controller
        application: @

      router = routers[component] = new Router
        controller: controller

      # Enforce standard convention for separation of controller methods
      if router.routes? then throw """

        Please use appRoutes instead of routes in
        #{controller.constructor.name}. This is the conventional method
        for routing requests in Marionette.

        See Marionette.AppRouter for details: http://goo.gl/sc0uZ

        """

      # Enforce namespaced URLs prefixed with component name
      if router.appRoutes?
        for route, handler of router.appRoutes
          prefix = "#{component}/"
          newRoute = "#{prefix}#{route}/"
          prefixIndex = route.indexOf prefix

          if prefixIndex == 0
            throw """

              You do not need to prefix routes in #{router.constructor.name}
              with "#{prefix}". It will be added automatically. Please remove
              the prefix to prevent this error.

            """

          # Set up the new route, and remove the old one.
          router.appRoutes[newRoute] = handler
          delete router.appRoutes[route]

      # Reprocess router for this router's new routes to be applied.
      router.processAppRoutes controller, router.appRoutes

    @components.routers = routers

  initializeRegions: ->
    if @regions? then @addRegions @regions

  startHistory: ->
    Backbone.history.start
      pushState: true

    @freeze?()


module.exports = Application
