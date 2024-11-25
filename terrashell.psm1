function Invoke-TerraformInit 
{
    [[CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $Environment
    )]
    try{
        if(test-path "env/$environment.backend.tfvars")
        {
            $envbackend = "env/$environment.backend.tfvars"
        }
        elseif(test-path "env/$environment.tfbackend")
        {
            $envbackend = "env/$environment.tfbackend"
        }
        terraform init --reconfigure --upgrade --backend-config="$envbackend"
    }
    catch {
        "No backend Found... tried env/$environemnt.tfbackend and env/$environment.backend.tfvars"  
    }

} 

function Invoke-TerraformPlan
{
    [alias(tfplan)]
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $Environment,
        [Parameter()]
        [switch]
        $output
    )
        try {
            Invoke-TerraformInit -environment $Environment
        }
        $env:Current_Environment = $Environment
        $env:Current_Init="Current Init - $envbackend" 
        $env:TFProjectDir=$PWD
        if($output)
        {
            write-output "Environment variables set for: "
            write-output "Current_Environment: $env:Current_Environment"
            write-output "Current_Init: $env:Current_Init"
            write-output "Current Directory: $env:TFProjectDir"
            write-output " "
            write-output "Your Terraform Project Dir at last Init is: $env:TFProjectDir"
            write-output "You have initialized $envbackend."
        }
               
        try{if(test-path "$env:Current_Environment.tfvars")
            {
                $env:varfile = "$env:Current_Environment.tfvars"
                terraform plan --var-file="env/$Environment.tfvars" --out="tfplan"
            } 
            else{write-output "Please Ensure a tfvars file exists for $environment"}
    } 
} 

function Invoke-TerrraformApply {
    [alias(tfapply)]
    try {
        if(test-path tfplan)
        {terraform apply tfplan}
        else{Invoke-TerraformPlan -environment $env:Current_Environment}
    }

}

function Invoke-TerraformDestroy {
    [[CmdletBinding()]
    param (
        [Parameter(valuefrompipeline)]
        [string]
        $Environment
    )]
    if($env:Current_Environment)
    {
        terraform plan --var-file=
    }
}

set-alias tfplan -value Invoke-TerrraformPlan
set-alias tfapply -value Invoke-TerrraformApply