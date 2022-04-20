# Indexator

Move 4dm files according to `folders.json` (temporary because 4D will could not access them after that and will remove all info from folders.json)

## Usage

### Indexation into file system folders

To move all `.4dm` files from `Project/Sources/Classes` and `Project/Sources/Methods` to some of their folders according to group defined in 4D Explorer (ie. `folders.json`)

```4d
$indexator:=cs.Indexator.new(Folder("/path/to/your/base/root/folder"))
$indexator.indexIntoFolders()
```

> ⚠️ if you reopen your base with 4D, methods and classes will be no more visible and will be deleted from `folders.json`. So make a backup (for instance git)

### Deindexation

To reset previous indexation, this code will found any 4dm files into sub folders and will restore it into `Project/Sources/Classes` or `Project/Sources/Methods`.

```4d
$indexator:=cs.Indexator.new(Folder("/path/to/your/base/root/folder"))
$indexator.deindexIntoRoot()
```

## TODO

- [x] indexation
- [x] deindexation
- [ ] recreate folders.json from files indexed
