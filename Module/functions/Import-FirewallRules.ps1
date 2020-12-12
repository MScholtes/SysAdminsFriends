<#
.SYNOPSIS
Imports firewall rules from a CSV or JSON file.
.DESCRIPTION
Imports firewall rules from with Export-FirewallRules generated CSV or JSON files. CSV files have to
be separated with semicolons. Existing rules with same display name will be overwritten.
.PARAMETER CSVFile
Input file
.PARAMETER JSON
Input in JSON instead of CSV format
.PARAMETER PolicyStore
Store to which the rules are written (default: PersistentStore).
Allowed values are PersistentStore, ActiveStore (the resultant rule set of all sources), localhost,
a computer name, <domain.fqdn.com>\<GPO_Friendly_Name> and others depending on the environment.
.NOTES
Author: Markus Scholtes
Version: 1.1.0
Build date: 2020/12/12
.EXAMPLE
Import-FirewallRules
Imports all firewall rules in the CSV file FirewallRules.csv in the current directory.
.EXAMPLE
Import-FirewallRules WmiRules.json -json
Imports all firewall rules in the JSON file WmiRules.json.
#>
function Import-FirewallRules
{
	Param($CSVFile = "", [SWITCH]$JSON, [STRING]$PolicyStore = "PersistentStore")

	#Requires -Version 4.0

	# convert comma separated list (String) to Stringarray
	function ListToStringArray([STRING]$List, $DefaultValue = "Any")
	{
		if (![STRING]::IsNullOrEmpty($List))
		{	return ($List -split ",")	}
		else
		{	return $DefaultValue}
	}

	# convert value (String) to boolean
	function ValueToBoolean([STRING]$Value, [BOOLEAN]$DefaultValue = $FALSE)
	{
		if (![STRING]::IsNullOrEmpty($Value))
		{
			if (($Value -eq "True") -or ($Value -eq "1"))
			{ return $TRUE }
			else
			{	return $FALSE }
		}
		else
		{
			return $DefaultValue
		}
	}


	if (!$JSON)
	{ # read CSV file
		if ([STRING]::IsNullOrEmpty($CSVFile)) { $CSVFile = ".\FirewallRules.csv" }
		$FirewallRules = Get-Content $CSVFile | ConvertFrom-CSV -Delimiter ";"
	}
	else
	{ # read JSON file
		if ([STRING]::IsNullOrEmpty($CSVFile)) { $CSVFile = ".\FirewallRules.json" }
		$FirewallRules = Get-Content $CSVFile | ConvertFrom-JSON
	}

	# iterate rules
	ForEach ($Rule In $FirewallRules)
	{ # generate Hashtable for New-NetFirewallRule parameters
		$RuleSplatHash = @{
			Name = $Rule.Name
			Displayname = $Rule.Displayname
			Description = $Rule.Description
			Group = $Rule.Group
			Enabled = $Rule.Enabled
			Profile = $Rule.Profile
			Platform = ListToStringArray $Rule.Platform @()
			Direction = $Rule.Direction
			Action = $Rule.Action
			EdgeTraversalPolicy = $Rule.EdgeTraversalPolicy
			LooseSourceMapping = ValueToBoolean $Rule.LooseSourceMapping
			LocalOnlyMapping = ValueToBoolean $Rule.LocalOnlyMapping
			LocalAddress = ListToStringArray $Rule.LocalAddress
			RemoteAddress = ListToStringArray $Rule.RemoteAddress
			Protocol = $Rule.Protocol
			LocalPort = ListToStringArray $Rule.LocalPort
			RemotePort = ListToStringArray $Rule.RemotePort
			IcmpType = ListToStringArray $Rule.IcmpType
			DynamicTarget = if ([STRING]::IsNullOrEmpty($Rule.DynamicTarget)) { "Any" } else { $Rule.DynamicTarget }
			Program = $Rule.Program
			Service = $Rule.Service
			InterfaceAlias = ListToStringArray $Rule.InterfaceAlias
			InterfaceType = $Rule.InterfaceType
			LocalUser = $Rule.LocalUser
			RemoteUser = $Rule.RemoteUser
			RemoteMachine = $Rule.RemoteMachine
			Authentication = $Rule.Authentication
			Encryption = $Rule.Encryption
			OverrideBlockRules = ValueToBoolean $Rule.OverrideBlockRules
		}

		# for SID types no empty value is defined, so omit if not present
		if (![STRING]::IsNullOrEmpty($Rule.Owner)) { $RuleSplatHash.Owner = $Rule.Owner }
		if (![STRING]::IsNullOrEmpty($Rule.Package)) { $RuleSplatHash.Package = $Rule.Package }

		Write-Output "Generating firewall rule `"$($Rule.DisplayName)`" ($($Rule.Name))"
		# remove rule if present
		Get-NetFirewallRule -EA SilentlyContinue -PolicyStore $PolicyStore -Name $Rule.Name | Remove-NetFirewallRule

		# generate new firewall rule, parameter are assigned with splatting
		New-NetFirewallRule -EA Continue -PolicyStore $PolicyStore @RuleSplatHash
	}
}
