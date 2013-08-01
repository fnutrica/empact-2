
<%@ page import="empact.DataItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'dataItem.label', default: 'DataItem')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-dataItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-dataItem" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list dataItem">
			
				<g:if test="${dataItemInstance?.dataType}">
				<li class="fieldcontain">
					<span id="dataType-label" class="property-label"><g:message code="dataItem.dataType.label" default="Data Type" /></span>
					
						<span class="property-value" aria-labelledby="dataType-label"><g:fieldValue bean="${dataItemInstance}" field="dataType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataItemInstance?.uploaded}">
				<li class="fieldcontain">
					<span id="uploaded-label" class="property-label"><g:message code="dataItem.uploaded.label" default="Uploaded" /></span>
					
						<span class="property-value" aria-labelledby="uploaded-label"><g:formatDate date="${dataItemInstance?.uploaded}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataItemInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="dataItem.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${dataItemInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataItemInstance?.file}">
				<li class="fieldcontain">
					<span id="file-label" class="property-label"><g:message code="dataItem.file.label" default="File" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataItemInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="dataItem.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${dataItemInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataItemInstance?.owner}">
				<li class="fieldcontain">
					<span id="owner-label" class="property-label"><g:message code="dataItem.owner.label" default="Owner" /></span>
					
						<span class="property-value" aria-labelledby="owner-label"><g:link controller="endUser" action="show" id="${dataItemInstance?.owner?.id}">${dataItemInstance?.owner?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${dataItemInstance?.project}">
				<li class="fieldcontain">
					<span id="project-label" class="property-label"><g:message code="dataItem.project.label" default="Project" /></span>
					
						<span class="property-value" aria-labelledby="project-label"><g:link controller="project" action="show" id="${dataItemInstance?.project?.id}">${dataItemInstance?.project?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${dataItemInstance?.id}" />
					<g:link class="edit" action="edit" id="${dataItemInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
