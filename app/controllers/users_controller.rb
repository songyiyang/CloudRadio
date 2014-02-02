class UsersController < ApplicationController
  def show
  end

  def index
  end
  
  def homepage
    #genre_array = %w(Alternative\ Rock Ambient Bluegrass Blues Classical Country Dance Deep\ House Disco Drum\ &\ Bass Dubstep Electro Electronic Folk Funk\ Rock Hardcore\ Techno Hip\ Hop House Indie\ Rock Jazz Latin Metal Metalcore Mixtape Piano Pop Progressive\ House Punk R&B Rap Reggae Rock Singer-Songwriter Soul Tech\ House Techno Trance Trap Trip\ Hop World Audiobooks Business Comedy Entertainment Learning News\ &\ Politics Religion\ &\ Spirituality Science Sports Storytelling)
    genre_array = %w(ambient bluegrass blues classical country dance disco dubstep electro electronic folk hiphop house indierock jazz latin metal metalcore mixtape piano pop punk rap reggae rock soul techno trance trap world audiobooks business comedy entertainment learning science sports storytelling)
    @client = Soundcloud.new(:client_id => 'ae9f52f98895e6a3663870f4de3549a5')
    @track = @client.get('/tracks', :limit => 200, :tags => genre_array[Random.rand(0..37)])
  end

  def new
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def create
  end
end
