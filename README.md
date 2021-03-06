# SysAdminsFriends
SysAdminsFriends is a Powershell module that provides some tools that are useful for system administrators.

* Export-FirewallRules, Import-FirewallRules, Remove-FirewallRules for backup and restore of firewall rules with CSV or JSON files
* Get-Sessions retrieves information on logon sessions (incl. RDP sessions) on a system
* Start-Webserver is a Powershell web server without IIS
* ConvertTo-Batch converts short Powershell scripts to cmd batches (that ignore the execution policy)
* Split-File and Join-File split and join binary files fast
* Export-FileSegment and Import-FileSegment extract and insert binary data
* Replace-InFile replaces text in files with preserving the encoding
* Compress-LogDirectory archives log files in a given path or all iis log directories
* Invoke-AdminExplorer starts an administrative Explorer window
* Get-RebootTime gets the last reboot time(s) fast

By Markus Scholtes, 2020
## Installation

```powershell
PS C:\> Install-Module SysAdminsFriends
```
(on Powershell V4 you may have to install PowershellGet before) or download from here: https://www.powershellgallery.com/packages/SysAdminsFriends/.

## Functions
### Export-FirewallRules, Import-FirewallRules and Remove-FirewallRules
Functions for exporting, importing and removing of firewall rules with CSV or JSON files. For details see the script version web page: [Powershell scripts to export and import firewall rules](https://gallery.technet.microsoft.com/Powershell-to-export-and-23287694).
### Start-Webserver
Powershell function that starts a webserver (without IIS). Powershell command execution, script execution, upload, download and other functions are implemented. For details see the script version web page: [Powershell Webserver](https://gallery.technet.microsoft.com/Powershell-Webserver-74dcf466).
### Split-File and Join-File
Two Powershell functions to split and join binary files fast. The functions are using .Net BinaryWriter methods. The quick .CopyTo() method is used to join files. For details see the script version web page: [Powershell functions to split and join binary files fast](https://gallery.technet.microsoft.com/Powershell-functions-to-cb6bb05a).
### Export-FileSegment and Import-FileSegment
Two Powershell functions to extract and insert binary data from and to files. The functions are using .Net BinaryWriter and BinaryReader methods. For details see the script version web page: [Export-Filesegment](https://github.com/MScholtes/TechNet-Gallery/tree/master/Export-Filesegment).
### Get-Sessions
Powershell function to get information about interactive logins (including RDP sessions) including logon, connect, disconnect and logoff times. Session ID and remote host for RDP can be requested per parameter. For details see the script version web page: [Get-Sessions: Powershell script for information on interactive logins (incl RDP)](https://gallery.technet.microsoft.com/Get-Sessions-Powershell-1dcf779d).
### ConvertTo-Batch
Generate cmd.exe batch files from short Powershell scripts. The Powershell scripts are Base64 encoded and handed to a new Powershell instance in the batch file. There is a limitation of 2975 characters for the script to convert. For details see the script version web page: [Convert short Powershell scripts to batches](https://gallery.technet.microsoft.com/scriptcenter/Convert-short-Powershell-e9b4e81d).
### Replace-InFile
Function to replace text in files programmatically without getting a mess with the text encodings. The function detects the encoding of each processed file and writes it back with the same encoding. For details see the script version web page: [Replace-InFile.ps1: Replace text in files while preserving the encoding](https://gallery.technet.microsoft.com/Replace-InFileps1-Replace-1e0be31a).
### Compress-LogDirectory
This function compresses log files older than the current month to Zip archives in a given directory or in the IIS log directories and deletes the archived files. For details see the script version web page: [Powershell script to compress log files (and IIS logs)](https://gallery.technet.microsoft.com/Powershell-script-to-47f83931).
### Invoke-AdminExplorer
Starts an administrative "File Open" dialog as a replacement for an elevated Windows Explorer that does not exists since Windows Vista. For details see the script version web page: ["File Open" Dialog As Replacement for An Adminstrative Windows Explorer](https://gallery.technet.microsoft.com/scriptcenter/File-Open-Dialog-As-51b7854b).
### Test-Admin
Checks if the current Powershell runs in administrative mode (means is elevated if UAC is enabled). For details see the script version web page: ["File Open" Dialog As Replacement for An Adminstrative Windows Explorer](https://gallery.technet.microsoft.com/scriptcenter/File-Open-Dialog-As-51b7854b).
### Get-RebootTime
Function to retrieve the latest reboot time(s) of a computer. For details see the script version web page: [Retrieve latest reboot time(s)](https://gallery.technet.microsoft.com/Retrieve-latest-reboot-97ab5270).

## Versions
### 1.1.4, 2020-12-12
New parameter -Policystore for Export-FirewallRules, Import-FirewallRules and Remove-FirewallRules
### 1.1.3, 2020-08-22
Added Export-FileSegment and Import-FileSegment
### 1.1.2, 2020-05-03
Split-File can chunk into parts of size > 2GB now
### 1.1.1, 2020-02-15
Added filtering options to Export-FirewallRules
### 1.1.0, 2019-08-30
Renamed Set-InFile to Replace-InFile

Added directory listing feature to Start-WebServer
### 1.0.0, 2019-05-20
First stable release (hope so)
