core = require 'core'

console.log 'tits'
console.dir core

class ExampleController extends core.Controller
  index: ->
    console.log 'example index'

  whoa: ->
    console.log 'example whoa'


module.exports = {ExampleController}
