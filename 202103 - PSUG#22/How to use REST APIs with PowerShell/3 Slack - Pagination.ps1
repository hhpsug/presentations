# Terms to get to know when paginating in Slack
# limit - the amount of results you want for each page
#       - pay attention to the limits they require
# next_cursor - the reference to the following page in every page
#             - in the last page this value is empty
# cursor - the variable to use in query string in the url
#        - has the value you find in next_cursor in the previous page

$tokenSlack = Get-Secret -Name Slack-Token -AsPlainText

$method = "GET"
$headers = @{
    Authorization = "Bearer $tokenSlack"
}

$uri = "https://slack.com/api/conversations.list"

# Body contains the paramente Slack expects in querty string to the URI
$body = @{
    "limit" = 5
}

# Get the first page of channels
$channelsObj = Invoke-RestMethod -Method $method -Uri $uri -Headers $headers -Body $body
$channelsList = $channelsObj.channels

# loop to get the following pages
while ($channelsObj.response_metadata.next_cursor){
    # Body contains the paramente Slack expects in querty string to the URI
    $body = @{
        "limit" = "5"
        "cursor" = "$($channelsObj.response_metadata.next_cursor)"
    }
    $channelsObj = Invoke-RestMethod -Method $method -Uri $uri -Headers $headers -Body $body
    $channelsList += $channelsObj.channels
}

# amount of channels retrieved in total
$channelsList.Count
# shows the empty next cursor in teh last page
$channelsObj | Format-List

# we wanted the list of channels to look up the names
foreach ($channel in $channelsList){
    Write-Host $channel.name
}