<%@ page import="empact.ThreadResponse" %>



<div class="fieldcontain ${hasErrors(bean: threadResponseInstance, field: 'owner', 'error')} required">
	<label for="owner">
		<g:message code="threadResponse.owner.label" default="Owner" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="owner" name="owner.id" from="${empact.EndUser.list()}" optionKey="id" required="" value="${threadResponseInstance?.owner?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: threadResponseInstance, field: 'created', 'error')} required">
	<label for="created">
		<g:message code="threadResponse.created.label" default="Created" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="created" precision="day"  value="${threadResponseInstance?.created}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: threadResponseInstance, field: 'details', 'error')} required">
	<label for="details">
		<g:message code="threadResponse.details.label" default="Details" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="details" cols="40" rows="5" maxlength="5000" required="" value="${threadResponseInstance?.details}"/>
</div>

