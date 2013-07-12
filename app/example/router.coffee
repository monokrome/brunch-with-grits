{Router} = require 'core/routers'

class ExampleRouter extends Router
  appRoutes:
    '': 'index'
    'whoa': 'whoa'


module.exports = ExampleRouter
