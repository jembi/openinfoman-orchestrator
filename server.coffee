http = require 'http'

pollTimeMS = 60000
serviceNames = ['openinfoman_providers', 'rhea_simple_provider']

csdHost = "localhost"
csdPort = 8984

outstandingReq = 0

pollService = (name) ->
  console.log "Polling service: " + name
  outstandingReq = outstandingReq + 1

  options =
    hostname: csdHost
    port: csdPort
    path: '/CSD/pollService/' + name + '/get'
    method: 'GET'
  req = http.request options, (res) ->
    outstandingReq = outstandingReq - 1
    if res.statusCode == 200
      console.log "Successfully polled " + name
    else
      console.log "Failed to poll " + name
  req.end();

mergeServices = ->
  console.log "Empty existing merged service"
  options =
    hostname: csdHost
    port: csdPort
    path: '/CSD/mergeServices/empty'
    method: 'GET'
  req = http.request options, (res) ->
    if res.statusCode == 302
      console.log "Successfully emptied services"
      console.log "Merging updated services..."
      options =
        hostname: csdHost
        port: csdPort
        path: '/CSD/mergeServices/merge'
        method: 'GET'
      req = http.request options, (res) ->
        if res.statusCode == 302
          console.log "Successfully merged services"
          console.log "Sleeping until next interval...\n"
        else
          console.log "Failed to merge services"
      req.end()
    else
      console.log "Failed to empty services"

  req.end()

mergeServiceWhenDone = ->
  if outstandingReq > 0
    setTimeout mergeServiceWhenDone, 2000
    console.log "Attempted to merge service but, polling services not complete, sleeping..."
  else
    console.log "Polling complete, attempting to merge services..."
    mergeServices()

pollAndMergeServices = (name) ->
  for serviceName in serviceNames
    pollService serviceName

  console.log "Attempting to merge services..."
  mergeServiceWhenDone()

pollAndMergeServices()
setInterval pollAndMergeServices, pollTimeMS
