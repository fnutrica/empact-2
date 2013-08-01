<%@ page import="empact.Message" %>



<div class="fieldcontain ${hasErrors(bean: messageInstance, field: 'owner', 'error')} required">
	<label for="owner">
		<g:message code="message.owner.label" default="Owner" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="owner" name="owner.id" from="${empact.EndUser.list()}" optionKey="id" required="" value="${messageInstance?.owner?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: messageInstance, field: 'recipients', 'error')} ">
	<label for="recipients">
		<g:message code="message.recipients.label" default="Recipients" />
		
	</label>
	<g:select name="recipients" from="${empact.EndUser.list()}" multiple="multiple" optionKey="id" size="5" value="${messageInstance?.recipients*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: messageInstance, field: 'subject', 'error')} required">
	<label for="subject">
		<g:message code="message.subject.label" default="Subject" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="subject" required="" value="${messageInstance?.subject}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: messageInstance, field: 'sent', 'error')} ">
	<label for="sent">
		<g:message code="message.sent.label" default="Sent" />
		
	</label>
	<g:datePicker name="sent" precision="day"  value="${messageInstance?.sent}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: messageInstance, field: 'details', 'error')} required">
	<label for="details">
		<g:message code="message.details.label" default="Details" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="details" cols="40" rows="5" maxlength="5000" required="" value="${messageInstance?.details}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: messageInstance, field: 'responses', 'error')} ">
	<label for="responses">
		<g:message code="message.responses.label" default="Responses" />
		
	</label>
	<g:select name="responses" from="${empact.MessageResponse.list()}" multiple="multiple" optionKey="id" size="5" value="${messageInstance?.responses*.id}" class="many-to-many"/>
</div>

