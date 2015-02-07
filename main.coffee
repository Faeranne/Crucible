$ = require './libs/jquery.js'
helpers = require './libs/helpers'
Pack = require './libs/pack'
currentPack = null
currentMod = null
$ ->
	packs = helpers.getAllPacks()
	for pack in packs
		option = $ '<option>'
			.val pack
			.text pack
		$ '#packs'
			.append option
	$ '#selectPack'
		.click ->
			currentPack = new Pack $('#packs').val()
			$ '#pack' 
				.removeClass() $ '#mod'
				.removeClass()
				.addClass 'hidden'
			$ '#mods'
				.find 'option'
				.remove()
			for mod, index in currentPack.mods
				option = $ '<option>'
					.val index
					.text mod.name
				$ '#mods' 
					.append option
	$ '#updatePack'
		.click ->
			currentPack.save()
			$ '#packs'
				.val currentPack.name
				.text currentPack.name
	$ '#editMod'
		.click ->
			$ '#mod'
				.removeClass()
			index = $ '#mods'
				.val()
			currentMod = index
			$ '#modName'
				.val currentPack.mods[index].name
	$ '#updateMod'
		.click ->
			currentPack.mods[currentMod].name = $ '#modName'
				.val()
			$('#mods :selected')
				.text currentPack.mods[currentMod].name
