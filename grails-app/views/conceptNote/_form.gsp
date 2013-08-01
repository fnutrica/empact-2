<%@ page import="empact.ConceptNote" %>



<div class="fieldcontain ${hasErrors(bean: conceptNoteInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="conceptNote.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${conceptNoteInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: conceptNoteInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="conceptNote.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="5000" required="" value="${conceptNoteInstance?.description}"/>
</div>

