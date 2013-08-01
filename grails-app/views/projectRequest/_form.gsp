<%@ page import="empact.ProjectRequest" %>



<div class="fieldcontain ${hasErrors(bean: projectRequestInstance, field: 'owner', 'error')} required">
	<label for="owner">
		<g:message code="projectRequest.owner.label" default="Owner" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="owner" name="owner.id" from="${empact.EndUser.list()}" optionKey="id" required="" value="${projectRequestInstance?.owner?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectRequestInstance, field: 'sent', 'error')} required">
	<label for="sent">
		<g:message code="projectRequest.sent.label" default="Sent" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="sent" precision="day"  value="${projectRequestInstance?.sent}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: projectRequestInstance, field: 'approved', 'error')} ">
	<label for="approved">
		<g:message code="projectRequest.approved.label" default="Approved" />
		
	</label>
	<g:checkBox name="approved" value="${projectRequestInstance?.approved}" />
</div>

<div class="fieldcontain ${hasErrors(bean: projectRequestInstance, field: 'details', 'error')} required">
	<label for="details">
		<g:message code="projectRequest.details.label" default="Details" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="details" cols="40" rows="5" maxlength="5000" required="" value="${projectRequestInstance?.details}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectRequestInstance, field: 'project', 'error')} required">
	<label for="project">
		<g:message code="projectRequest.project.label" default="Project" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="project" name="project.id" from="${empact.Project.list()}" optionKey="id" required="" value="${projectRequestInstance?.project?.id}" class="many-to-one"/>
</div>

