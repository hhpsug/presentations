# Here we want to create an issue in a repo
$tokenGitHub = Get-Secret -Name GitHub-Token -AsPlainText
$headers = @{
    Authorization = "token $tokenGitHub"
    "Accept" = "application/vnd.github.v3+json"
}

# Example 1 - Object
# GitHub wants you to force the body variable to be a string in a valid JSON format otherwise it will give you an error so ConvertTo-Json is needed
$body = @{
    "title" = "I get an error!!!"
    "body" = "This error is very bad O_o"
} | ConvertTo-Json

# Example 2 - Here-Strings
# or you can create an here string which will already have the JSON formatted in it
$body = @"
{
'title' : 'I get an error!!!',
'body' : 'This error is very bad O_o'
}
"@

$method = "POST"
$uri = "https://api.github.com/repos/graiezzi/Test-Private-Repo/issues"

$results = Invoke-RestMethod -Method $method -Uri $uri -Headers $headers -Body $body 
$results

