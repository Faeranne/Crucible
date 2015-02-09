sinon = require 'sinon'
assert = require 'assert'
helpers = require '../libs/helpers'

describe 'helpers', ->
	describe '#getDirectory', ->
		os = require 'os'
		process.env.HOME = "/home/test/"
		process.env.APPDATA = "/users/test/appdata/roaming/"
		describe 'windows', ->
			before () ->
				sinon.stub(os, 'platform').returns('win64')
			after () ->
				os.platform.restore()
			it 'should return the .minecraft directory', ->
				dir = helpers.getDirectory()
				assert.equal '/users/test/appdata/roaming/.minecraft', dir
		describe 'linux', ->
			before () ->
				sinon.stub(os, 'platform').returns('linux')
			after () ->
				os.platform.restore()
			it 'should return the .minecraft directory', ->
				dir = helpers.getDirectory()
				assert.equal '/home/test/.minecraft', dir
								
