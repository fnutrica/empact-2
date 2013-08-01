<%@ page import="empact.SuggestedUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'suggestedUser.label', default: 'SuggestedUser')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-suggestedUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                    default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="list-suggestedUser" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <th><g:message code="suggestedUser.user.label" default="User"/></th>

            <g:sortableColumn property="approved"
                              title="${message(code: 'suggestedUser.approved.label', default: 'Approved')}"/>

            <th><g:message code="suggestedUser.project.label" default="Project"/></th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${suggestedUserInstanceList}" status="i" var="suggestedUserInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${suggestedUserInstance.id}">${fieldValue(bean: suggestedUserInstance, field: "user")}</g:link></td>

                <td><g:formatBoolean boolean="${suggestedUserInstance.approved}"/></td>

                <td>${fieldValue(bean: suggestedUserInstance, field: "project")}</td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${suggestedUserInstanceTotal}"/>
    </div>
</div>
</body>
</html>
