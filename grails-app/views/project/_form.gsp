<%@ page import="empact.Project" %>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="project.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${projectInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="project.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${projectInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'startDate', 'error')} required">
	<label for="startDate">
		<g:message code="project.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="startDate" precision="day"  value="${projectInstance?.startDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'conceptnote', 'error')} ">
	<label for="conceptnote">
		<g:message code="project.conceptnote.label" default="Conceptnote" />
		
	</label>
	<g:textField name="conceptnote" value="${projectInstance?.conceptnote}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'country', 'error')} ">
	<label for="country">
		<g:message code="project.country.label" default="Country" />
		
	</label>
	<g:textField name="country" value="${projectInstance?.country}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'analysts', 'error')} ">
	<label for="analysts">
		<g:message code="project.analysts.label" default="Analysts" />
		
	</label>
	<g:select name="analysts" from="${empact.EndUser.list()}" multiple="multiple" optionKey="id" size="5" value="${projectInstance?.analysts*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'mentors', 'error')} ">
	<label for="mentors">
		<g:message code="project.mentors.label" default="Mentors" />
		
	</label>
	<g:select name="mentors" from="${empact.EndUser.list()}" multiple="multiple" optionKey="id" size="5" value="${projectInstance?.mentors*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'owner', 'error')} required">
	<label for="owner">
		<g:message code="project.owner.label" default="Owner" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="owner" name="owner.id" from="${empact.EndUser.list()}" optionKey="id" required="" value="${projectInstance?.owner?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="project.status.label" default="Status" />
		
	</label>
	<g:select name="status" from="${projectInstance.constraints.status.inList}" value="${projectInstance?.status}" valueMessagePrefix="project.status" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'dataItems', 'error')} ">
	<label for="dataItems">
		<g:message code="project.dataItems.label" default="Data Items" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${projectInstance?.dataItems?}" var="d">
    <li><g:link controller="dataItem" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="dataItem" action="create" params="['project.id': projectInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'dataItem.label', default: 'DataItem')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'findings', 'error')} ">
	<label for="findings">
		<g:message code="project.findings.label" default="Findings" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${projectInstance?.findings?}" var="f">
    <li><g:link controller="finding" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="finding" action="create" params="['project.id': projectInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'finding.label', default: 'Finding')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'language', 'error')} ">
	<label for="language">
		<g:message code="project.language.label" default="Language" />
		
	</label>
	<g:textField name="language" value="${projectInstance?.language}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'notes', 'error')} ">
	<label for="notes">
		<g:message code="project.notes.label" default="Notes" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${projectInstance?.notes?}" var="n">
    <li><g:link controller="note" action="show" id="${n.id}">${n?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="note" action="create" params="['project.id': projectInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'note.label', default: 'Note')])}</g:link>
</li>
</ul>

</div>

