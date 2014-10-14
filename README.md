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

//create new branch
gitInterface.createBranch('new-branch', function () {
	console.log('done');
});

//add files to VCS
gitInterface.add(function () {
	console.log('done');
});

//commit changes
gitInterface.commit('message for annotate', function () {
	console.log('done');
});

//pull
gitInterface.pull(function () {
	console.log('done');
});

//merge with other branch
gitInterface.merge('branch-name', '--squash', function () {
	console.log('done');
});

//push
gitInterface.push(function () {
	console.log('done');
});

//fetch
gitInterface.fetch(function () {
	console.log('done');
});

//get conflict list after merge or pull
gitInterface.getConflictList(function (conflicts) {
	console.log(conflicts);
});

//get list of uncommitted files
gitInterface.getUncommittedList(function (conflicts) {
	console.log(conflicts);
});

//get changed files in last commit
gitInterface.getLastChanges(function (changes) {
	console.log(changes);
});
```