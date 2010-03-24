<html>
    <head>
        <title>Grails Solr Demo</title>
		<meta name="layout" content="main" />
    </head>
    <body style="width=800px;">
		<div id="pageBody" style="padding:10px 10px 10px 50px;">
	        <h1>Search Mike's iTunes Library</h1>
	        <g:form name="search" action="index" method="get">
	            <g:textField name="q" value="${q}"/> <g:submitButton name="search" value="search"/>
	            <g:hiddenField name="max" value="15"/>
	        </g:form>

	        <div id="results" style="width:500px; float:left; display:block; padding-right:20px;">
	            <g:each in="${result.resultList}" var="item">
	                <p style="padding: 5px 0 5px 0; border-bottom:1px dashed #DDDDDD;">
    	                <solr:resultLink result="${item}">${item.name}</solr:resultLink><br/>	                
    	                ${item.artist} ${item.year}  - ${item.genre}
	                </p>
	            </g:each>
	            <br/>
	            <span class="paging">
	                <g:paginate total="${result.total}" max="15" params="[q:q, fq:fq]"/>
	            </span>
	            <g:if test="${result.total == 0}">
	            No Results found
	            </g:if>
	        </div>
	        
	        <g:if test="${result.total}">
    	        <div style="width:250px; float: left; display:block;">
    	            
                    <solr:facet field="${Song.solrFieldName('genre')}" result="${result}" fq="${fq}" q="${q}" min="2">
                        <h3>Filter by Genre</h3>
                    </solr:facet>
                    <solr:facet field="${Song.solrFieldName('artist')}" result="${result}" fq="${fq}"  q="${q}" min="2">
                        <h3>Filter by Artist</h3>
                    </solr:facet>
                    <solr:facet field="${Song.solrFieldName('year')}" result="${result}" fq="${fq}" q="${q}" min="2">
                        <h3>Filter by Year</h3>
                    </solr:facet>
                    <solr:facet field="${Song.solrFieldName('name')}" result="${result}" fq="${fq}" q="${q}" min="2">
                        <h3>Filter by Name</h3>
                    </solr:facet>
        	        </div>

        	        <div style="float:left; background-color:#eeeeee; padding: 10px;">
        	            <h3>Raw Solr URL Parameters</h3>
        	            <g:each in="${solrQueryUrl.split('&')}">
        	                ${it.decodeURL()}<br/>
        	            </g:each>
        	        </div>
            </g:if>
		</div>
    </body>
    <%-- SAVED
    <g:each in="${fq}" var="item">
        <g:if test="${item.contains(Song.solrFieldName('year'))}">
        <g:link  action="index" params="[q:q, fq: (fq - [item] )]" style="color:red; font-size:14px">X</g:link> 
        ${item.split(":")[1]}<br/>
        </g:if>
    </g:each>       	            
    <g:each in="${result.facet(Song,'year').values}" var="item">
        <g:if test="${!fq.contains(item.asFilterQuery) && item.count > 0}">
            <ul>
                <li><g:link action="index" params="[q:q, fq: (fq.size() ? ([item.asFilterQuery] + fq) : [item.asFilterQuery])]">${item}</g:link></li>
            </ul>
        </g:if>
    </g:each>
    --%>
</html>

