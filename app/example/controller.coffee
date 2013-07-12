{Controller} = require 'core/controllers'

class ExampleController extends Controller
  index: ->
    console.log 'example index'

  whoa: ->
    console.log 'example whoa'


module.exports = ExampleController
