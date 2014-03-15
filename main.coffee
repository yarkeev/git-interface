exec = require('child_process').exec

module.exports = (fileName, callback) ->
    hash = null
    git = exec "git log -n 1 --pretty=\"%H\" -- #{fileName}"
    git.stdout.on 'data', (data) ->
        hash = data.trim()
        callback? hash
    git.stdout.on 'close', ->
        unless hash
            callback? null