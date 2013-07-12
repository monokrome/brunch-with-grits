exports.config =
  server:
    port: 9999

  plugins:
    jaded:
      staticPatterns: /^app[\/\\].*[\/\\]jade[\/\\](.+)\.jade$/

    stylus:
      plugins: ['nib']

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
        ]
