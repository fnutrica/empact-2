
<%@ page import="empact.ModeratorQuestion" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'moderatorQuestion.label', default: 'ModeratorQuestion')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-moderatorQuestion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-moderatorQuestion" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'moderatorQuestion.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="email" title="${message(code: 'moderatorQuestion.email.label', default: 'Email')}" />
					
						<g:sortableColumn property="question" title="${message(code: 'moderatorQuestion.question.label', default: 'Question')}" />
					
						<g:sortableColumn property="response" title="${message(code: 'moderatorQuestion.response.label', default: 'Response')}" />
					
						<th><g:message code="moderatorQuestion.endUser.label" default="End User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${moderatorQuestionInstanceList}" status="i" var="moderatorQuestionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${moderatorQuestionInstance.id}">${fieldValue(bean: moderatorQuestionInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: moderatorQuestionInstance, field: "email")}</td>
					
						<td>${fieldValue(bean: moderatorQuestionInstance, field: "question")}</td>
					
						<td>${fieldValue(bean: moderatorQuestionInstance, field: "response")}</td>
					
						<td>${fieldValue(bean: moderatorQuestionInstance, field: "endUser")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${moderatorQuestionInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
