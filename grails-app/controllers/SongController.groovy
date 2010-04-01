import org.apache.solr.client.solrj.SolrQuery
import org.apache.solr.common.params.ModifiableSolrParams

class SongController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {

      List fq = []
      
      def query = new SolrQuery("${params.q}")
      
      if(params.fq) {
        query.addFilterQuery(params.fq)
        if(params.fq instanceof String)
          fq << params.fq
        else 
          fq = params.fq      
      }
      if(params.offset)
        query.setStart(params.offset as int)
      if(params.max)
        query.setRows(params.max as int)

  	  query.facet = true
  	  ["genre", "artist", "year", "name"].each {
  	    query.addFacetField(Song.solrFieldName(it))  
  	  }
      query.setFacetMinCount(2)
      query.setFacetLimit(10)
      
  	  [result:Song.searchSolr(query), q:params.q, fq: fq, solrQueryUrl: query.toString()]
    }


    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [songInstanceList: Song.list(params), songInstanceTotal: Song.count()]
    }

    def create = {
        def songInstance = new Song()
        songInstance.properties = params
        return [songInstance: songInstance]
    }

    def save = {
        def genre = Genre.findByName(params.genre)
        if(!genre) 
          genre = new Genre(name: params.genre)
        params.genre = genre
        def songInstance = new Song(params)

        songInstance.genre = genre
        if (songInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'song.label', default: 'Song'), songInstance.id])}"
            redirect(action: "show", id: songInstance.id)
        }
        else {
            render(view: "create", model: [songInstance: songInstance])
        }
    }

    def show = {
        def songInstance = Song.get(params.id)
        if (!songInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'song.label', default: 'Song'), params.id])}"
            redirect(action: "list")
        }
        else {
            [songInstance: songInstance]
        }
    }

    def edit = {    
        def songInstance = Song.get(params.id)
        if (!songInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'song.label', default: 'Song'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [songInstance: songInstance]
        }
    }

    def update = {
        def genre = Genre.findByName(params.genre)
        if(!genre) 
          genre = new Genre(name: params.genre).save(flush:true)
        params.genre = genre      
        def songInstance = Song.get(params.id)
        if (songInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (songInstance.version > version) {
                    
                    songInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'song.label', default: 'Song')] as Object[], "Another user has updated this Song while you were editing")
                    render(view: "edit", model: [songInstance: songInstance])
                    return
                }
            }
            songInstance.properties = params
            if (!songInstance.hasErrors() && songInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'song.label', default: 'Song'), songInstance.id])}"
                redirect(action: "show", id: songInstance.id)
            }
            else {
                render(view: "edit", model: [songInstance: songInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'song.label', default: 'Song'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def songInstance = Song.get(params.id)
        if (songInstance) {
            try {
                songInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'song.label', default: 'Song'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'song.label', default: 'Song'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'song.label', default: 'Song'), params.id])}"
            redirect(action: "list")
        }
    }
}
