# Check for integrity of the source files in subdirectory "functions"
# Markus Scholtes, 2019

if (!(Test-Path "$PSScriptRoot/functions.cat"))
{ 
	Write-Error "Cannot load module because files are missing"
}
if (Get-Command Test-FileCatalog -EA SilentlyContinue) 
{ # available only from Powershell 5.1 on
	if ((Test-FileCatalog -Path "$PSScriptRoot/functions" -Detailed -CatalogFilePath "$PSScriptRoot/functions.cat").Status -ne "Valid")
	{ # cancel because files have been changed
		Write-Error "Cannot load module because files have been modified"
	}
}
