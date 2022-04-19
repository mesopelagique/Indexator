//%attributes = {}
var $baseFolder : 4D:C1709.Folder
$baseFolder:=Folder:C1567("/Users/emarchand/perforce/4edimension/4DComponents/Internal User Components/4D Mobile App/")

var $indexator : Object
$indexator:=cs:C1710.Indexator.new($baseFolder)
$indexator.indexIntoFolders()

$indexator.deindexIntoRoot()
