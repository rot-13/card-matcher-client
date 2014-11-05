module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON('package.json')

    compass:
      dist:
        options:
          sassDir: 'src/scss'
          cssDir: 'public/css'

    browserify:
      dist:
        options:
          transform: ['coffeeify', 'jadeify']
        files:
          'public/js/index.js': ['src/coffee/**/*.coffee', 'src/jade/**/*.jade']

    # for templates not loaded from require(), mainly index.html which is generated from index.jade
    jade:
      compile:
        options:
          data:
            debug: true
        files:
          "public/index.html": ["src/jade/index.jade"]

    imagemin:
      dynamic:
        files: [
          expand: true
          cwd: 'src/images'
          src: ['**/*.{png,jpg,gif}']
          dest: 'public/images'
        ]

    watch:
      sass:
        files: 'src/scss/**/*.scss'
        tasks: ['compass']
      coffee:
        files: 'src/coffee/**/*.coffee'
        tasks: ['coffee']
      haml:
        files: 'src/haml/**/*.haml'
        tasks: ['haml']
      images:
        files: 'src/images/**'
        tasks: ['imagemin']

  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-contrib-compass')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-haml')
  grunt.loadNpmTasks('grunt-contrib-imagemin')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-jade')

  grunt.registerTask('compile', ['compass', 'jade', 'browserify', 'imagemin'])
  grunt.registerTask('default', ['compile', 'watch'])