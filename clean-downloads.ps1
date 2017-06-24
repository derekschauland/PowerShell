<#
 .ExternalHelp .\clean-downloads-Help.xml
#>
[cmdletbinding()]
param($days = "90",
[string]$path = "D:\shares\profiles",
[switch]$cleanup)

#$path = "D:\shares\profiles"
$logpath = "C:\logs\"
$logname = "Download-Cleanup-$(get-date -f "MM-dd-yyyy_hh-mm-ss").log"
$fulllog = $logpath+$logname
$whatiflogfile = "Download-Cleanup-whatif-$(get-date -f "MM-dd-yyyy_hh-mm-ss").log"
$whatiflog = $logpath+$whatiflogfile

$usershares = get-childitem -path $path

if($cleanup)
{
start-log -LogPath $logpath -logname $logname -ScriptVersion 1.0

}
else {
start-log -LogPath $logpath -logname $whatiflogfile -ScriptVersion 1.0
    
}

foreach($user in $usershares)
{
    
    if(!(test-path -Path "$path\$user\downloads"))
    {
        if($cleanup)
        {
                write-loginfo -LogPath $($whatiflog) -Message "$user has no Downloads folder - skipped"
                continue
        }
        else {
            write-loginfo -LogPath $($fulllog) -Message "$user has no Downloads folder - skipped"
            continue
        }
    }
    else
    {
        
       
        $files = get-childitem "$path\$user\downloads" -ErrorAction SilentlyContinue | where {$_.lastwritetime -lt (get-date).adddays(-$days)}

        if($cleanup)
        {   
            write-loginfo -LogPath $fulllog -message "Checking files for $($user):"
            write-loginfo -LogPath $fulllog -Message "Files will be cleaned up that are older than $days"
            foreach($file in $files)
            {
                $file | remove-item -force -Recurse
                write-loginfo -LogPath $fulllog -message "$file was removed."
            }
            
            

        }
        else {
             write-loginfo -LogPath $whatiflog -message "Checking files for $($user):"
            write-loginfo -LogPath $whatiflog -message "The following files are older than $days days:"
            foreach($file in $files)
            {
                Write-LogInfo -LogPath $whatiflog -message "$file"
            }
           

        }
    
    

    }    

}

# Getting alternate Data streams error when writing logs - need to research before first RUN Thurs @ 7pm

Stop-Log -LogPath $fulllog
Stop-Log -LogPath $whatiflog