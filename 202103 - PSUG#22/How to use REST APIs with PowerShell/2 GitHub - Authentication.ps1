# GitHub doesn't allow Basic Authentication
# You can either generate a dev token form the interface, or
# you can create your own custom App setting the scopes you need in order to get the token

# Add a new Secret
Set-Secret -Name GitHub-Token -Secret "xyz123...."

# Get the secret from the vault
$tokenGitHub = Get-Secret -Name GitHub-Token -AsPlainText 

$headers = @{
    Authorization = "token $tokenGitHub"
}

$method = "GET"

# this is a private repo this is why you need authentication to see it
$uri = "https://api.github.com/repos/graiezzi/Test-Private-Repo"

$results = Invoke-RestMethod -Method $method -Uri $uri -Headers $headers
$results

