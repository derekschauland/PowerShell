function add-adgroupmember
{
    [cmdletbinding()]
    params(

    [parameter()]
    [int]
    $EnvironmentNumber,
    [parameter()]
    [string[]]
    $Devs,
    [parmeter()]
    [string[]]
    $Testers,
    [parameter(valuefrompipeline)]
    [string[]]
    $Apps
    )

    #get the dev groups for the Environment number you seek
    $devgroups = 

    #get the tester groups for the environment you seek
    $testergroups =

    #get the app groups for the environment and resource group you seek - remember an app only goes with
    #its resources for access
    $appgroups = 

    #capture the service principal as an object for later use 

    if(!([string]::isnullorempty($EnvironmentNumber)))
    {

        if(!([string]::isnullorempty($Devs)))
        {
            #if the dev string param as the values - do this
        }
        else {
            write-verbose "The Devs Parameter does not have values - no devs to add"
        }

        if(!([string]::isnullorempty($Testers)))
        {
            #if the testers string param has the values - do this
        }
        else {
            write-verbose "The Testers Parameter does not have values - no testers to add"
        }

        if(!([string]::isnullorempty($Apps)))
        {
            # if the apps string parameter has the values - do this
        }
        else {
            write-verbose "The Apps Parameter does not have values - no Apps to Add"
        }
    }
    else{
        write-verbose "You have not provided an environment number. This function currently requires this param. No Work Done."
    }

}