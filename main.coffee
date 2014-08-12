exec = require('child_process').exec
_ = require 'underscore'

options =
	cwd: './'

gitExec = (cmd, timeout = 10000, callback) ->
	if typeof timeout == 'function'
		callback = timeout
		timeout = 10000

	result = ''

	try
		git = exec "git #{cmd}",
			cwd: options.cwd
		git.stdout.on 'data', (data) ->
			result += data.trim()
		git.stdout.on 'error', (data) ->
			result += data.trim()
		git.stderr.on 'data', (data) ->
			result += data.trim()
		git.stderr.on 'error', (data) ->
			result += data.trim()
		git.stdout.on 'close', ->
			callback? result
	catch error
		console.log error
		callback? null

module.exports =
	setOptions: (opt) ->
		_.extend options, opt

	getHash: (fileName, callback) ->
		gitExec "log -n 1 --pretty=\"%H\" -- #{fileName}", callback

	diffMaster: (fileName, timeout, callback) ->
		gitExec "diff master -- #{fileName}", timeout, callback

	checkout: (branchName, timeout, callback) ->
		gitExec "checkout #{branchName}", timeout, callback

	getBranchName: (callback) ->
		gitExec "branch", (result) ->
			result.split("\n").forEach (item) ->
				callback? item.replace /\*\s/g, '' if item.indexOf('*') == 0

	createBranch: (branchName, callback) ->
		gitExec "checkout -b #{branchName}", callback

	add: (callback) ->
		gitExec "add -A", callback

	commit: (message, callback) ->
		gitExec "commit -am '#{message}'", callback

	pull: (callback) ->
		gitExec "pull origin", callback

	merge: (branchName, options, callback) ->
		if typeof(options) == 'function'
			callback = options
			options = ''
		gitExec "merge #{branchName} #{options}", callback

	push: (callback) ->
		gitExec "push origin", callback

	fetch: (callback) ->
		gitExec "fetch", callback

	getConflictList: (callback) ->
		gitExec "diff --name-only --diff-filter=U", (result) ->
			callback? result.split("\n")

	getLastChanges: (callback) ->
		gitExec 'log -n 2 --pretty="%H"', (hash) ->
			lastOtherHash = hash.split('\n')[1]
			unless lastOtherHash
				lastOtherHash = hash.slice(hash.length / 2)
			gitExec "difftool #{lastOtherHash} --name-status", callback