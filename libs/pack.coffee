fs = require 'fs'
path = require 'path'
helpers = require './helpers'
request = require 'sync-request'

module.exports = self =	(name) ->
	if name.startsWith("http://")
		@_pack = helpers.fetchJson(name)
		@path = path.join helpers.getDirectory(), 'modpacks', pack.name
	else
		@path = path.join helpers.getDirectory(), 'modpacks', name
		if fs.existsSync path.join @path, 'pack.json'
			@_pack = JSON.parse fs.readFileSync path.join @path, 'pack.json'
			@installed = true
			@mods = @_pack.mods
		else
			@installed = false
			@_pack = {}
			@_pack.mods = helpers.getModList @path
			@_pack.name = name
			@mods = @_pack.mods
	@save = ->
		fs.writeFileSync path.join(@path, 'pack.json'), 
			JSON.stringify(@_pack)
	return this
