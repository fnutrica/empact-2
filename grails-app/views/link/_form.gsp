<%@ page import="empact.Link" %>



<div class="fieldcontain ${hasErrors(bean: linkInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="link.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${linkInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: linkInstance, field: 'link', 'error')} required">
	<label for="link">
		<g:message code="link.link.label" default="Link" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="link" required="" value="${linkInstance?.link}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: linkInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="link.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${linkInstance?.description}"/>
</div>

