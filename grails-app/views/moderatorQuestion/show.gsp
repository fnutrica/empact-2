
<%@ page import="empact.ModeratorQuestion" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'moderatorQuestion.label', default: 'ModeratorQuestion')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-moderatorQuestion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-moderatorQuestion" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list moderatorQuestion">
			
				<g:if test="${moderatorQuestionInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="moderatorQuestion.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${moderatorQuestionInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${moderatorQuestionInstance?.email}">
				<li class="fieldcontain">
					<span id="email-label" class="property-label"><g:message code="moderatorQuestion.email.label" default="Email" /></span>
					
						<span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${moderatorQuestionInstance}" field="email"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${moderatorQuestionInstance?.question}">
				<li class="fieldcontain">
					<span id="question-label" class="property-label"><g:message code="moderatorQuestion.question.label" default="Question" /></span>
					
						<span class="property-value" aria-labelledby="question-label"><g:fieldValue bean="${moderatorQuestionInstance}" field="question"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${moderatorQuestionInstance?.response}">
				<li class="fieldcontain">
					<span id="response-label" class="property-label"><g:message code="moderatorQuestion.response.label" default="Response" /></span>
					
						<span class="property-value" aria-labelledby="response-label"><g:fieldValue bean="${moderatorQuestionInstance}" field="response"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${moderatorQuestionInstance?.endUser}">
				<li class="fieldcontain">
					<span id="endUser-label" class="property-label"><g:message code="moderatorQuestion.endUser.label" default="End User" /></span>
					
						<span class="property-value" aria-labelledby="endUser-label"><g:link controller="endUser" action="show" id="${moderatorQuestionInstance?.endUser?.id}">${moderatorQuestionInstance?.endUser?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${moderatorQuestionInstance?.id}" />
					<g:link class="edit" action="edit" id="${moderatorQuestionInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
