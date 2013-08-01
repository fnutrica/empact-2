<%@ page import="empact.Thread" %>



%{--<div class="fieldcontain ${hasErrors(bean: threadInstance, field: 'threadOwner', 'error')} required">
    <label for="threadOwner">
        <g:message code="thread.threadOwner.label" default="Thread Owner" />
        <span class="required-indicator">*</span>
    </label>
    <g:select id="threadOwner" name="threadOwner.id" from="${empact.EndUser.list()}" optionKey="id" required="" value="${threadInstance?.threadOwner?.id}" class="many-to-one"/>
</div>


<div class="fieldcontain ${hasErrors(bean: threadInstance, field: 'created', 'error')} required">
    <label for="created">
        <g:message code="thread.created.label" default="Created" />
        <span class="required-indicator">*</span>
    </label>
    <g:datePicker name="created" precision="day"  value="${threadInstance?.created}"  />
</div>--}%


<div class="fieldcontain ${hasErrors(bean: threadInstance, field: 'title', 'error')} ">
    <label for="title">
        <g:message code="thread.title.label" default="Title" />

    </label>
    <g:textField name="title" value="${threadInstance?.title}"/>
</div>


<div class="fieldcontain ${hasErrors(bean: threadInstance, field: 'details', 'error')} required">
    <label for="details">
        <g:message code="thread.details.label" default="Details" />
        <span class="required-indicator">*</span>
    </label>
    <g:textArea name="details" size = "1000" required="" value="${threadInstance?.details}"/>
</div>


