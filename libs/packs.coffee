fs = require 'fs'
path = require 'path'
helpers = require './helpers'
request = require 'sync-request'

module.exports = self = 
	remotePack: (url) ->
		pack = helpers.fetchJson(url)
		this.mods = pack.mods
		this.updateUrl = pack.url
		this.path = path.join helpers.getDirectory(), 'modpacks', pack.name
		return this

	localPack: (name) ->
		this.path = path.join helpers.getDirectory(), 'modpacks', name
		if fs.existsSync path.join dir, 'pack.json'
			pack = JSON.parse fs.readFileSync path.join this.path, 'pack.json'
			this.installed = true
			this.mods = pack.mods
		else
			this.installed = false
			this.mods = []
		return this
	createPack: (name) ->
		return this
		
