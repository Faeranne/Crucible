$ = require './libs/jquery.js'
helpers = require './libs/helpers'
packs = require './libs/packs'
$ ->
	packs = helpers.getAllPacks()
	for pack in packs
		option = $('<option>').val(pack).text(pack)
		$('#packs').append(option)
	$('#selectPack').click ->
		pack = $('#packs').val()
		console.log(pack)
