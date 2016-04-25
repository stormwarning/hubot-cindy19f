# Configuration:
#   HUBOT_RESPONSE_CHANNELS
#   HUBOT_RESPONSE_CHANNELS_PATH

reach = require('hoek').reach
path = require('path')

module.exports = (robot) ->
  # Establish list of response channels.
  channels = []
  if process.env.HUBOT_RESPONSE_CHANNELS
    channels = process.env.HUBOT_RESPONSE_CHANNELS.split(',')
  else if process.env.HUBOT_RESPONSE_CHANNELS_PATH
    channels = require(path.resolve(process.env.HUBOT_RESPONSE_CHANNELS_PATH))

  unless Array.isArray(channels)
    robot.logger.error 'var [channels] is not an array.'

  robot.responseMiddleware (context, next, done) ->
    # If the room is not in the channels whitelist,
    unless reach(context, 'response.envelope.room') in channels
      # go no further.
      context.response.message.finish()
      done()
    else
      # Otherwise, carry on.
      next(done)
    
