## =====================================================================
## Title       : Add-ADUserToGroup
## Description : Add Active Directory User to a Group
## Author      : Idera
## Date        : 9/22/2008
## Input       : -server 
##               -domain
##               -ou
##               -group
##               -user
##               -verbose 
##               -debug   
## Output      : 
## Usage       : PS> .\Add-ADUserToGroup -server localhost:389 -domain Idera -ou sales -group Management -user Joe Smith -verbose -debug
## Notes       : Adapted from Windows PowerShell Cookbook, Lee Holmes
## Tag         : PowerShell, AD
## Change log  :
##  4/1/2009 - Added Read-Host input prompts and Write-Verbose and Write-Debug statements
## =====================================================================

param
(
   [string]$server = "$(Read-Host 'Server [e.g. localhost:389]')", 
   [string]$domain = "$(Read-Host 'Domain [e.g. Idera]')", 
   [string]$ou = "$(Read-Host 'Organizational Unit [e.g. Sales]')",
   [string]$group = "$(Read-Host 'Group [e.g. Outside Sales]')", 
   [string]$user = "$(Read-Host 'User [e.g. Joe Smith]')", 
   [switch]$verbose = $true,
   [switch]$debug = $false
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	Write-Verbose "Add Active Directory User to a Group..."
	Add-ADUserToGroup $server $domain $ou $group $user
}

function Add-ADUserToGroup($server,$domain,$ou,$group,$user)
{
	trap [Exception] 
	{
		write-error $("TRAPPED: " + $_.Exception.Message);
		continue;
	}

	# The group must be pre-existing for the specified OU and domain
	$groupObj = [adsi]"LDAP://$server/cn=$group,ou=$ou,dc=$domain,dc=COM"
	Write-Debug "Group object is LDAP://$server/ou=$ou,dc=$domain,dc=COM"
	
	# The user must be pre-existing for the specified OU and domain
	$userObj = "LDAP://$server/cn=$user,ou=$ou,dc=$domain,dc=COM"
	Write-Debug "User object is LDAP://$server/cn=$user,ou=$ou,dc=$domain,dc=COM"
	
	Write-Debug "Creating user ($user) in group ($group)"
  	$groupObj.Add($userObj)
}

