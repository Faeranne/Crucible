os = require 'os'
fs = require 'fs'
path = require 'path'
module.exports = self = 
	getDirectory: ->
		if os.platform() == "linux"
			return path.join process.env.HOME, "/.minecraft"
		if os.platform() is "win32" or "win64"
			return path.join process.env.APPDATA, "/.minecraft"
		if os.platform() is "darwin"
			return path.join process.env.HOME, "/Library/Application Support/minecraft"
	getLauncherProfiles: ->
		profilePath = self.getDirectory()
		profilePath = path.join profilePath, 'launcher_profiles.json'
		JSON.parse(fs.readFileSync(profilePath))
	saveLauncherProfiles: (file) ->
		data = JSON.stringify(file)
		profilePath = self.getDirectory()
		profilePath = path.join profilePath, 'launcher_profiles.json'
		fs.writeFileSync(profilePath,data)
	loadProfile: (name)->
		profiles = self.getLauncherProfiles().profiles
		profiles[name]
	saveProfile: (name, profile) ->
		file = self.getLauncherProfiles()
		file.profiles[name]=profile
		self.saveLauncherProfiles(file)	
	listProfiles: ->
		profiles = self.getLauncherProfiles().profiles
		Object.keys(profiles)
