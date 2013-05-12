exports.config =
  files:
    javascripts:
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^vendor/
      order:
        before: [
          'vendor/scripts/jquery-1.9.1.js'
        ]

    stylesheets:
      joinTo:
        'stylesheets/app.css': /^app/
        'stylesheets/vendor.css': /^vendor/
      order:
        before: []
        after: []

    templates:
      joinTo: 'javascripts/app.js'
