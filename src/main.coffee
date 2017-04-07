exec = require('child_process').exec
_ = require 'lodash'

options =
	cwd: './'

gitExec = (cmd, timeout = 10000, callback, callbackIteration) ->
	if typeof timeout == 'function'
		callbackIteration = callback
		callback = timeout
		timeout = 10000

	result = ''

	try
		git = exec "git #{cmd}",
			cwd: options.cwd
		git.stdout.on 'data', (data) ->
			data = data.toString() || ''
			data = data.trim()
			result += data
			callbackIteration? data
		git.stdout.on 'error', (data) ->
			data = data.toString() || ''
			data = data.trim()
			result += data
			callbackIteration? data
		git.stderr.on 'data', (data) ->
			data = data.toString() || ''
			data = data.trim()
			result += data
			callbackIteration? data
		git.stderr.on 'error', (data) ->
			data = data.toString() || ''
			data = data.trim()
			result += data
			callbackIteration? data
		git.stdout.on 'close', ->
			callback? result
	catch error
		console.log error
		callback? null

module.exports =
	setOptions: (opt) ->
		_.merge options, opt

	clone: (repo, dest, callback) ->
		gitExec "clone #{repo} #{dest}", callback

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
		@getBranchName (branch) ->
			gitExec "pull origin #{branch}", callback

	merge: (branchName, mergeOptions, callback) ->
		if typeof(mergeOptions) == 'function'
			callback = mergeOptions
			mergeOptions = ''
		gitExec "merge #{branchName} #{mergeOptions}", callback

	push: (callback, callbackIteration) ->
		@getBranchName (branch) ->
			gitExec "push origin #{branch}", callback, callbackIteration

	fetch: (callback) ->
		gitExec "fetch", callback

	getConflictList: (callback) ->
		gitExec "diff --name-only --diff-filter=U", (result) ->
			callback? result.split("\n")

	getUncommittedList: (callback) ->
		gitExec "diff --name-only", (result) ->
			callback? result.split("\n")

	getLastChanges: (callback) ->
		gitExec 'log -n 2 --pretty="%H"', (hash) ->
			lastOtherHash = hash.split('\n')[1]
			unless lastOtherHash
				lastOtherHash = hash.slice(hash.length / 2)
			gitExec "difftool #{lastOtherHash} --name-status", callback

	getDiff: (revision, callback) ->
		gitExec "diff #{revision} --name-only", (result) ->
			callback? result.split("\n")

	reset: (callback) ->
		gitExec "reset --hard HEAD", callback

	removeLocalBranch: (branchName, callback) ->
		gitExec "branch -D #{branchName}", callback

	removeRemoteBranch: (branchName, callback) ->
		gitExec "push origin --delete #{branchName}", callback

	getLocalBranchList: (callback) ->
		gitExec "branch", (result) ->
			branches = result.split("\n").map (item) ->
				item.trim().replace(/\s+\*\s+/)
			callback? branches

	getRemoteBranchList: (callback) ->
		gitExec "branch -r", (result) ->
			branches = result.split("\n")
				.filter (item) ->
					item.indexOf("origin/HEAD") == -1
				.map (item) ->
					item.trim()
						.replace(/\s+\*\s+/)
						.replace("origin/", "")
			callback? branches

	getTimeOfLastCommit: (branchName, callback) ->
		gitExec "show --format='%ci %cr' #{branchName}", (result) ->
			dateTimeStr = result.split('\n')[0].split(' ')
			date = new Date("#{dateTimeStr[0]} #{dateTimeStr[1]} #{dateTimeStr[2]}")

			callback date.getTime()
