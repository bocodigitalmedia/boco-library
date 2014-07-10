Bull = require 'bull'
Sourced = require 'boco-sourced'
MongoAdapter = require 'boco-sourced-mongodb'

# Configure the adapter
mongoAdapter = MongoAdapter.configure
  connectionString: 'mongodb://localhost/libraryDemo'
  revisionsCollectionName: 'revisions'

# Configure sourced
sourced = Sourced.createService
  storage: mongoAdapter

# Add item
addItem = (command, callback) ->
  console.log "AddItem", command

  params = command.parameters
  revision = sourced.createRevision 'LibraryItem'
  revision.addEvent 'Added',
    url: params.url, mimeType: params.mimeType, name: params.name

  console.log "Storing Revision", revision
  sourced.storeRevision revision, (error) ->
    console.log "Finished adding document: #{params.url}"
    callback error

# Configure the job queue and processing
queue = Bull 'commands', 6379, '127.0.0.1'

queue.on 'failed', (job, error) ->
  console.log "Failed #{job.id}", error

queue.on 'completed', (job) ->
  console.log "Completed #{job.id}"

queue.process (job, done) ->
  command = job.data
  console.log "Processing Job #{job.id}"
  switch command.name
    when 'AddItem' then addItem command, done
    else
      throw new Error("No route found for: #{command.name}")
