﻿<#
    .NOTES
    --------------------------------------------------------------------------------
     Code generated by:  SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.148
     Generated on:       2/17/2018 4:06 PM
     Generated by:        Derek
     Organization:        
    --------------------------------------------------------------------------------
    .DESCRIPTION
        Script generated by PowerShell Studio 2018
#>


<#	
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.148
	 Created on:   	2/17/2018 12:30 PM
	 Created by:   	 Derek
	 Organization: 	 
	 Filename:     	DSChocolatey.psm1
	-------------------------------------------------------------------------
	 Module Name: DSChocolatey
	===========================================================================
#>

Function Get-DSCallingFunction
{
 <#
    .EXTERNALHELP 
    #>
    $callStack = Get-PSCallStack
    If ($callStack.Count -gt 1)
    {
        '{0}' -f $callStack[1].FunctionName
    }
}

Function Start-DSLogging
{
    #    If (-not (Get-Module pslogging))
    #    {
    #        If (Get-Module -ListAvailable | Where-Object { $_.Name -eq "pslogging" })
    #        {
    #            Import-Module pslogging
    #            Write-Verbose "PSLogging has been imported and is ready for use"
    #        }
    #        Else
    #        {
    #            Find-Module pslogging | Install-Module
    #        }
    #    }
    #    Else
    #    {
    #        Write-verbose "Good News! PSLogging is loaded"
    #    }
    
    $callingfunction = $global:functioncall
    #$callingfunction
    
    $loglocation = "$env:USERPROFILE\logs\"
    
    If (!(Test-Path $loglocation))
    {
        New-Item -Path $env:USERPROFILE -Name "logs" -ItemType "directory"
    }
    
    
    $global:logdate = (get-date -Format "yyyy-MM-dd hh-mm-ss")
    $logname = $callingfunction + "_" + $global:logdate + ".log"
    
    $scriptversion = "1"
    
    $global:logpath = $loglocation + $logname
    
    #$logname = $logname.Substring(0,$logname.IndexOf(' '))
    
    Start-Log -LogPath $loglocation -LogName $logname -ScriptVersion $scriptversion
    
    
    If ($global:functioncall -contains "script")
    {
        If (Test-Path $global:functioncall)
        {
            $global:scriptpath = $loglocation + $global:functioncall.substring(0, $global:functioncall.indexof('_'))
        }
    }
}

Export-ModuleMember -Function Get-DSCallingFunction




