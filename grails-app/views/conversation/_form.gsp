<%@ page import="empact.Conversation" %>



<div class="fieldcontain ${hasErrors(bean: conversationInstance, field: 'owner', 'error')} required">
	<label for="owner">
		<g:message code="conversation.owner.label" default="Owner" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="owner" name="owner.id" from="${empact.EndUser.list()}" optionKey="id" required="" value="${conversationInstance?.owner?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: conversationInstance, field: 'isRead', 'error')} ">
	<label for="isRead">
		<g:message code="conversation.isRead.label" default="Is Read" />
		
	</label>
	<g:checkBox name="isRead" value="${conversationInstance?.isRead}" />
</div>

<div class="fieldcontain ${hasErrors(bean: conversationInstance, field: 'recipient', 'error')} required">
	<label for="recipient">
		<g:message code="conversation.recipient.label" default="Recipient" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="recipient" name="recipient.id" from="${empact.EndUser.list()}" optionKey="id" required="" value="${conversationInstance?.recipient?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: conversationInstance, field: 'updated', 'error')} required">
	<label for="updated">
		<g:message code="conversation.updated.label" default="Updated" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="updated" precision="day"  value="${conversationInstance?.updated}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: conversationInstance, field: 'messages', 'error')} ">
	<label for="messages">
		<g:message code="conversation.messages.label" default="Messages" />
		
	</label>
	<g:select name="messages" from="${empact.Message.list()}" multiple="multiple" optionKey="id" size="5" value="${conversationInstance?.messages*.id}" class="many-to-many"/>
</div>

