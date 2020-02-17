<#
.SYNOPSIS
The module SysAdminsFriends provides some tools that are useful for system administrators.
.NOTES
Version: 1.1.1
Date: 2020-02-15
Author: Markus Scholtes
#>

# check for integrity of the source files
if (!(Test-Path "$PSScriptRoot/functions.cat"))
{
	Write-Error "Cannot load module because files are missing"
	exit
}
if (Get-Command Test-FileCatalog -EA SilentlyContinue)
{ # available only from Powershell 5.1 on
	if ((Test-FileCatalog -Path "$PSScriptRoot/functions" -Detailed -CatalogFilePath "$PSScriptRoot/functions.cat").Status -ne "Valid")
	{ # cancel because files have been changed
		Write-Error "Cannot load module because files have been modified"
		exit
	}
}

# Load modules manually for security reasons
. "$PSScriptRoot/functions/Compress-LogDirectory.ps1"
. "$PSScriptRoot/functions/ConvertTo-Batch.ps1"
. "$PSScriptRoot/functions/Export-FirewallRules.ps1"
. "$PSScriptRoot/functions/Get-RebootTime.ps1"
. "$PSScriptRoot/functions/Get-Sessions.ps1"
. "$PSScriptRoot/functions/Import-FirewallRules.ps1"
. "$PSScriptRoot/functions/Invoke-AdminExplorer.ps1"
. "$PSScriptRoot/functions/Remove-FirewallRules.ps1"
. "$PSScriptRoot/functions/Replace-InFile.ps1"
. "$PSScriptRoot/functions/Split-File.ps1"
. "$PSScriptRoot/functions/Start-WebServer.ps1"

# Export functions
Export-ModuleMember -Function @(
	'Compress-LogDirectory',
	'ConvertTo-Batch',
	'Export-FirewallRules',
	'Import-FirewallRules',
	'Remove-FirewallRules',
	'Get-RebootTime',
	'Get-Sessions',
	'Replace-InFile',
	'Split-File',
	'Join-File',
	'Invoke-AdminExplorer',
	'Test-Admin',
	'Select-FileDialog',
	'Start-Webserver'
)
