class Adapter

  @@base_url = 'http://hotsapi.net/api/v1/'
  @@replay_path = './test/replays'
  @@backend_url = ENV['BACKENDURL']
  @@frontend_url = ENV['FRONTENDURL']

  def self.get(target)
    data = RestClient.get @@base_url + target
    JSON.parse(data.body)
  end

  def self.post_replay(replay)
    data = RestClient.post @@base_url + 'replays', file: File.new(replay)
    JSON.parse(data.body)
  end

  def self.stay_awake
    RestClient.get @@frontend_url
    RestClient.get @@backend_url
  end

end
