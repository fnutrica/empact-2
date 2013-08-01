
<%@ page import="empact.DataItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'dataItem.label', default: 'DataItem')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-dataItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-dataItem" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="dataType" title="${message(code: 'dataItem.dataType.label', default: 'Data Type')}" />
					
						<g:sortableColumn property="uploaded" title="${message(code: 'dataItem.uploaded.label', default: 'Uploaded')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'dataItem.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="file" title="${message(code: 'dataItem.file.label', default: 'File')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'dataItem.name.label', default: 'Name')}" />
					
						<th><g:message code="dataItem.owner.label" default="Owner" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${dataItemInstanceList}" status="i" var="dataItemInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${dataItemInstance.id}">${fieldValue(bean: dataItemInstance, field: "dataType")}</g:link></td>
					
						<td><g:formatDate date="${dataItemInstance.uploaded}" /></td>
					
						<td>${fieldValue(bean: dataItemInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: dataItemInstance, field: "file")}</td>
					
						<td>${fieldValue(bean: dataItemInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: dataItemInstance, field: "owner")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${dataItemInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
