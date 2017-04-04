Chain = require './faas-chain'
getStdin = require 'get-stdin'
details = null

submitToAirtable = new Chain 'https://techlancasterdemo.us/function/stack_submit_to_airtable'
lowestIssueCount = new Chain 'https://techlancasterdemo.us/function/stack_lowest_issue_count'
assignRecordTo = new Chain 'https://techlancasterdemo.us/function/stack_assign_record_to'
updateGithubIssue = new Chain 'https://techlancasterdemo.us/stack_updategithubissue'

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
