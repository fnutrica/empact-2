<%@ page import="empact.SuggestedUser" %>



<div class="fieldcontain ${hasErrors(bean: suggestedUserInstance, field: 'user', 'error')} required">
    <label for="user">
        <g:message code="suggestedUser.user.label" default="User"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="user" name="user.id" from="${empact.EndUser.list()}" optionKey="id" required=""
              value="${suggestedUserInstance?.user?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: suggestedUserInstance, field: 'approved', 'error')} ">
    <label for="approved">
        <g:message code="suggestedUser.approved.label" default="Approved"/>

    </label>
    <g:checkBox name="approved" value="${suggestedUserInstance?.approved}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: suggestedUserInstance, field: 'project', 'error')} required">
    <label for="project">
        <g:message code="suggestedUser.project.label" default="Project"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="project" name="project.id" from="${empact.Project.list()}" optionKey="id" required=""
              value="${suggestedUserInstance?.project?.id}" class="many-to-one"/>
</div>

