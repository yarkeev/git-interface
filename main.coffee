exec = require('child_process').exec

gitExec = (cmd, callback) ->
	result = null
	git = exec cmd
	git.stdout.on 'data', (data) ->
		result = data.trim()
		callback? result
	git.stdout.on 'close', ->
		unless result
			callback? null

module.exports = 
	getHash: (fileName, callback) ->
		gitExec "git log -n 1 --pretty=\"%H\" -- #{fileName}", callback

	diffMaster: (fileName, callback) ->
		gitExec "git diff master -- #{fileName}", callback