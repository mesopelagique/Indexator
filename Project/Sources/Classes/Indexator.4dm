
Class constructor($baseFolder : 4D:C1709.Folder)
	This:C1470.baseFolder:=$baseFolder
	ASSERT:C1129(This:C1470.baseFolder.exists)
	
	// Move all classes and methods to subfolder in file system according to folders.json indexes (ie. group defined for 4d explorer)
Function indexIntoFolders()
	
	var $indexes : Object
	$indexes:=JSON Parse:C1218(This:C1470.baseFolder.file("Project/Sources/folders.json").getText())
	
	var $type : Text
	For each ($type; New collection:C1472("Classes"; "Methods"))
		var $classFolder : 4D:C1709.Folder
		$classFolder:=This:C1470.baseFolder.folder("Project/Sources").folder($type)
		
		var $indexKey : Text
		For each ($indexKey; $indexes)
			
			If (Value type:C1509($indexes[$indexKey][Lowercase:C14($type)])=Is collection:K8:32)
				var $code : Text
				For each ($code; $indexes[$indexKey][Lowercase:C14($type)])
					
					var $source : 4D:C1709.File
					$source:=$classFolder.file($code+".4dm")
					If ($source.exists)
						
						var $dstFolder : 4D:C1709.Folder
						$dstFolder:=This:C1470._getFolder($classFolder; $indexKey; $indexes)
						If (Not:C34($dstFolder.exists))
							$dstFolder.create()
						End if 
						$source.moveTo($dstFolder)
					End if 
				End for each 
			End if 
		End for each 
	End for each 
	
	
	/// According to "group" find folder according to $ name
Function _getFolder($root : 4D:C1709.Folder; $name : Text; $indexes : Object)->$resultFolder : 4D:C1709.Folder
	var $key : Text
	For each ($key; $indexes)
		If (Value type:C1509($indexes[$key].groups)=Is collection:K8:32)
			If ($indexes[$key].groups.indexOf($name)>-1)
				$resultFolder:=This:C1470._getFolder($root; $key; $indexes).folder($name)
				return 
			End if 
		End if 
	End for each 
	$resultFolder:=$root.folder($name)
	
	// Found all methods and class files in subfolder and move it to root (so accessible by 4D)
Function deindexIntoRoot()
	var $type : Text
	For each ($type; New collection:C1472("Classes"; "Methods"))
		var $classFolder : 4D:C1709.Folder
		$classFolder:=This:C1470.baseFolder.folder("Project/Sources").folder($type)
		This:C1470._doDeindexIntoRoot($classFolder; $classFolder)
	End for each 
	
Function _doDeindexIntoRoot($folder : 4D:C1709.Folder; $rootFolder : 4D:C1709.Folder)
	
	var $subfolder : 4D:C1709.Folder
	For each ($subfolder; $folder.folders())
		This:C1470._doDeindexIntoRoot($subfolder; $rootFolder)
	End for each 
	
	var $file : 4D:C1709.File
	For each ($file; $folder.files())
		If ($file.extension=".4dm")
			$file.moveTo($rootFolder)
		End if 
	End for each 
	
	If (($folder.folders().length+$folder.files().length)=0)  // empty
		$folder.delete()
	End if 