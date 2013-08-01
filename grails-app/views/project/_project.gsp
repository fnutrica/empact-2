<%@ page import="empact.EndUser" %>
<g:set var="project"
       value="${(projectInstanceList != null && !projectInstanceList.isEmpty()) ? projectInstanceList.first() : projectInstance}"/>

<div class='project-heading round8-top'>${fieldValue(bean: project, field: "name")}</div>

<div class="project-body">
<ul class='nav nav-tabs' data-tabs='tabs'>
    <li class='active'><a href="#details" data-toggle='tab'>Project</a></li>
    <li><a href="#data" data-toggle="tab">Data</a></li>
    <li><a href="#notes" data-toggle='tab'>Notes</a></li>
    <li><a href="#findings" data-toggle='tab'>Findings</a></li>
    <g:if test="${userType?.equals("Expert") || userType?.equals("Student Analyst")}">
        <li><a href="#private" data-toggle='tab'>Private Files</a></li>
    </g:if>
</ul>


<div class="tab-content">
<!-- DETAILS TAB -->
<div class="tab-pane active" id="details">
    <h3 class='inline header-text'>${fieldValue(bean: project, field: "name")}</h3>

    <g:if test="${userType?.equals("Moderator") || userType?.equals("WHO Official") || userType?.equals("Country Official") || userType?.equals("Superuser")}">
        <a href="#" class='edit-project btn btn-primary inline'>
            Edit Project
        </a>
    </g:if>

    <div class="row">
        <ul class="unstyled">
            <li class="property">
                <div class="inline property-label">Owner:</div>

                <div class="inline property-value">${fieldValue(bean: project, field: "owner")}</div>
            </li>
            <li class="property">
                <div class="inline property-label">Country:</div>

                <div data-property-name='country' data-property-value="${project?.country.id}"
                     class="inline property-value inline-edit">
                    ${project?.country?.name}
                </div>
            </li>
            <li class="property">
                <div class="inline property-label">Language:</div>

                <div data-property-name='language' data-property-value="${project?.language?.name}"
                     class="inline property-value inline-edit">
                    ${project?.language?.name}
                </div>
            </li>
            <li class="property">
                <div class="inline property-label">Analysts:</div>

                <div class="inline property-value link-to-edit">
                    <ul class="unstyled">
                        <g:each in="${project?.analysts}" status="j" var="analyst">
                            <li><g:link controller="endUser" action="show"
                                        id="${analyst.id}">${analyst.toString()}</g:link></li>
                        </g:each>
                    </ul>
                </div>
            </li>
            <li class="property">
                <div class="inline property-label">Mentors:</div>

                <div class="inline property-value">
                    <ul class="unstyled">
                        <g:each in="${project?.mentors}" status="j" var="mentor">
                            <g:link controller="endUser" action="show"
                                    id="${mentor.id}">${mentor.toString()}</g:link>
                        </g:each>
                    </ul>
                </div>
            </li>
            <li class="property">
                <div class="inline property-label">Description:</div>

                <div data-property-name='description' data-property-value="${project?.description}"
                     class="inline property-value inline-edit">${fieldValue(bean: project, field: "description")}</div>
            </li>
        </ul>
    </div>
</div>

