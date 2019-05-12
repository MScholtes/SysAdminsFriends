<#
.Synopsis
Splits a file to smaller files with choosable size.
.Description
Splits a file to smaller files with choosable size.
The source file remains unchanged.
The resulting files have the name of the source file with an appended forthcounting number.
.Parameter Path
Path of the source file
.Parameter NewSize
Size of the splitted parts (default is 100MB)
.Inputs
None
.Outputs
None
.Example
Split-File "BigFile.dat" 10000000

Divides the file BigFile.dat into parts of 10000000 byte size
.Notes
Author: Markus Scholtes
Version: 1.0
Date: 2017-09-04
#>
function Split-File([STRING] $Path, [int] $Newsize = 100MB)
{
	"Splitting file $Path to parts of $Newsize byte size"
	$FILEPATH = [IO.Path]::GetDirectoryName($Path)
	if ($FILEPATH -ne "") { $FILEPATH = $FILEPATH + "\" }
	$FILENAME = [IO.Path]::GetFileNameWithoutExtension($Path)
	$EXTENSION  = [IO.Path]::GetExtension($Path)
	$OBJREADER = New-Object System.IO.BinaryReader([System.IO.File]::Open($Path, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read))
	[Byte[]]$BUFFER = New-Object Byte[] $Newsize
	[int]$BYTESREAD = 0

	$NUMFILE = 1
	while (($BYTESREAD = $OBJREADER.Read($BUFFER, 0, $BUFFER.Length)) -gt 0)
	{
		"Reading $BYTESREAD bytes of $Path"
		$NEWNAME = "{0}{1}{2,2:00}{3}" -f ($FILEPATH, $FILENAME, $NUMFILE, $EXTENSION)
		$OBJWRITER = New-Object System.IO.BinaryWriter([System.IO.File]::Create($NEWNAME))
		"Writing file $NEWNAME"
		$OBJWRITER.Write($BUFFER, 0, $BYTESREAD)
		$OBJWRITER.Close()
	  ++$NUMFILE
	}
	$OBJREADER.Close()
}


<#
.Synopsis
Joins files whose names or filesystem objects are handed in the pipeline to one target file
.Description
Joins files whose names or filesystem objects are handed in the pipeline to one target file.
If the target file exists it will be overwritten. The source files remain unchanged.
.Parameter Path
Path to the source file
.Inputs
Array of strings or filesystem objects
.Outputs
None
.Example
dir *.pdf | Join-File All.pdf

Joins all PDF files to target file All.pdf
.Example
"E.pdf", "C.pdf", "G.pdf", "V.pdf", "P.pdf"| Join-File .\Result.dat

Joins the listed PDF files to target file Result.dat
.Notes
Author: Markus Scholtes
Version: 1.0
Date: 2017-09-04
#>
function Join-File([STRING] $Path)
{
	if ((!$Path) -or ($Path -eq ""))
	{	Write-Error "Target filename missing."
		return
	}

	$OBJARRAY = @($INPUT)
	if ($OBJARRAY.Count -eq 0)
	{	Write-Error "Source filename list missing."
		return
	}

	$OBJWRITER = New-Object System.IO.BinaryWriter([System.IO.File]::Create($Path))

	$OBJARRAY | ForEach-Object {
		"Appending $_ to $Path."
		$OBJREADER = New-Object System.IO.BinaryReader([System.IO.File]::Open($_, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read))

		$OBJWRITER.BaseStream.Position = $OBJWRITER.BaseStream.Length
		$OBJREADER.BaseStream.CopyTo($OBJWRITER.BaseStream)
		$OBJWRITER.BaseStream.Flush()

  	$OBJREADER.Close()
	}

	$OBJWRITER.Close()
}
