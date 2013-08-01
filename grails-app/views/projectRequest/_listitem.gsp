<g:if test="${type.equals('users')}">
    <ul id='users' class='unstyled small'>
        <g:each in="${endUserInstanceList}" status="i" var="endUserInstance">
            <li id="user-${i + 1}" data-user-id="${endUserInstance.id}" class='user'>
                <div class='category name inline'>${endUserInstance.toString()}</div>
                <div class='viewed inline'></div>
            </li>
        </g:each>
    </ul>
</g:if>
<g:elseif test="${type.equals('projects')}">
    <ul id='project-list' class='unstyled small'>
        <g:each in="${projectInstanceList}" var="projectInstance">
            <li data-project-id="${fieldValue(bean: projectInstance, field: 'id')}"
                class='project'>${fieldValue(bean: projectInstance, field: "name")}</li>
        </g:each>
    </ul>
</g:elseif>
