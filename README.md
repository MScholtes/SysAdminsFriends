# SysAdminsFriends
SysAdminsFriends is a Powershell module that provides some tools that are useful for system administrators.

* Export-FirewallRules, Import-FirewallRules, Remove-FirewallRules for backup and restore of firewall rules with CSV or JSON files
* Get-Sessions retrieves information on logon sessions (incl. RDP sessions) on a system
* Start-Webserver is a Powershell web server without IIS
* ConvertTo-Batch converts short Powershell scripts to cmd batches (that ignore the execution policy)
* Split-File and Join-File split and join binary files fast
* Set-InFile replaces text in files with preserving the encoding
* Compress-LogDirectory archives log files in a given path or all iis log directories
* Get-RebootTime gets the last reboot time(s) fast

By Markus Scholtes, 2019
## Installation

```powershell
PS C:\> Install-Module SysAdminsFriends
```
(on Powershell V4 you may have to install PowershellGet before)

## Functions
### Export-FirewallRules, Import-FirewallRules and Remove-FirewallRules
Functions for exporting, importing and removing of firewall rules with CSV or JSON files. For details see the script version web page: [Powershell scripts to export and import firewall rules](https://gallery.technet.microsoft.com/Powershell-to-export-and-23287694).
### Start-Webserver
Powershell function that starts a webserver (without IIS). Powershell command execution, script execution, upload, download and other functions are implemented. For details see the script version web page: [Powershell Webserver](https://gallery.technet.microsoft.com/Powershell-Webserver-74dcf466).
### Split-File and Join-File
Two Powershell functions to split and join binary files fast. The functions are using .Net BinaryWriter methods. The quick .CopyTo() method is used to join files. For details see the script version web page: [Powershell functions to split and join binary files fast](https://gallery.technet.microsoft.com/Powershell-functions-to-cb6bb05a).
### Get-Sessions
Powershell function to get information about interactive logins (including RDP sessions) including logon, connect, disconnect and logoff times. Session ID and remote host for RDP can be requested per parameter. For details see the script version web page: [Get-Sessions: Powershell script for information on interactive logins (incl RDP)](https://gallery.technet.microsoft.com/Get-Sessions-Powershell-1dcf779d).
### ConvertTo-Batch
Generate cmd.exe batch files from short Powershell scripts. The Powershell scripts are Base64 encoded and handed to a new Powershell instance in the batch file. There is a limitation of 2975 characters for the script to convert.
### Set-InFile
Function to replace text in files programmatically without getting a mess with the text encodings. The function detects the encoding of each processed file and writes it back with the same encoding. I had to rename the function from Replace-InFile to Set-InFile, because unfortunately there is no suitable powershell verb for exchange operations. For details see the script version web page: [Replace-InFile.ps1: Replace text in files while preserving the encoding](https://gallery.technet.microsoft.com/Replace-InFileps1-Replace-1e0be31a).
### Compress-LogDirectory
This function compresses log files older than the current month to Zip archives in a given directory or in the IIS log directories and deletes the archived files. For details see the script version web page: [Powershell script to compress log files (and IIS logs)](https://gallery.technet.microsoft.com/Powershell-script-to-47f83931).
### Get-RebootTime
Function to retrieve the latest reboot time(s) of a computer. For details see the script version web page: [Retrieve latest reboot time(s)](https://gallery.technet.microsoft.com/Retrieve-latest-reboot-97ab5270).
## Versions
### 0.0.0, 2019-05-13
Test release
