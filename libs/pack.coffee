fs = require 'fs'
path = require 'path'
helpers = require './helpers'
request = require 'sync-request'

module.exports = self =	(name) ->
	if name.match("http://")
		@_pack = helpers.fetchJson(name)
		@path = path.join helpers.getDirectory(), 'modpacks', @_pack.name
		console.log @_pack
	else
		@path = path.join helpers.getDirectory(), 'modpacks', name
		if fs.existsSync path.join @path, 'pack.json'
			@_pack = JSON.parse fs.readFileSync path.join @path, 'pack.json'
			@installed = true
		else
			@installed = false
			@_pack = {}
			@_pack.mods = helpers.getModList @path
			@_pack.name = name
			@_pack.args = ""
			@_pack.forge = ""
			@_pack.url = ""
	@args = @_pack.args
	@mods = @_pack.mods
	@forge = @_pack.forge
	@url = @_pack.url
	@save = ->
		@_pack.mods = @mods
		@_pack.args = @args
		@_pack.forge = @forge
		@_pack.url = @url
		try
			fs.mkdirSync @path
		fs.writeFileSync path.join(@path, 'pack.json'), 
			JSON.stringify(@_pack)
	@saveProfile = ->
		if not @forge
			return "no Forge"
		profile = 
			gameDir:@path
			javaArgs:@args
			lastVersionId:@forge
			name:@_pack.name
		helpers.saveProfile @_pack.name, profile
	@update = ->
		try
			fs.mkdirSync path.join @path, 'mods'
		for mod in @mods
			download = @url+'/'+ mod.file
			console.log download
			fs.writeFileSync path.join(@path,'mods',mod.file), request('get',download).body
		return 'done'
	return this
