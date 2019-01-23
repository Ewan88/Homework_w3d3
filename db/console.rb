require('pry')
require_relative('../models/album')
require_relative('../models/artist')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
   'name' => 'Drexciya'
    })
    artist1.save

album1 = Album.new({
   'title' => 'Neptune\'s Lair',
   'genre' => 'Electronic',
   'artist_id' => artist1.id
    })
    album1.save

album1.title = 'Journey of the Deep Sea Dweller'
album1.update()

binding.pry
nil
