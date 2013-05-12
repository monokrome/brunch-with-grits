exports.config =
  plugins:
    jade:
      options:
        pretty: yes
    static_jade:
      extension: '.jade'
  files:
    javascripts:
      joinTo:
        'scripts/app.js': /^app/
        'scripts/vendor.js': /^vendor/
      order:
        before: [
          'vendor/scripts/jquery-1.9.1.js'
        ]

    stylesheets:
      joinTo:
        'styles/app.css': /^app/
        'styles/vendor.css': /^vendor/
      order:
        before: []
        after: []
