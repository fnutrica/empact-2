<%@ page import="empact.DataRequest" %>



<div class="fieldcontain ${hasErrors(bean: dataRequestInstance, field: 'sent', 'error')} required">
	<label for="sent">
		<g:message code="dataRequest.sent.label" default="Sent" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="sent" precision="day"  value="${dataRequestInstance?.sent}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: dataRequestInstance, field: 'approved', 'error')} ">
	<label for="approved">
		<g:message code="dataRequest.approved.label" default="Approved" />
		
	</label>
	<g:checkBox name="approved" value="${dataRequestInstance?.approved}" />
</div>

<div class="fieldcontain ${hasErrors(bean: dataRequestInstance, field: 'reason', 'error')} required">
	<label for="reason">
		<g:message code="dataRequest.reason.label" default="Reason" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="reason" cols="40" rows="5" maxlength="5000" required="" value="${dataRequestInstance?.reason}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dataRequestInstance, field: 'recipient', 'error')} required">
	<label for="recipient">
		<g:message code="dataRequest.recipient.label" default="Recipient" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="recipient" name="recipient.id" from="${empact.EndUser.list()}" optionKey="id" required="" value="${dataRequestInstance?.recipient?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dataRequestInstance, field: 'requestor', 'error')} required">
	<label for="requestor">
		<g:message code="dataRequest.requestor.label" default="Requestor" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="requestor" name="requestor.id" from="${empact.EndUser.list()}" optionKey="id" required="" value="${dataRequestInstance?.requestor?.id}" class="many-to-one"/>
</div>

