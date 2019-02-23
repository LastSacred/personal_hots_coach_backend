class Adapter

  @@base_url = 'http://hotsapi.net/api/v1/'
  @@replay_path = './test/replays'

  # def initialize
  #   @replay_path = './test/replays/'
  #   import_maps
  # end

  def self.get(target)
    data = RestClient.get @@base_url + target
    JSON.parse(data.body)
  end

  def self.post_replay(replay)
    data = RestClient.post @@base_url + 'replays', file: File.new(replay)
    JSON.parse(data.body)
  end

end
