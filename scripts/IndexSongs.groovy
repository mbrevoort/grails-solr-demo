
// This should delete all Songs and Genres
Song.executeUpdate("delete Song where id >0")
Genre.executeUpdate("delete Genre where id >0")

  def f = new File("Library.xml")
  def x = new XmlSlurper().parseText(f.text);
  def count=0
  x.dict.dict.dict.each {
    def i = 0
    def m = [:]
    def label
    it.children().each {
      if(i++ % 2 == 0) 
        label = it     
      else
        m."${label}" = it as String
    }

    Genre genre = (m.Genre?.trim()) ? Genre.findByName(m.Genre) : null
    if(!genre && m.Genre)
      genre = new Genre(name: m.Genre).save()
    def song = new Song(name: m.Name, album: m.Album, artist: m.Artist, year: m.Year, genre: genre)
    if(!song.save())  {
        song.errors.allErrors.each {
            println it
        }
    }   
    
    if(++count % 100 == 0)
      println "indexed ${count} Songs"
  }  

