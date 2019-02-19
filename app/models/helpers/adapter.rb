class Adapter

  @@base_url = 'http://hotsapi.net/api/v1/'

  # def initialize
  #   @replay_path = './test/replays/'
  #   import_maps
  # end

  def self.get(target)
    data = RestClient.get @@base_url + target
    JSON.parse(data.body)
  end

end
