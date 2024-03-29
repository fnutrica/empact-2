<%@ page import="empact.SuggestedUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'suggestedUser.label', default: 'SuggestedUser')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-suggestedUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                    default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-suggestedUser" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list suggestedUser">

        <g:if test="${suggestedUserInstance?.user}">
            <li class="fieldcontain">
                <span id="user-label" class="property-label"><g:message code="suggestedUser.user.label"
                                                                        default="User"/></span>

                <span class="property-value" aria-labelledby="user-label"><g:link controller="endUser" action="show"
                                                                                  id="${suggestedUserInstance?.user?.id}">${suggestedUserInstance?.user?.encodeAsHTML()}</g:link></span>

            </li>
        </g:if>

        <g:if test="${suggestedUserInstance?.approved}">
            <li class="fieldcontain">
                <span id="approved-label" class="property-label"><g:message code="suggestedUser.approved.label"
                                                                            default="Approved"/></span>

                <span class="property-value" aria-labelledby="approved-label"><g:formatBoolean
                        boolean="${suggestedUserInstance?.approved}"/></span>

            </li>
        </g:if>

        <g:if test="${suggestedUserInstance?.project}">
            <li class="fieldcontain">
                <span id="project-label" class="property-label"><g:message code="suggestedUser.project.label"
                                                                           default="Project"/></span>

                <span class="property-value" aria-labelledby="project-label"><g:link controller="project" action="show"
                                                                                     id="${suggestedUserInstance?.project?.id}">${suggestedUserInstance?.project?.encodeAsHTML()}</g:link></span>

            </li>
        </g:if>

    </ol>
    <g:form>
        <fieldset class="buttons">
            <g:hiddenField name="id" value="${suggestedUserInstance?.id}"/>
            <g:link class="edit" action="edit" id="${suggestedUserInstance?.id}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="delete" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
