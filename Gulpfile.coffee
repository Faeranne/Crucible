gulp = require 'gulp'
mocha = require 'gulp-mocha'
coveralls = require('gulp-coveralls')

gulp.task 'default', ->
	require './node_modules/nw/bin/nw'
	return

gulp.task 'test', ->
	gulp.src 'tests/*.coffee', read:false
		.pipe mocha
			reporter: 'spec'
		.pipe mocha
			reporter: 'mocha-lcov-reporter'
		.pipe coveralls()
