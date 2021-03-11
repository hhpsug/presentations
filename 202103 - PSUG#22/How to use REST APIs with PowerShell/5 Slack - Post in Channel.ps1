# Here we want to post a message into a channel
$tokenSlack = Get-Secret -Name Slack-Token -AsPlainText
$method = "POST"
$uri = "https://slack.com/api/chat.postMessage"
$headers = @{
    Authorization = "Bearer $tokenSlack"
}

# "channel"  is the channel ID you want to pot to
# "text" is the message you want to post
$body = @{
    "channel" = "C01M3JYPEUX"
    "text" = "Hello Hello!!!"
}

$results = Invoke-RestMethod -Method $method -Uri $uri -Headers $headers -Body $body
$results