main
# SIG # Begin signature block
# MIIU1wYJKoZIhvcNAQcCoIIUyDCCFMQCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUANbmcp3ZYDvF0QcqIEMKnOMc
# Ms+ggg92MIIEFDCCAvygAwIBAgILBAAAAAABL07hUtcwDQYJKoZIhvcNAQEFBQAw
# VzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExEDAOBgNV
# BAsTB1Jvb3QgQ0ExGzAZBgNVBAMTEkdsb2JhbFNpZ24gUm9vdCBDQTAeFw0xMTA0
# MTMxMDAwMDBaFw0yODAxMjgxMjAwMDBaMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
# ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIFRpbWVzdGFt
# cGluZyBDQSAtIEcyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAlO9l
# +LVXn6BTDTQG6wkft0cYasvwW+T/J6U00feJGr+esc0SQW5m1IGghYtkWkYvmaCN
# d7HivFzdItdqZ9C76Mp03otPDbBS5ZBb60cO8eefnAuQZT4XljBFcm05oRc2yrmg
# jBtPCBn2gTGtYRakYua0QJ7D/PuV9vu1LpWBmODvxevYAll4d/eq41JrUJEpxfz3
# zZNl0mBhIvIG+zLdFlH6Dv2KMPAXCae78wSuq5DnbN96qfTvxGInX2+ZbTh0qhGL
# 2t/HFEzphbLswn1KJo/nVrqm4M+SU4B09APsaLJgvIQgAIMboe60dAXBKY5i0Eex
# +vBTzBj5Ljv5cH60JQIDAQABo4HlMIHiMA4GA1UdDwEB/wQEAwIBBjASBgNVHRMB
# Af8ECDAGAQH/AgEAMB0GA1UdDgQWBBRG2D7/3OO+/4Pm9IWbsN1q1hSpwTBHBgNV
# HSAEQDA+MDwGBFUdIAAwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFs
# c2lnbi5jb20vcmVwb3NpdG9yeS8wMwYDVR0fBCwwKjAooCagJIYiaHR0cDovL2Ny
# bC5nbG9iYWxzaWduLm5ldC9yb290LmNybDAfBgNVHSMEGDAWgBRge2YaRQ2XyolQ
# L30EzTSo//z9SzANBgkqhkiG9w0BAQUFAAOCAQEATl5WkB5GtNlJMfO7FzkoG8IW
# 3f1B3AkFBJtvsqKa1pkuQJkAVbXqP6UgdtOGNNQXzFU6x4Lu76i6vNgGnxVQ380W
# e1I6AtcZGv2v8Hhc4EvFGN86JB7arLipWAQCBzDbsBJe/jG+8ARI9PBw+DpeVoPP
# PfsNvPTF7ZedudTbpSeE4zibi6c1hkQgpDttpGoLoYP9KOva7yj2zIhd+wo7AKvg
# IeviLzVsD440RZfroveZMzV+y5qKu0VN5z+fwtmK+mWybsd+Zf/okuEsMaL3sCc2
# SI8mbzvuTXYfecPlf5Y1vC0OzAGwjn//UYCAp5LUs0RGZIyHTxZjBzFLY7Df8zCC
# BJ8wggOHoAMCAQICEhEhQFwfDtJYiCvlTYaGuhHqRTANBgkqhkiG9w0BAQUFADBS
# MQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UE
# AxMfR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBHMjAeFw0xMzA4MjMwMDAw
# MDBaFw0yNDA5MjMwMDAwMDBaMGAxCzAJBgNVBAYTAlNHMR8wHQYDVQQKExZHTU8g
# R2xvYmFsU2lnbiBQdGUgTHRkMTAwLgYDVQQDEydHbG9iYWxTaWduIFRTQSBmb3Ig
# TVMgQXV0aGVudGljb2RlIC0gRzEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
# AoIBAQCwF66i07YEMFYeWA+x7VWk1lTL2PZzOuxdXqsl/Tal+oTDYUDFRrVZUjtC
# oi5fE2IQqVvmc9aSJbF9I+MGs4c6DkPw1wCJU6IRMVIobl1AcjzyCXenSZKX1GyQ
# oHan/bjcs53yB2AsT1iYAGvTFVTg+t3/gCxfGKaY/9Sr7KFFWbIub2Jd4NkZrItX
# nKgmK9kXpRDSRwgacCwzi39ogCq1oV1r3Y0CAikDqnw3u7spTj1Tk7Om+o/SWJMV
# TLktq4CjoyX7r/cIZLB6RA9cENdfYTeqTmvT0lMlnYJz+iz5crCpGTkqUPqp0Dw6
# yuhb7/VfUfT5CtmXNd5qheYjBEKvAgMBAAGjggFfMIIBWzAOBgNVHQ8BAf8EBAMC
# B4AwTAYDVR0gBEUwQzBBBgkrBgEEAaAyAR4wNDAyBggrBgEFBQcCARYmaHR0cHM6
# Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADAWBgNV
# HSUBAf8EDDAKBggrBgEFBQcDCDBCBgNVHR8EOzA5MDegNaAzhjFodHRwOi8vY3Js
# Lmdsb2JhbHNpZ24uY29tL2dzL2dzdGltZXN0YW1waW5nZzIuY3JsMFQGCCsGAQUF
# BwEBBEgwRjBEBggrBgEFBQcwAoY4aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNv
# bS9jYWNlcnQvZ3N0aW1lc3RhbXBpbmdnMi5jcnQwHQYDVR0OBBYEFNSihEo4Whh/
# uk8wUL2d1XqH1gn3MB8GA1UdIwQYMBaAFEbYPv/c477/g+b0hZuw3WrWFKnBMA0G
# CSqGSIb3DQEBBQUAA4IBAQACMRQuWFdkQYXorxJ1PIgcw17sLOmhPPW6qlMdudEp
# Y9xDZ4bUOdrexsn/vkWF9KTXwVHqGO5AWF7me8yiQSkTOMjqIRaczpCmLvumytmU
# 30Ad+QIYK772XU+f/5pI28UFCcqAzqD53EvDI+YDj7S0r1txKWGRGBprevL9DdHN
# fV6Y67pwXuX06kPeNT3FFIGK2z4QXrty+qGgk6sDHMFlPJETiwRdK8S5FhvMVcUM
# 6KvnQ8mygyilUxNHqzlkuRzqNDCxdgCVIfHUPaj9oAAy126YPKacOwuDvsu4uyom
# jFm4ua6vJqziNKLcIQ2BCzgT90Wj49vErKFtG7flYVzXMIIGtzCCBZ+gAwIBAgIQ
# A0s7QxCX1YVPXfOX8SI+0zANBgkqhkiG9w0BAQUFADBvMQswCQYDVQQGEwJVUzEV
# MBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29t
# MS4wLAYDVQQDEyVEaWdpQ2VydCBBc3N1cmVkIElEIENvZGUgU2lnbmluZyBDQS0x
# MB4XDTEzMDcwOTAwMDAwMFoXDTE0MDcxNDEyMDAwMFowgYIxCzAJBgNVBAYTAlVT
# MRIwEAYDVQQIEwlXaXNjb25zaW4xEzARBgNVBAcTCkdyZWVudmlsbGUxJDAiBgNV
# BAoTG0RlcmVrIENocmlzdG9waGVyIFNjaGF1bGFuZDEkMCIGA1UEAxMbRGVyZWsg
# Q2hyaXN0b3BoZXIgU2NoYXVsYW5kMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
# CgKCAQEAy/QFFnq4jBwyNP1Xpsn3iMS+5DYOBWAfZ6sak8Ym8QehKU+2/+On2E4H
# tx8BdUwWz9yRjdIc3PdN53qYRQNl4+HoJACiiccb67SzPM305KmSp2iLQe2evqdh
# eESjNen5IgkY889gISI9FvQFTyOIlTjySu3mxUVTpvIC869zQp1Apuj1jqo2hQbX
# G6QiEAZIWY1dWT06+QGy1lg+Y4fdtkxbTHCNe5b/mn14fGHXGG/K1t2CokpU8zjm
# VXIDXmT9MAm9SOaUDg7rnp68GnOLV8piEiC1UckbI5z/9cdFSxMXwYvCKE3tXPZC
# RzX8Zd0r8FFkU0EgX9FR3VpME5j9GwIDAQABo4IDOTCCAzUwHwYDVR0jBBgwFoAU
# e2jOKarAF75JeuHlP9an90WPNTIwHQYDVR0OBBYEFPNHiF061xLoMmeWpprOheI2
# T9+nMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzBzBgNVHR8E
# bDBqMDOgMaAvhi1odHRwOi8vY3JsMy5kaWdpY2VydC5jb20vYXNzdXJlZC1jcy0y
# MDExYS5jcmwwM6AxoC+GLWh0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNvbS9hc3N1cmVk
# LWNzLTIwMTFhLmNybDCCAcQGA1UdIASCAbswggG3MIIBswYJYIZIAYb9bAMBMIIB
# pDA6BggrBgEFBQcCARYuaHR0cDovL3d3dy5kaWdpY2VydC5jb20vc3NsLWNwcy1y
# ZXBvc2l0b3J5Lmh0bTCCAWQGCCsGAQUFBwICMIIBVh6CAVIAQQBuAHkAIAB1AHMA
# ZQAgAG8AZgAgAHQAaABpAHMAIABDAGUAcgB0AGkAZgBpAGMAYQB0AGUAIABjAG8A
# bgBzAHQAaQB0AHUAdABlAHMAIABhAGMAYwBlAHAAdABhAG4AYwBlACAAbwBmACAA
# dABoAGUAIABEAGkAZwBpAEMAZQByAHQAIABDAFAALwBDAFAAUwAgAGEAbgBkACAA
# dABoAGUAIABSAGUAbAB5AGkAbgBnACAAUABhAHIAdAB5ACAAQQBnAHIAZQBlAG0A
# ZQBuAHQAIAB3AGgAaQBjAGgAIABsAGkAbQBpAHQAIABsAGkAYQBiAGkAbABpAHQA
# eQAgAGEAbgBkACAAYQByAGUAIABpAG4AYwBvAHIAcABvAHIAYQB0AGUAZAAgAGgA
# ZQByAGUAaQBuACAAYgB5ACAAcgBlAGYAZQByAGUAbgBjAGUALjCBggYIKwYBBQUH
# AQEEdjB0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wTAYI
# KwYBBQUHMAKGQGh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFz
# c3VyZWRJRENvZGVTaWduaW5nQ0EtMS5jcnQwDAYDVR0TAQH/BAIwADANBgkqhkiG
# 9w0BAQUFAAOCAQEAQE4C9xQuS13DR5YyFtRWPSQfCgsu8J9xBdYpDAGaWdKBdjxc
# zMmUiMo2GkWx8NEFl3uKOfyBMbgofQOfLJxW8Tz0U85kmHu9qb53PCRlUhOpiNOv
# J4wfjmQb/wlUNzHAEWeYmMkZnGQFSdlIZT+GXmgXSy7cJ2SqFNhLWYijEBzVc6F6
# TDaJMa6C6P+GkoNtFuFFWKW44HqvOBHH0FW+s3O4mDDdExv8tfOFt1falJ47G+aO
# T0+QnLwxbNt12uhZuMOoSkH2Bo7Dm0lHc5QgAsRDbbz5ZKXbpDr1D1/8lnGUqMZa
# QmShKtW8xlS7x7E7U/eWXEiFtCkDXc356UTwUzGCBMswggTHAgEBMIGDMG8xCzAJ
# BgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5k
# aWdpY2VydC5jb20xLjAsBgNVBAMTJURpZ2lDZXJ0IEFzc3VyZWQgSUQgQ29kZSBT
# aWduaW5nIENBLTECEANLO0MQl9WFT13zl/EiPtMwCQYFKw4DAhoFAKB4MBgGCisG
# AQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFPr+
# xG0SvPzVBEcRjPLo6km1e82jMA0GCSqGSIb3DQEBAQUABIIBAKv12v5y5r4FXyQM
# 8SkRATgefm3ZBl92lyq+q3wH16ykt/YAFKADTiIQk+KeFEPOizfRVwmweiQmhyfp
# cOeWbe91Z9H+fasTOXaah9k9ym+QKgUe78C1fb5U5u/4UOXSL2hUXa8TAS9uQY7G
# pfJ/zaoQE/UjCpgQ6VbTyMXN3WypSjXrGaBHPg7n51mBsLpwIeOiK8cGB5g52O0a
# WAMICFrOz0YEETdVQPM3Xt1xr5hOWaLFDyQaXwkGI7N1PJ6+lHOVF29sMGvm7417
# RYtWDHetqhGUobsoFRson8To22vlw8s08pmYgIC1BnhlTkMhF8MLABS+nxtyC5YA
# tOH2csWhggKiMIICngYJKoZIhvcNAQkGMYICjzCCAosCAQEwaDBSMQswCQYDVQQG
# EwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFs
# U2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBHMgISESFAXB8O0liIK+VNhoa6EepFMAkG
# BSsOAwIaBQCggf0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
# CQUxDxcNMTQwNjI2MTQwMjI1WjAjBgkqhkiG9w0BCQQxFgQUsJvLVKAdOVRU1vIk
# sBVv5RgT7xowgZ0GCyqGSIb3DQEJEAIMMYGNMIGKMIGHMIGEBBSM5p9QEuHRqPs5
# Xi4x4rQr3js0OzBsMFakVDBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
# U2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0Eg
# LSBHMgISESFAXB8O0liIK+VNhoa6EepFMA0GCSqGSIb3DQEBAQUABIIBAHF9Pb+y
# NaUIm1kmABeRM1uQqyrYHB3Riq6qn39J+lFk2mopTH1T1qq/UwPSwCq5mHdllD+7
# LxTy+cEoHlG3QK7IVKRRUb7dhtSdVL4jQWZyRu55mKQJckr24BwfrhkgMPXdf11x
# Fxja1nXKO3syAA0YSMZci9gyDZao5r61O7kRVQY4Fubcqlh30e5kXsdHQkrQU2/1
# 1q3UTNu+01ivu9DX6PAKnuyykLqpgddVaP6UIyX85F4CMG918usfkMgYF0FXDCGu
# nQYEmpH0NfP9NM82RDWDiyVuef5fTO4ataslQGbuwN4F9z/nAVOJs0HQa1vU4aXU
# tun+0N0NCMgpZqA=
# SIG # End signature block
