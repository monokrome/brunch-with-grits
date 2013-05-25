exports.config =
  plugins:
    jaded:
      staticPatterns: /^app(\/|\\)(.+)\.jade$/

  files:
    javascripts:
      joinTo:
        'scripts/app.js': /^app/
        'scripts/vendor.js': /^vendor/

      order:
        before: [
          'vendor/scripts/jquery-1.9.1.js'
          'vendor/scripts/lodash.underscore.js'
          'vendor/scripts/backbone.js'
          'vendor/scripts/backbone.marionette.js'

        ]

    stylesheets:
      joinTo:
        'styles/app.css': /^app/
        'styles/vendor.css': /^vendor/
