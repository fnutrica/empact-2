
<%@ page import="empact.Conversation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'conversation.label', default: 'Conversation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-conversation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-conversation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="conversation.owner.label" default="Owner" /></th>
					
						<g:sortableColumn property="isRead" title="${message(code: 'conversation.isRead.label', default: 'Is Read')}" />
					
						<th><g:message code="conversation.recipient.label" default="Recipient" /></th>
					
						<g:sortableColumn property="updated" title="${message(code: 'conversation.updated.label', default: 'Updated')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${conversationInstanceList}" status="i" var="conversationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${conversationInstance.id}">${fieldValue(bean: conversationInstance, field: "owner")}</g:link></td>
					
						<td><g:formatBoolean boolean="${conversationInstance.isRead}" /></td>
					
						<td>${fieldValue(bean: conversationInstance, field: "recipient")}</td>
					
						<td><g:formatDate date="${conversationInstance.updated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${conversationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
