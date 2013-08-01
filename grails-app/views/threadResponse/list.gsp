
<%@ page import="empact.ThreadResponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'threadResponse.label', default: 'ThreadResponse')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-threadResponse" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-threadResponse" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="threadResponse.owner.label" default="Owner" /></th>
					
						<g:sortableColumn property="created" title="${message(code: 'threadResponse.created.label', default: 'Created')}" />
					
						<g:sortableColumn property="details" title="${message(code: 'threadResponse.details.label', default: 'Details')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${threadResponseInstanceList}" status="i" var="threadResponseInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${threadResponseInstance.id}">${fieldValue(bean: threadResponseInstance, field: "owner")}</g:link></td>
					
						<td><g:formatDate date="${threadResponseInstance.created}" /></td>
					
						<td>${fieldValue(bean: threadResponseInstance, field: "details")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${threadResponseInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
