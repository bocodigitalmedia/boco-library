Bull = require 'bull'
Sourced = require 'boco-sourced'
MongoAdapter = require 'boco-sourced-mongodb'
Library = require './coffee'

# Configure the adapter
mongoAdapter = MongoAdapter.configure
  connectionString: 'mongodb://localhost/libraryDemo'
  revisionsCollectionName: 'revisions'

# Configure sourced
sourced = Sourced.createService
  storage: mongoAdapter

# Configure the worker service
service = new Library.CommandWorkerService sourced: sourced

# Configure the job queue and processing
queue = Bull 'commands', 6379, '127.0.0.1'

queue.on 'failed', (job, error) ->
  console.log "Failed #{job.jobId}", error

queue.on 'completed', (job) ->
  console.log "Completed #{job.jobId}"

queue.process (job, done) ->
  command = job.data
  console.log "Processing Job #{job.jobId}"

  switch command.name
    when 'AddItem' then service.addItem command, done
    else
      throw new Error("No route found for: #{command.name}")
