# git-interface

![](https://raw.githubusercontent.com/yarkeev/git-interface/gh-pages/docs/pics/logo.png)

Interface to work with a git repository in node.js

## Installation

```bash
$ npm install git-interface --save
```

## Usage

```js
const { Git } = require('git-interface');

const git = new Git({
	dir: '/path/to/repository' //default path is current directory
});
...
```

## Documentation

### .setDir(dir: string)

Set path to repository

```js
git.setDir('/path/to/repository');
```

### .init()

Initializes new git repo

```js
git.init();
```

### .clone(repository: string, dest: string)

clone repository `repository` to path `dest`

```js
await git.clone('git@github.com:yarkeev/git-interface.git', 'git-interface');
```

### .checkout(branchName: string)

Checkout to branch `branchName`

```js
await git.checkout('master');
```

### .updateSubmodules(init: boolean = true, recursive: boolean = true)

Updates the git submodules:

```js
await git.updateSubmodules();
```

### .commit(message: string)

Commit changes with `message`

```js
await git.commit('message for annotate');
```

### .pull()

Pull current branch from origin

```js
await git.pull();
```

Pull branch `feature1` from remote `test` with rebase (`-r`) option

```js
await git.pull('test', { branch: 'feature1', rebase: true });
```

### .push()

Push current branch to origin

```js
await git.push();
```

### .add()

Add all new files to VCS

```js
await git.add();
```

### .merge(branchName: string, mergeOptions?: string)

Merge branch `branchName` to the current branch with flags `mergeOptions`

```js
await git.merge('branch-name');
```
```js
await git.merge('branch-name', '--squash');
```

### .fetch()

Download objects and refs from origin

```js
await git.fetch();
```

### .addRemote(name: string, url: string)

Add a remote

```js
await git.addRemote('origin', 'git@github.com:yarkeev/git-interface.git');
```

### .setRemote(name: string, url: string)

Set the url of a remote

```js
await git.setRemote('origin', 'git@github.com:yarkeev/git-interface.git');
```

### .getRemotes()

Gets list of remote names

```js
await git.getRemotes();
```

### .getRemoteUrl(name: string)

Gets a url of a remote by name

```js
await git.getRemoteUrl('origin');
```

### .reset()

Reset uncommitted changes

```js
await git.reset();
```

### .getHash(fileName: string)

Getting hash commit was last modified

```js
const hash = await git.getHash('path/to/file');
```

### .diffMaster(fileName: string)

File comparison `fileName` with master

```js
const diff = await git.diffMaster('path/to/file');
```

### .getBranchName()

Get name of the current brunch

```js
const branch = await git.getBranchName();
```

### .createBranch(branchName: string)

Create branch with name `branchName`

```js
await git.createBranch('new-branch');
```

### .deleteBranch(branchName: string)

Delete branch with name `branchName`

```js
await git.deleteBranch('existing-branch');
```

### .getDiffByRevisionFileList(revision: string)

Getting a list of files that have changed relative revision

```js
const diffFileList = await git.getDiffByRevisionFileList('5e19a1d3c386a2607885627f3774d3d7746b60de');
```

### .getConflictList()

Get list of conflicted files after merge

```js
const conflictList = await git.getConflictList();
```

### .getUncommittedList()

Get list of uncommitted files

```js
const uncomittedList = await git.getUncommittedList();
```

### .getLastChanges()

Getting a list of files that have changed in the last commit

```js
const lastChanges = await git.getLastChanges();
```

### .removeLocalBranch(branchName: string)

Remove local branch `branchName`

```js
await git.removeLocalBranch('branch-name');
```

### .removeRemoteBranch(branchName: string)

Remove branch `branchName` from origin

```js
await git.removeRemoteBranch('branch-name');
```

### .getLocalBranchList()

Get list of local branches

```js
const branches = await git.getLocalBranchList();
```

### .getRemoteBranchList()

Get list of remote branches

```js
const branches = await git.getRemoteBranchList();
```

### .getTimeOfLastCommit(branchName: string)

Get time of last commit in branch

```js
const timeOfLastCommit = await git.getTimeOfLastCommit('branch-name');
```

### .getHashOfLastCommit(branchName: string)

Get hash of last commit in branch

```js
const hashOfLastCommit = await git.getHashOfLastCommit('branch-name');
```
