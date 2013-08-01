<%@ page import="empact.ConceptNote" %>



<div class="fieldcontain ${hasErrors(bean: conceptNoteInstance, field: 'shortTitle', 'error')} required">
	<label for="shortTitle">
		<g:message code="conceptNote.shortTitle.label" default="Short Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="shortTitle" required="" value="${conceptNoteInstance?.shortTitle}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: conceptNoteInstance, field: 'fullTitle', 'error')} required">
	<label for="fullTitle">
		<g:message code="conceptNote.fullTitle.label" default="Full Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fullTitle" required="" value="${conceptNoteInstance?.fullTitle}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: conceptNoteInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="conceptNote.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="5000" required="" value="${conceptNoteInstance?.description}"/>
</div>