<!-- DATA TAB -->
<div class="tab-pane" id="data">
    <h3 class='inline header-text'>${fieldValue(bean: project, field: "name")} &middot; Data</h3>
    <g:if test="${userType?.equals("Expert") || userType?.equals("Student Analyst")}">
        <a href="#requestData" role='button' class='btn btn-primary inline request-data'
           data-toggle='modal'>Request Data</a>
    </g:if>
    <g:elseif
            test="${userType?.equals("Country Official") || userType?.equals("WHO Official") || userType?.equals("Moderator") || userType?.equals("Superuser")}">
        <g:link controller="dataItem" action="create" params="['project.id': projectInstance?.id]" class="btn btn-primary">Add Data</g:link>
    </g:elseif>

    <table class="table table-bordered table-striped">
        <colgroup>
            <col class="span2">
            <col class="span2">
        </colgroup>
        <tbody>
        <g:each in="${project?.dataItems}" status="j" var="dataitem">
            <tr>
                <td>${fieldValue(bean: dataitem, field: "name")}</td>       %{--Make this a download link--}%
                <td>
                    <a href="#" rel='tooltip' data-original-title='Preview'
                       data-toggle="modal" class="btn btn-link">
                        <i class="icon-zoom-in"></i>
                    </a>
                    <g:link controller="dataItem" id="${dataitem.id}" action="download" rel='tooltip'
                            data-original-title='Download' class="btn btn-link">
                        <i class="icon-download-alt"></i>
                    </g:link>
                    <a href="#" rel='tooltip' data-original-title='Delete'
                       class="btn btn-link"
                       data-forbidden-users='analyst expert advisor'>
                        <i class="icon-trash"></i>
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<!-- NOTES TAB -->
<div class="tab-pane" id="notes">
    <h3 class='inline header-text'>${fieldValue(bean: project, field: "name")} &middot; Notes</h3>
    <g:link controller="note" action="create" params="['project.id': projectInstance?.id]" class="btn btn-primary inline">Add Notes</g:link>

    <table class="table table-bordered table-striped">
        <colgroup>
            <col class="span2">
            <col class="span2">
        </colgroup>
        <tbody>
        <g:each in="${project?.notes}" status="j" var="notesItem">
            <tr>
                <td>${fieldValue(bean: notesItem, field: "name")}</td>       %{--Make this a download link--}%
                <td>
                    <a href="#" rel='tooltip' data-original-title='Preview'
                       data-toggle="modal" class="btn btn-link">
                        <i class="icon-zoom-in"></i>
                    </a>
                    <a href="#" rel='tooltip' data-original-title='Download'
                       class="btn btn-link">
                        <i class="icon-download-alt"></i>
                    </a>
                    <a href="#" rel='tooltip' data-original-title='Delete'
                       class="btn btn-link">
                        <i class="icon-trash"></i>
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<!-- FINDINGS TAB -->
<div class="tab-pane" id="findings">
    <h3 class='inline header-text'>${fieldValue(bean: project, field: "name")} &middot; Findings</h3>
    <g:link controller="finding" action="create" params="['project.id': projectInstance?.id]" class="btn btn-primary">Add Findings</g:link>

    <table class="table table-bordered table-striped">
        <colgroup>
            <col class="span2">
            <col class="span2">
        </colgroup>
        <tbody>
        <g:each in="${project?.findings}" status="j" var="finding">
            <tr>
                <td>${fieldValue(bean: finding, field: "name")}</td>       %{--Make this a download link--}%
                <td>
                    <a href="#" rel='tooltip' data-original-title='Preview'
                       data-toggle="modal" class="btn btn-link">
                        <i class="icon-zoom-in"></i>
                    </a>
                    <a href="#" rel='tooltip' data-original-title='Download'
                       class="btn btn-link">
                        <i class="icon-download-alt"></i>
                    </a>
                    <a href="#" rel='tooltip' data-original-title='Make Findings Public'
                       class="btn btn-link" id="publish">
                        <i class="icon-globe"></i>
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<g:if test="${userType?.equals("Expert") || userType?.equals("Student Analyst")}">
    <!-- PRIVATE FILES TAB -->
    <div class="tab-pane" id="private">
        <h3 class='header-text'>${fieldValue(bean: project, field: "name")} &middot; Private Files</h3>

        <table class="table table-bordered table-striped">
            <colgroup>
                <col class="span2">
                <col class="span2">
            </colgroup>
            <tbody>
            <g:each in="${project?.notes}" status="j" var="notesItem">
                <g:if test="${notesItem.visible}">
                    <tr>
                        <td>${fieldValue(bean: notesItem, field: "name")}</td>       %{--Make this a download link--}%
                        <td>
                            <a href="#" rel='tooltip' data-original-title='Preview'
                               data-toggle="modal" class="btn btn-link">
                                <i class="icon-zoom-in"></i>
                            </a>
                            <a href="#" rel='tooltip' data-original-title='Download'
                               class="btn btn-link">
                                <i class="icon-download-alt"></i>
                            </a>
                            <a href="#" rel='tooltip' data-original-title='Make Findings Public'
                               class="btn btn-link" data-forbidden-users='analyst expert advisor admin'>
                                <i class="icon-globe"></i>
                            </a>
                        </td>
                    </tr>
                </g:if>
            </g:each>
            </tbody>
        </table>
    </div>
</g:if>
</div>
</div>
