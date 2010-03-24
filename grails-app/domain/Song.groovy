import org.grails.solr.Solr

class Song {
  
  static enableSolrSearch = true
	static solrAutoIndex = true
	
	@Solr(asText=true)
	String album
	
	String artist
	String name
	String year = ""
	
	@Solr(field="genre_s")
	Genre genre
	
	// To override default field name @Solr(field="astringanothername_s")
	
	static constraints = {
	  year(blank:true, nullable: true)
	  genre(nullable: true)
	  album(blank:true, nullable: true)
	}
	
  String solrTitle() {
    "${name} by ${artist}"
  }	
  
  def indexSolrGenre(doc) {
    if(genre) {
      def fieldName = this.solrFieldName("genre")
      doc.addField(fieldName, genre.name)
      if(fieldName != "genre_t")
        doc.addField("genre_t", genre.name)
    }
  }
  
}