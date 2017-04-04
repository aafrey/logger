FaaS = require './faas-FaaS'
getStdin = require 'get-stdin'
base = 'https://techlancasterdemo.us/function/'

submitToAirtable = new FaaS base + 'stack_submit_to_airtable'
lowestIssueCount = new FaaS  base + 'stack_lowest_issue_count'
assignRecordTo = new FaaS base + 'stack_assign_record_to'
updateGithubIssue = new FaaS base + 'stack_updategithubissue'

getStdin()
.then (entry) ->
  entry = JSON.parse entry
  Promise.all [
    submitToAirtable.post(entry),
    lowestIssueCount.post()
  ]
.then (data) -> assignRecordTo.post
  record: data[0].record
  assignTo: data[1].user.id
.then console.log
.catch console.log.bind console
# TODO implement assignement in github
