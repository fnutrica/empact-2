
<%@ page import="empact.ProjectRequest" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'projectRequest.label', default: 'ProjectRequest')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-projectRequest" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-projectRequest" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="projectRequest.owner.label" default="Owner" /></th>
					
						<g:sortableColumn property="sent" title="${message(code: 'projectRequest.sent.label', default: 'Sent')}" />
					
						<g:sortableColumn property="approved" title="${message(code: 'projectRequest.approved.label', default: 'Approved')}" />
					
						<g:sortableColumn property="details" title="${message(code: 'projectRequest.details.label', default: 'Details')}" />
					
						<th><g:message code="projectRequest.project.label" default="Project" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${projectRequestInstanceList}" status="i" var="projectRequestInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${projectRequestInstance.id}">${fieldValue(bean: projectRequestInstance, field: "owner")}</g:link></td>
					
						<td><g:formatDate date="${projectRequestInstance.sent}" /></td>
					
						<td><g:formatBoolean boolean="${projectRequestInstance.approved}" /></td>
					
						<td>${fieldValue(bean: projectRequestInstance, field: "details")}</td>
					
						<td>${fieldValue(bean: projectRequestInstance, field: "project")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${projectRequestInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
