## =====================================================================
## Title       : Add-IADGroupMember
## Description : Add one or more objects to a group in Active Directory.
## Author      : Idera
## Date        : 8/11/2009
## Input       : Add-IADGroupMember [[-MemberDN] <String[]>]
##                     
## Output      : No Output
## Usage       :
##               1. Add the domain administrator account to the QA group 
##               Get-IADGroup QA | Add-IADGroupMember -MemberDN 'CN=Administrator,CN=Users,DC=domain,DC=com'  
## 
##               2. Add multiple accounts to the QA group 
##               $members = Get-IADUser -Name QAUser* | Foreach-Object { $_.distinguishedName } 
##               Get-IADGroup QA | Add-IADGroupMember -MemberDN $members 
##            
## Notes       :
## Tag         : group, member, activedirectory
## Change log  :
## =====================================================================


filter Add-IADGroupMember {
 param(
 [string[]]$MemberDN = $(Throw "MemberDN cannot be empty.") 
)
 

 if($_ -is [ADSI] -and $_.psbase.SchemaClassName -eq 'group')
 {
  $group = $_
  trap {
   Write-Error $_
   continue
  } 


  $MemberDN | Where-Object {$_} | ForEach-Object { $null = $group.member.add($_) } 

  $group.psbase.commitChanges()
 }
 else
 {
  Write-Warning "Wrong object type, only Group objects are allowed."
 }
}
# SIG # Begin signature block
# MIIU1wYJKoZIhvcNAQcCoIIUyDCCFMQCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU4Se5kkWKucva1AuIBOcG9Y+f
# FX+ggg92MIIEFDCCAvygAwIBAgILBAAAAAABL07hUtcwDQYJKoZIhvcNAQEFBQAw
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
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFKoJ
# G9n5Emkf7n47NCTOhjKEXYNuMA0GCSqGSIb3DQEBAQUABIIBAC7OGBjAeIrfHiyN
# dVQKUnGRIRfLuOyepUrP3GwXqIyRDwNK1CBju4rBR1I46Lz8pFSjsfqnLwVMswAH
# JdnU5J4NaaZyAM6iqLd8CNlkn5liusM/nzv2DFj2Iw5LddSYq4UzyE5H3x+tfS1Q
# TolH+kricPenbWHPKqqk1UXHM0a4KM6YyIssGgDhw+wt8ucEDHLQg0ttJKoKG0up
# b9SEr3onAf/C8rRYr8U5Dp1mLizotLPx5XB3qtJh52ZkDBy769+xdWPXvQHpcrB1
# XMxq2sS+mU0TRg8cRBMGFVw42uH09WPEmi5E9TexgQ+TxboSQztebqklI7fY+NXC
# nGhicV6hggKiMIICngYJKoZIhvcNAQkGMYICjzCCAosCAQEwaDBSMQswCQYDVQQG
# EwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFs
# U2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBHMgISESFAXB8O0liIK+VNhoa6EepFMAkG
# BSsOAwIaBQCggf0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
# CQUxDxcNMTQwNjI2MTQwMjI3WjAjBgkqhkiG9w0BCQQxFgQUA7fuW2Cq1faFC1fj
# 7RLAC2KW/JkwgZ0GCyqGSIb3DQEJEAIMMYGNMIGKMIGHMIGEBBSM5p9QEuHRqPs5
# Xi4x4rQr3js0OzBsMFakVDBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
# U2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0Eg
# LSBHMgISESFAXB8O0liIK+VNhoa6EepFMA0GCSqGSIb3DQEBAQUABIIBAGllz7tw
# Kc85D9GsJ9xjwiCmnmI/uyN1qq6aEIPe7ANsZ9C2wk2AxYChEueMEQ1bIDbkAPPH
# 2A+W1/It5IfyHcLOfvIDUAyPSewiK1xdP6fN1r1EiDnLnCToQvMzJKfnk9VOZt/w
# 3L+fV3gplLDeyE1vt8fRp9H2ISG8JFyl3S9CStju1W88fdo0vxc39uxaBQAPh/ar
# N76QAvYqcIAr8Xr8zegSoprTkyj/wxmWsmlxpKSsCSzYBGQUe2hTdQCqoY0oXfNU
# +SXXWWnzDFFjof8KMCD0wtPLzI1TJ8mkBymstFHUBsNJYPntxI03hTtldY0siBDa
# YnTqwtWMzMSO6M0=
# SIG # End signature block