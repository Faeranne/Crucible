$ = require './libs/jquery.js'
helpers = require './libs/helpers'
Pack = require './libs/pack'
fs = require 'fs'
path = require 'path'
log = (text) ->
	last = $ '#response'
		.html()
	$ '#response'
		.html last + '<br>' + text
		$('#response')[0].scrollTop = $('#response')[0].scrollHeight;

progress = (val) ->
	bar = $ '#progress'
	last = bar.val()
	if val
		bar.val val + last
	else
		bar.val last + 1

$ ->
	try
		fs.mkdirSync(path.join(helpers.getDirectory(), 'modpacks'))
	packs = helpers.getAllPacks()
	for pack in packs
		option = $ '<option>'
			.val pack
			.text pack
		$ '#packs'
			.append option
	$ '#updatePack'
		.click ->
			window.pack = new Pack $('#packs').val()
			window.pack.ready ()->
				$ '#progress'
					.attr 'max',  window.pack.mods.length
					.removeClass()
				window.pack.update(log,progress)
					.then (res) ->
						log 'Done'
	$ '#addPack'
		.click ->
			pack = new Pack $('#url').val()
			pack.ready ->
				pack.save()
				pack.saveProfile()
				$ '#progress'
					.attr 'max',  pack.mods.length
					.removeClass()
				pack.update(log, progress)
					.then (res) ->
						$ '#response'
							.text 'done'
		packs = helpers.getAllPacks()
		for pack in packs
			option = $ '<option>'
				.val pack
				.text pack
			$ '#packs'
				.append option
