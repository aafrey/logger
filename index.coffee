Chain = require './faas-chain'
getStdin = require 'get-stdin'
details = null

submitToAirtable = new Chain 'https://techlancasterdemo.us/function/stack_submitentry'
lowestIssueCount = new Chain 'https://techlancasterdemo.us/function/stack_lowestissuecount'
assignRecordTo = new Chain 'https://techlancasterdemo.us/function/stack_assignrecordto'
updateGithubIssue = new Chain 'https://techlancasterdemo.us/stack_updategithubissue'

getStdin()
.then (entry)->
  Promise.all [
    submitToAirtable.post(entry),
    lowestIssueCount.post()
  ]
.then (recordID, leastIssues) ->
  dataToUpdate =
    record: recordID
    assignTo: leastIssues.id
  assignRecordTo.post(record: recordID, assignTo: leastIssues.id)
