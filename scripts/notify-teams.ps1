function notify-teams
{
    param($message = "writing any message I want")


$uri = "https://outlook.office.com/webhook/e732d058-111b-4562-bd78-8c4a6f84755d@1b39db0a-17c9-481c-8d95-1d927f08cc67/IncomingWebhook/2e450c636f7643aaa173c56322eee44c/8e82349a-5e2e-4611-a68b-75bbfe4b620e"

$body = convertto-json @{
    text = "$message"
}
invoke-restmethod -uri $uri -method Post -body $body -contenttype 'application/json'
}



