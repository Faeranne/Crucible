Pack = require './libs/pack'

opts = require "nomnom"
	.parse();

name = opts[0]

pack = new Pack(name)

pack.save()
