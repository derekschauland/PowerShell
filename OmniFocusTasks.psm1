<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.153
	 Created on:   	7/4/2018 9:21 AM
	 Created by:   	 Derek
	 Organization: 	 
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		Quick Module for Sending tasks individually or from a CSV file to Omnifocus
#>

Function Send-Tasks
{
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$task,
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$notes
    )
    If ([string]::IsNullOrEmpty($notes))
    {
        Send-MailMessage -Subject $task -Body $notes -To "derekschauland.vdp3d@sync.omnigroup.com" -SmtpServer "smtp.office365.com" -Port 587 -UseSsl -From "OmniFocus Powershell <derek@derekschauland.com>" -Credential (Import-Clixml $env:USERPROFILE\mailcred.cred)
    }
    Else
    {
        Send-MailMessage -Subject $task -To "derekschauland.vdp3d@sync.omnigroup.com" -SmtpServer "smtp.office365.com" -Port 587 -UseSsl -From "OmniFocus Powershell <derek@derekschauland.com>" -Credential (Import-Clixml $env:USERPROFILE\mailcred.cred)
    }
    
}

Function Send-CSVTasks
{
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory, ValueFromPipeline)]
        $file
    )
    
    $tasks = Import-Csv -Delimiter "," -Path $file
    
    ForEach ($task In $tasks)
    {
        $name = $task.name
        $note = $task
        
        Send-MailMessage -Subject $name -Body $note -To "derekschauland.vdp3d@sync.omnigroup.com" -SmtpServer "smtp.office365.com" -Port 587 -UseSsl -From "OmniFocus Powershell <derek@derekschauland.com>" -Credential (Import-Clixml $env:USERPROFILE\mailcred.cred)
    }
    
}
Export-ModuleMember Send-Tasks
Export-ModuleMember Send-CSVTasks




