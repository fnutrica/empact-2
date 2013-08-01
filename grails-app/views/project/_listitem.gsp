<%@ page import="empact.Project" %>

<g:each in="${projectInstanceList}" status="i" var="projectInstance">
    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" data-project-id="${projectInstance.id}">

        <td>${fieldValue(bean: projectInstance, field: "name")}</td>

        <td>${fieldValue(bean: projectInstance.conceptnote, field: "shortTitle")}</td>

        <td>${fieldValue(bean: projectInstance, field: "country")}</td>

        <td>${fieldValue(bean: projectInstance, field: "status")}</td>

        <g:if test="${i == 0}">
            <td rowspan='3' id="project-preview" class='preview {sorter: false}'>
                <div id="preview-description">${fieldValue(bean: projectInstance, field: "description")}</div>
                <g:if test="${session.user}">
                    <g:link action="show" id="${projectInstance.id}">View Project</g:link>
                </g:if>
                <g:else>
                    <a href="#interested-modal" data-toggle="modal" class="btn btn-primary btn-mini">I Am Interested</a>
                </g:else>
            </td>
        </g:if>

    </tr>
</g:each>

