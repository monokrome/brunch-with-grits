core = require 'core'

class ExampleRouter extends core.Router
  appRoutes:
    '': 'index'
    'whoa': 'whoa'


module.exports = ExampleRouter
