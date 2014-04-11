Some interfaces for work with git repository

## Example:
```
gitInterface = require('git-interface');

//get hash of last commit
gitInterface.getHash('index.html', function (hash) {
	console.log(hash);
});

//get diff with master
gitInterface.diffMaster('index.html', function (diff) {
	console.log(diff);
});
```