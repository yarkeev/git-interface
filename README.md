Get hash last commit of file for git repository

## Example:
```
gitInterface = require('git-interface');

//get hash of last commit
gitInterface.getHash('index.html', function (hash) {
	console.log(hash);
});

//get diff with master
gitInterface.getHash('index.html', function (diff) {
	console.log(diff);
});
```