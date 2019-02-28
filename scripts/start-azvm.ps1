<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.157
	 Created on:   	2/28/2019 12:55 PM
	 Created by:   	dschauland
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>


Import-Module PowerShellGet
Import-Module AzureRM.profile
Function connectto-azure
{
	[cmdletbinding()]
	
	Param (
		[Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)][string]$YourName
	)
	
	If (!(Get-Module -Name az))
	{
		#az mod not here... load it
		Install-Module -Name az -AllowClobber
	}
	
		Connect-AzAccount 
			
	
}

Function Start-AzureVM
{
	[cmdletbinding()]
	Param (
		[string]$ResourceGroupName,
		[string]$VMName,
		[System.Management.Automation.PSCredential]$VMCreds
		
	)
	
	#Get the vm provided and start it
	If ([string]::IsNullOrEmpty($VMname))
	{
		#No vm provided - check for vm and get status
		ForEach ($vm In get-azvm -resourcegroupname $ResourceGroupName)
		{
			If (((get-azvm -resourcegroupname $ResourceGroupName -name $vm -status) | Select-Object powerstate).powerstate -eq "VM running")
			{
				Write-Output "No need to start this vm - already running"
			}
			Else
			{
				ForEach ($azvm In (get-azvm -resourcegroupname $ResourceGroupName -name $vm))
				{
					start-azvm $azvm
				}
			}
		}
		
	}
	Else
	{
		#vmname provided - start it up
		
		If ((get-azvm -resourcegroupname $ResourceGroupName -name $VMName -status | Select-Object powerstate).powerstate -eq "VM running")
		{
			
		}
		Else
		{
			ForEach ($azvm In (get-azvm -resourcegroupname $ResourceGroupName -name $VMName))
			{
				start-azvm $azvm
			}
		}
	}
}

