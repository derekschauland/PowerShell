## ===================================================================== 
## Description : Add a New IIS 7.0 Web Site 
##             : Uses IIS 7.0 PowerShell Provider
## Author      : Idera
## Date        : 12/26/2008 
## Input       : -siteName 
##               -protocol 
##               -ipAddress 
##               -port 
##               -location
## Output      :  
## Usage       : PS> .\Add-IIS7WebSite -siteName "NewWebsite" -protocol "http" -ipAddress "127.0.0.1" -port 80 -location c:\inetpub\wwwroot\NewWebsite
## Notes       : Credit to Jeong's Blog at http://blogs.iis.net/jeonghwan/default.aspx
## Tag         : IIS
## Change log  : 
##  4/1/2009 - Added input parameters, param block, main and trap
##  4/1/2009 - Added Read-Host input prompts and Write-Verbose and Write-Debug statements
## ===================================================================== 

param
(
	[string]$siteName = "$(Read-Host 'Site Name [e.g MySite]')", 
	[string]$protocol = "$(Read-Host 'Protocol [e.g http]')", 
	[string]$ipAddress = "$(Read-Host 'IP Address [e.g 127.0.0.1]')", 
	[string]$port = "$(Read-Host 'Port [e.g 80]')", 
	[string]$location = "$(Read-Host 'Location [e.g C:\demoSite]')", 
	[switch]$verbose = $true,
	[switch]$debug = $false
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	
	Write-Verbose "Add a New IIS 7.0 Web Site..."
	Add-IIS7WebSite $siteName $protocol $ipAddress $port $location
}

function Add-IIS7WebSite($siteName, $protocol, $ipAddress, $port, $location)
{
	trap [Exception] 
	{
		write-error $("TRAPPED: " + $_.Exception.Message);
		continue;
	}

	$path = "iis:\sites\" + $siteName
	Write-Debug "Path is $path"
	
	$binding = $ipAddress + ":" + $port + ":$siteName"
	Write-Debug "Binding is $binding"
	
	New-Item $path -bindings @{protocol=$protocol;bindingInformation=$binding} -physicalPath $location
}

main
