
function check-archiveqty
{
    param($user,$folder)

write-host " "
    write-host "Getting folder items for $user"
    Get-MailboxFolderStatistics -identity $user -archive | where {$_.name -eq $folder} | ft name, itemsinfolder

    
}


