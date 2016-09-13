require 'streamio-ffmpeg'

video = FFMPEG::Movie.new("/Users/aun/Movies/SampleVideo_1280x720_5mb.mp4")

puts video.valid?
puts "Audio stream :: " + video.audio_stream
puts "Video codec :: " + video.video_codec
puts "Resolution :: " +  video.resolution

options = {
  custom: %w(-b:v 300k -s 1920x1080 -c:v h264 -hls_time 1 -hls_list_size 0 -hls_key_info_file file.keyinfo -f hls)
}

transcoder_options = { validate: false }
video.transcode("./files/transcoded.m3u8", options, transcoder_options) do |progress|
  puts progress
end

File.rename './file.key', './files/file.key'

video = FFMPEG::Movie.new("./files/transcoded.m3u8")

puts "Audio stream :: " + video.audio_stream.to_s
puts "Video codec :: " + video.video_codec.to_s
puts "Resolution :: " +  video.resolution.to_s

