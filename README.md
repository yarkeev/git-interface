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

//checkout
gitInterface.checkout('master', 10000, function () {
	console.log('Your branch is master');
});

//get current branch name
gitInterface.getBranchName(function (branchName) {
	console.log('Current branch: ' + branchName);
});
```