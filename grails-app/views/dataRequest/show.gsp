
<%@ page import="empact.DataRequest" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'dataRequest.label', default: 'DataRequest')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-dataRequest" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-dataRequest" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list dataRequest">
			
				<g:if test="${dataRequestInstance?.sent}">
				<li class="fieldcontain">
					<span id="sent-label" class="property-label"><g:message code="dataRequest.sent.label" default="Sent" /></span>
					
						<span class="property-value" aria-labelledby="sent-label"><g:formatDate date="${dataRequestInstance?.sent}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataRequestInstance?.approved}">
				<li class="fieldcontain">
					<span id="approved-label" class="property-label"><g:message code="dataRequest.approved.label" default="Approved" /></span>
					
						<span class="property-value" aria-labelledby="approved-label"><g:formatBoolean boolean="${dataRequestInstance?.approved}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataRequestInstance?.reason}">
				<li class="fieldcontain">
					<span id="reason-label" class="property-label"><g:message code="dataRequest.reason.label" default="Reason" /></span>
					
						<span class="property-value" aria-labelledby="reason-label"><g:fieldValue bean="${dataRequestInstance}" field="reason"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataRequestInstance?.recipient}">
				<li class="fieldcontain">
					<span id="recipient-label" class="property-label"><g:message code="dataRequest.recipient.label" default="Recipient" /></span>
					
						<span class="property-value" aria-labelledby="recipient-label"><g:link controller="endUser" action="show" id="${dataRequestInstance?.recipient?.id}">${dataRequestInstance?.recipient?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataRequestInstance?.requestor}">
				<li class="fieldcontain">
					<span id="requestor-label" class="property-label"><g:message code="dataRequest.requestor.label" default="Requestor" /></span>
					
						<span class="property-value" aria-labelledby="requestor-label"><g:link controller="endUser" action="show" id="${dataRequestInstance?.requestor?.id}">${dataRequestInstance?.requestor?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${dataRequestInstance?.id}" />
					<g:link class="edit" action="edit" id="${dataRequestInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
