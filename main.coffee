exec = require('child_process').exec

gitExec = (cmd, timeout = 2000, callback) ->
	if typeof timeout == 'function'
		callback = timeout
		timeout = 2000

	result = ''

	timer = setTimeout ->
		console.log('timeout call');
		unless result
			callback null
	, timeout

	try
		git = exec cmd
		git.stdout.on 'data', (data) ->
			result += data.trim()
		git.stdout.on 'close', ->
			clearTimeout timer
			callback? result
	catch error
		console.log error
		clearTimeout timer
		callback? null

module.exports =
	getHash: (fileName, callback) ->
		gitExec "git log -n 1 --pretty=\"%H\" -- #{fileName}", callback

	diffMaster: (fileName, timeout, callback) ->
		gitExec "git diff master -- #{fileName}", timeout, callback