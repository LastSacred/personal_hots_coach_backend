class Import

  @@base_url = 'http://hotsapi.net/api/v1/'

  # def initialize
  #   @replay_path = './test/replays/'
  #   import_maps
  # end

  def self.maps
    data = RestClient.get @@base_url + "maps"
    JSON.parse(data.body)
  end

end
