Get hash last commit of file for git repository

## Example:
```
getHash = require('githash');
getHash('index.html', function (hash) {
	console.log(hash)
});
```