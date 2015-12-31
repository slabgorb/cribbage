module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    browserify:
      dist:
        files:
          'bundle.js': ['src/index.coffee']
        options:
          transform: ['coffeeify']

  grunt.loadNpmTasks 'grunt-browserify'
  grunt.registerTask 'default', [ 'browserify' ]
