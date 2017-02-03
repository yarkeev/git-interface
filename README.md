# git-interface

![](http://s7.postimg.org/tz15stjaj/git_interface.png)

Interface to work with a git repository in node.js

## Installation

```bash
$ npm install git-interface
```

## Usage

```js
git = require('git-interface');

//get hash of last commit
git.getHash('path/to/file', function (hash) {
	console.log(hash);
});
...
```

## Documentation

### .setOptions(options)

Set repository options

```js
//default path is current directory
//but you can set the path:
git.setOptions({
	cwd: '/path/to/repository'
});
```

### .clone(repo, dest, [callback])

clone repository `repo` to path `dest`

```js
git.clone('git@github.com:yarkeev/git-interface.git', 'git-interface', function () {
	console.log('clone done');
});
```

### .commit(message, [callback])

Commit changes with `message`

```js
git.commit('message for annotate', function () {
	console.log('commit done');
});
```

### .pull([callback])

Pull current branch from origin

```js
git.pull(function () {
	console.log('pull done');
});
```

### .push([callback])

Push current branch to origin

```js
git.push(function () {
	console.log('push done');
});
```

### .createBranch(branchName, [callback])

Create branch with name `branchName`

```js
git.createBranch('new-branch', function () {
	console.log('new branch created');
});
```

### .checkout(branchName, [callback])

Checkout to branch `branchName`

```js
git.checkout('master', function () {
	console.log('now branch is master');
});
```

### .getHash(fileName, callback)

Getting hash commit was last modified

```js
git.getHash('path/to/file', function (hash) {
	console.log(hash);
});
```

### .diffMaster(fileName, callback)

File comparison `fileName` with master

```js
git.diffMaster('path/to/file', function (diff) {
	console.log('diff with master:', diff);
});
```

### .getBranchName(callback)

Get name of the current brunch

```js
git.getBranchName(function (branchName) {
	console.log('current branch: ' + branchName);
});
```

### .add([callback])

Add all new files to VCS

```js
git.add(function () {
	console.log('done');
});
```

### .merge(branchName, [mergeOptions], [callback])

Merge branch `branchName` to the current branch with flags `mergeOptions`

```js
git.merge('branch-name', function () {
	console.log('branch-name merged');
});
```
```js
git.merge('branch-name', '--squash', function () {
	console.log('branch-name merged');
});
```

### .fetch([callback])

Download objects and refs from origin

```js
git.fetch(function () {
	console.log('fetch done');
});
```

### .getConflictList(callback)

Get list of conflicted files after merge

```js
git.getConflictList(function (conflicts) {
	console.log('conflicted files: ', conflicts);
});
```

### .getUncommittedList(callback)

Get list of uncommitted files

```js
git.getUncommittedList(function (uncommitted) {
	console.log('uncommitted files: ', uncommitted);
});
```

### .getLastChanges(callback)

Getting a list of files that have changed in the last commit

```js
git.getLastChanges(function (changes) {
	console.log('last changes: ', changes);
});
```

### .getDiff(revision, callback)

Getting a list of files that have changed relative revision

```js
git.getDiff('52986deb5d9c2e60ece526a785b125079b86980b', function (changes) {
	console.log('changes: ', changes);
});
```

### .reset([callback])

Reset uncommitted changes

```js
git.reset(function () {
	console.log('reset done');
});
```

### .removeLocalBranch(branchName, [callback])

Remove local branch `branchName`

```js
git.removeLocalBranch('branch-name', function () {
	console.log('local branch-name removed');
});
```

### .removeRemoteBranch(branchName, [callback])

Remove branch `branchName` from origin

```js
git.removeRemoteBranch('branch-name', function () {
	console.log('branch-name removed from origin');
});
```

### .getLocalBranchList([callback])

Get list of local branches

```js
git.getLocalBranchList(function (branches) {
	console.log('local branches: ', branches);
});
```


### .getRemoteBranchList([callback])

Get list of remote branches

```js
git.getRemoteBranchList(function (branches) {
	console.log('remote branches: ', branches);
});
```
