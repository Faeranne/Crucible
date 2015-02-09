fs = require 'fs'
path = require 'path'
helpers = require './helpers'
Promise = require 'promise'
readFile = Promise.denodeify fs.readFile
exists = (file) -> 
	return new Promise (resolve, reject) ->
		fs.exists file, (exists) ->
			resolve exists

module.exports = self =	(name) ->
	@_ready = false
	@ready = (fun) ->
		if @_ready
			fun()
		else
			@_readyFun = fun
	@_onReady = ->
		@_ready = true
		console.log('pack ready')
		try
			@_readyFun()
		catch err
			console.error(err)
	if name.match("http://")
		self = @
		helpers.fetchJson name
			.then (pack) ->
				self._pack = pack
				self.setup()
			, (err) ->
				console.error err
	else
		dir = path.join helpers.getDirectory(), 'modpacks', name
		self = @
		exists path.join dir, 'pack.json'
			.then (exists) ->
				if exists
					readFile path.join(dir, 'pack.json')
						.then (pack)->
							pack = JSON.parse pack
							console.log pack
							self._pack = pack
							self.installed = true
							self.setup()
						, (err) ->
							console.log(err)
							
				else
					self.installed = false
					self._pack = {}
					self._pack.mods = helpers.getModList @path
					self._pack.name = name
					self._pack.args = ""
					self._pack.forge = ""
					self._pack.url = ""
					self.setup() 
			, (err) ->
				console.error(err)
	@setup = ->
		@path = path.join helpers.getDirectory(), 'modpacks', @_pack.name
		@args = @_pack.args
		@mods = @_pack.mods
		@forge = @_pack.forge
		@url = @_pack.url
		@_onReady()
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
	@update = (log, progress) ->
		self = @
		return new Promise (resolve, reject) ->
			try
				fs.mkdirSync path.join self.path, 'mods'
			catch err
				console.error err
			downloads = []
			for mod in self.mods
				download = self.url+'/'+ mod.file
				downloads.push helpers.downloadFile(path.join(self.path, 'mods'),download, mod.file, log, progress)
			Promise.all downloads
				.then ->
					resolve 'done'
				, (err) ->
					console.log err
					reject err
	return this
