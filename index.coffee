$ = require './libs/jquery.js'
helpers = require './libs/helpers'
Pack = require './libs/pack'
$ ->
	packs = helpers.getAllPacks()
	for pack in packs
		option = $ '<option>'
			.val pack
			.text pack
		$ '#packs'
			.append option
	$ '#updatePack'
		.click ->
			pack = new Pack $('#packs').val()
			$ '#response'
				.text pack.update()
	$ '#addPack'
		.click ->
			pack = new Pack $('#url').val()
			console.log pack
			pack.save()
			pack.saveProfile()
			pack.update()
			$ '#response'
				.text 'Done'
