exports.config =
  server:
    port: 9999

  conventions:
    assets: /static(\/|\\)/

  plugins:
    jaded:
      staticPatterns: /^app(\/|\\)((?!.*templates).*)\.jade$/

  files:
    stylesheets:
      joinTo:
        'styles/app.css': /^app/
        'styles/vendor.css': /^vendor/

    javascripts:
      joinTo:
        'scripts/app.js': /^app/
        'scripts/vendor.js': /^vendor/

      order:
        before: [
          'vendor/scripts/jquery.js'
          'vendor/scripts/lodash.underscore.js'
          'vendor/scripts/backbone.js'
          'vendor/scripts/backbone.marionette.js'
          'vendor/scripts/bootstrap.js'
        ]
