<%@ page import="empact.DataItem" %>



<div class="fieldcontain ${hasErrors(bean: dataItemInstance, field: 'dataType', 'error')} ">
	<label for="dataType">
		<g:message code="dataItem.dataType.label" default="Data Type" />
		
	</label>
	<g:textField name="dataType" value="${dataItemInstance?.dataType}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dataItemInstance, field: 'uploaded', 'error')} required">
	<label for="uploaded">
		<g:message code="dataItem.uploaded.label" default="Uploaded" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="uploaded" precision="day"  value="${dataItemInstance?.uploaded}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: dataItemInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="dataItem.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="5000" required="" value="${dataItemInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dataItemInstance, field: 'file', 'error')} ">
	<label for="file">
		<g:message code="dataItem.file.label" default="File" />
		
	</label>
	<input type="file" id="file" name="file" />
</div>

<div class="fieldcontain ${hasErrors(bean: dataItemInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="dataItem.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${dataItemInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dataItemInstance, field: 'owner', 'error')} required">
	<label for="owner">
		<g:message code="dataItem.owner.label" default="Owner" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="owner" name="owner.id" from="${empact.EndUser.list()}" optionKey="id" required="" value="${dataItemInstance?.owner?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dataItemInstance, field: 'project', 'error')} required">
	<label for="project">
		<g:message code="dataItem.project.label" default="Project" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="project" name="project.id" from="${empact.Project.list()}" optionKey="id" required="" value="${dataItemInstance?.project?.id}" class="many-to-one"/>
</div>

