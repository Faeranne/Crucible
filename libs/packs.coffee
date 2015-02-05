fs = require 'fs'
path = require 'path'
helpers = require './helpers'
request = require 'request'

module.exports = self = 
	getPackProfile: (url,callback) ->
		request url, (err,res,body) ->	
			if err
				throw err
			callback null,JSON.parse(body)
