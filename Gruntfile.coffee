module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    browserify:
      dist:
        files:
          'public/js/bundle.js': ['src/index.coffee']
        options:
          transform: ['coffeeify']
    sass: compile: files: 'public/stylesheets/main.css': [ 'sass/main.scss' ]
    watch:
      browserify:
        files: 'src/**/*'
        tasks: 'browserify'
        options:
          livereload: true
      mocha:
        files: ['src/**/*.coffee', 'test/**/*.coffee']
        tasks: 'mochaTest'
      css:
        files: '**/*.scss',
        tasks: 'sass',
        options:
          livereload: true
    mochaTest:
      test:
        options:
          reporter: 'spec'
          require: ['coffee-script/register', 'chai']
          debug: true
          'check-leaks': true
          recursive: true
          sort: true
        src: ['test/**/*.coffee']

  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.registerTask 'default', [ 'sass', 'browserify', 'watch' ]
