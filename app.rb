require 'sinatra'
require 'resque'
require_relative 'lib/dedenne'
require_relative 'lib/dedenne/transcoder_queue'
require_relative 'config/resque'

set :bind, '0.0.0.0'

get '/transcode/course/:course_id/chapter/:chapter_id' do
  course_id     = params['course_id']
  chapter_id    = params['chapter_id']
  video_version = "-#{params['version']}" || ""

  Resque.redis = Config.redis_url || Config.local_redis
  Resque.enqueue(TranscoderQueue, course_id, chapter_id, video_version)
end
