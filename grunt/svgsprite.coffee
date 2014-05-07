module.exports = (grunt) ->
  development:
    src: ['<%= grunt.appDir %>/svgs']
    dest: '<%= grunt.publicDir %>/stylesheets'
