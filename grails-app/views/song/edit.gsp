

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'song.label', default: 'Song')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${songInstance}">
            <div class="errors">
                <g:renderErrors bean="${songInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${songInstance?.id}" />
                <g:hiddenField name="version" value="${songInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="year"><g:message code="song.year.label" default="Year" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: songInstance, field: 'year', 'errors')}">
                                    <g:textField name="year" value="${songInstance?.year}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="genre"><g:message code="song.genre.label" default="Genre" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: songInstance, field: 'genre', 'errors')}">
                                    <g:textField name="genre" value="${songInstance?.genre}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="album"><g:message code="song.album.label" default="Album" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: songInstance, field: 'album', 'errors')}">
                                    <g:textField name="album" value="${songInstance?.album}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="song.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: songInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${songInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="artist"><g:message code="song.artist.label" default="Artist" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: songInstance, field: 'artist', 'errors')}">
                                    <g:textField name="artist" value="${songInstance?.artist}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>