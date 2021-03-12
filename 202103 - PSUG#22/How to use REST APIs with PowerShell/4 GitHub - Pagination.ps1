# PowerShell repo is public so no authentication is needed
$method = "GET"
$uri = 'https://api.github.com/repos/powershell/powershell/issues'
# issuesList is an array where every item contains the first list of 30 issues (GitHub max limit of issues per page) 
$issuesList = Invoke-RestMethod -Method $method -uri $Uri -FollowRelLink -MaximumFollowRelLink 4

# It returns the amount of pages
$issuesList.Count
# It contains the list of issues for each call we made
$issuesList[0].Count
# It contains the info from 1 issue
$issuesList[0][3]

# Where does FollowRelLink takes the next link?
$issuesList = Invoke-RestMethod -Method $method -Uri $Uri -FollowRelLink -MaximumFollowRelLink 4 -ResponseHeadersVariable responseHeader 
# held the response header
$responseHeader
# contains the links FollowRelLink use to loop into the pages
$responseHeader.Link


