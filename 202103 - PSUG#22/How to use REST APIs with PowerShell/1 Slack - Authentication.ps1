# Slack doesn't allow Basic Authentication
# You need to create your own custom App setting the scopes you need in order to get the token

# Add a new Secret
Set-Secret -Name Slack-Token -Secret "xoxb-abc123..."

# Get the Secret form the PS vault
$tokenSlack = Get-Secret -Name Slack-Token -AsPlainText

$method = "GET"
$uri = "https://slack.com/api/conversations.list"
$headers = @{
    Authorization = "Bearer $tokenSlack"
}

$results = Invoke-RestMethod -Method $method -Uri $uri -Headers $headers
$results