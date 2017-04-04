Chain = require './faas-chain'
getStdin = require 'get-stdin'
details = null

submitToAirtable = new Chain 'http://45.76.4.146:8080/function/stack_submitentry'
lowestIssueCount = new Chain 'http://45.76.4.146:8080/function/stack_lowestissuecount'
assignRecordTo = new Chain 'http://45.76.4.146:8080/function/stack_assignrecordto'
updateGithubIssue = new Chain 'http://45.76.4.146:8080/stack_updategithubissue'

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
