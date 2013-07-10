class Application extends Backbone.Marionette.Application
  initialize: ->
    @addInitializer @initializeComponents

    @start()

  initializeComponents: ->
    routers = {}

    for component in @components
      try
        Router = require "#{component}/router"
        Controller = require "#{component}/controller"

      catch err
        # Bubble non-import errors
        if err.message.indexOf 'Cannot find module' isnt 0
          throw err

        continue

      controller = new Controller application: @
      router = routers[component] = new Router controller: controller

      # Prefix component routes that aren't already
      if router.appRoutes?
        for route, handler of router.appRoutes
          prefix = "#{component}/"
          if route.indexOf prefix isnt 0
            newRoute = "#{prefix}#{route}/"
            router.appRoutes[newRoute] = handler
            delete router.appRoutes[route]

      # Reprocess router for this router's new routes to be applied.
      router.processAppRoutes controller, router.appRoutes

  
# Merge settings into Application object
_.extend Application.prototype, require 'settings'

module.exports = Application
