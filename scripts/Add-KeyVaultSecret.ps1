function Add-JMKeyvaultSecret
{
    [cmdletbinding()]

    param(
        [parameter(mandatory)]$Resourcegroupname,
        [parameter(mandatory)]$KeyVaultName,
        [parameter()]$SecretName,
        [parameter(parametersetname="keepass")]$keePassDBPath,
        [parameter(parametersetname="keepass")]$keePassKey,
        [parameter(parametersetname="keepass")]$KeePassEntryTitle,
        [parameter(parametersetname="nokeepass")][Securestring]$SecretValue
    )

    $PostCreds = convertto-securestring -string "These are replacement values - Do not change them here!" -asplaintext -force

    $KeePassEntry = get-keepassvalues -entrytitle $KeePassEntryTitle -kdbxpath $keepassDBPath -keyfilepath $keepasskey

    $SecKeepassEntryUsername = convertto-securestring -string $keepassentry.username -asplaintext -force
    $SecKeepassEntryPassword = convertto-securestring -string $keepassentry.password -asplaintext -force

    try {
        get-azkeyvault -resourcegroupname $Resourcegroupname -vaultname $keyvaultname
        write-verbose "Key Vault found!"
    }
    catch {
        write-verbose "No KeyVault found in $resourcegroupname with the name $keyvaultname"
    }

    if(!($keepassDBPath))
    {
       try {
        get-azkeyvaultsecret -vaultname $keyvaultName -name $secretname
        #the secret is here already - lets make a version
        write-verbose "Secret Exiists - will need to add version"
        #set secret 
        set-azkeyvaultsecret -vaultname $keyvaultname -name $secretname -secretvalue $secretvalue
        Write-verbose "The Secret has been added to key vault!"
        $secretvalue = $postcreds
        }
        catch {
            write-verbose "Secret not found - add as new"
            #the secret is here already - lets make a version
            get-azkeyvaultsecret -vaultname $keyvaultName -name $secretname
            write-verbose "Secret Exiists - will need to add version"
            #set secret
            set-azkeyvaultsecret -vaultname $keyvaultname -name $secretname -secretvalue $secretvalue
            Write-verbose "The Secret has been added to key vault!"
            $secretvalue = $postcreds
        }
    }
    else 
    {
        #Keepass is used
        $KPUserSecret = $secretName + "UsernameSecret"
        $KPPassSecret = $secretName + "PasswordSecret"
        #set secret - username
        set-azkeyvaultsecret -vaultname $keyvaultname -name $kpusersecret -secretvalue $SecKeepassEntryUsername
        Write-verbose "The Username Secret has been added to key vault!"
        #set secret - pwd
        set-azkeyvaultsecret -vaultname $keyvaultname -name $KPPassSecret -secretvalue $SecKeepassEntryPassword
        Write-verbose "The Password Secret has been added to key vault!"
    }
        $SecKeepassEntryUsername = $postcreds
        $SecKeepassEntryPassword = $postcreds
        write-verbose "the secure values have been wiped!"
}
