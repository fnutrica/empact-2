
<%@ page import="empact.Message" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'message.label', default: 'Message')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-message" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-message" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list message">
			
				<g:if test="${messageInstance?.recipients}">
				<li class="fieldcontain">
					<span id="recipients-label" class="property-label"><g:message code="message.recipients.label" default="Recipients" /></span>
					
						<g:each in="${messageInstance.recipients}" var="r">
						<span class="property-value" aria-labelledby="recipients-label"><g:link controller="endUser" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${messageInstance?.sent}">
				<li class="fieldcontain">
					<span id="sent-label" class="property-label"><g:message code="message.sent.label" default="Sent" /></span>
					
						<span class="property-value" aria-labelledby="sent-label"><g:formatDate date="${messageInstance?.sent}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${messageInstance?.details}">
				<li class="fieldcontain">
					<span id="details-label" class="property-label"><g:message code="message.details.label" default="Details" /></span>
					
						<span class="property-value" aria-labelledby="details-label"><g:fieldValue bean="${messageInstance}" field="details"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${messageInstance?.owner}">
				<li class="fieldcontain">
					<span id="owner-label" class="property-label"><g:message code="message.owner.label" default="Owner" /></span>
					
						<span class="property-value" aria-labelledby="owner-label"><g:link controller="endUser" action="show" id="${messageInstance?.owner?.id}">${messageInstance?.owner?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${messageInstance?.responses}">
				<li class="fieldcontain">
					<span id="responses-label" class="property-label"><g:message code="message.responses.label" default="Responses" /></span>
					
						<g:each in="${messageInstance.responses}" var="r">
						<span class="property-value" aria-labelledby="responses-label"><g:link controller="messageResponse" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${messageInstance?.id}" />
					<g:link class="edit" action="edit" id="${messageInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
