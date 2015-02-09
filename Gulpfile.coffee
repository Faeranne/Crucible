gulp = require 'gulp'
mocha = require 'gulp-mocha'

gulp.task 'default', ->
	require './node_modules/nw/bin/nw'
	return

gulp.task 'test', ->
	gulp.src 'tests/*.coffee', read:false
		.pipe mocha
			reporter: 'spec'

