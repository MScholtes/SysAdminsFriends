@echo off
:: Markus Scholtes, 2019
:: Erzeugen eines lokalen Test-Repositorys f¸r Powershell Get

md C:\Daten\PSRepo
md C:\Daten\Module
net share LocalPSRepo=C:\Daten\PSRepo /GRANT:Jeder,Change
powershell -nop -Command "Register-PSRepository -Name LocalRepo -SourceLocation '\\localhost\LocalPSRepo\' -ScriptSourceLocation '\\localhost\LocalPSRepo\' -InstallationPolicy Trusted"
echo Das Modul SysAdminsFriends wird nun verîffentlicht Åber ^(wenn es in C:\Daten\Module\SysAdminsFriends vorliegt^)
echo Publish-Module -Path 'C:\Daten\Module\SysAdminsFriends' -Repository LocalRepo -NuGetApiKey 'AnyStringWillDo'
echo.
echo Find-Module -Repository LocalRepo
echo   zeigt dann die vorhandenen Module an
echo.
echo Install-Module -Repository LocalRepo -Name SysAdminsFriends
echo   installiert das Modul SysAdminsFriends

:: Struktur f¸r Version 0.0.0:
:: Modul:
:: C:\Daten\Module\SysAdminsFriends\0.0.0
:: Repository:
:: C:\Daten\PSRepo\SysAdminsFriends.0.0.0.nupkg

:: Entfernt wird das Repository mit:
:: powershell -nop -Command "Unregister-PSRepository -Name LocalRepo"
:: net share LocalPSRepo /delete /yes
:: Anschlieﬂend kˆnnen die Verzeichnisse C:\Daten\PSRepo und C:\Daten\Module gelˆscht werden
