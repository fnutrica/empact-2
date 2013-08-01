<div class="preview-header">${endUserInstance.toString()} <a href="#" class="remove pull-right no-deco"><i class="icon-remove"></i> Close</a> <a class="approve pull-right no-deco" href="#"><i class="icon-ok"></i> Approve</a></div>
<ul class="unstyled">
    <li class="property">
        <div class="inline property-label">UserType:</div>

        <div class="inline property-value">${endUserInstance.userType.toString()}</div>
    </li>
    <li class="property">
        <div class="inline property-label">Email:</div>

        <div class="inline property-value">${endUserInstance.email}</div>
    </li>
    <g:if test="${userType.equals("student-analyst") || userType.equals("mentor")}">
        <li class="property">
            <div class="inline property-label">Institution:</div>

            <div class="inline property-value">${endUserInstance.institution}</div>
        </li>
    </g:if>
    <li class="property">
        <div class="inline property-label">Country:</div>

        <div class="inline property-value">${endUserInstance.country}</div>
    </li>
    <g:if test="${userType.equals("student-analyst") || userType.equals("expert") || userType.equals("mentor")}">
        <g:if test="${endUserInstance.languages}">
            <li class="property">
                <div class="inline property-label">Languages:</div>

                <div class="inline property-value">
                    <ul class="unstyled">
                        <g:each in="${endUserInstance.languages}" var="language">
                            <li>${language}</li>
                        </g:each>
                    </ul>
                </div>
            </li>
        </g:if>
        <g:if test="${endUserInstance.skills}">
            <li class="property">
                <div class="inline property-label">Skills:</div>

                <div class="inline property-value">
                    <ul class="unstyled">
                        <g:each in="${endUserInstance.skills}" var="skill">
                            <li>${skill}</li>
                        </g:each>
                    </ul>
                </div>
            </li>
        </g:if>
        <g:if test="${endUserInstance.interests}">
            <li class="property">
                <div class="inline property-label">Interests:</div>

                <div class="inline property-value">
                    <ul class="unstyled">
                        <g:each in="${endUserInstance.interests}" var="interest">
                            <li>${interest}</li>
                        </g:each>
                    </ul>
                </div>
            </li>
        </g:if>
    </g:if>
    <g:elseif test="${userType.equals("who-official")}">
        <li class="property">
            <div class="inline property-label">WHO Office:</div>

            <div class="inline property-value">${endUserInstance.whoOffice.toString()}</div>
        </li>
    </g:elseif>
</ul>
<g:if test="${userType.equals("student-analyst") && hasMentor}">
    <div id="mentor-preview" class="preview-header" data-mentor-id="${mentorInstance.id}">Possible Mentor &middot; ${mentorInstance.toString()}</div>
    <ul class="unstyled">
        <li class="property">
            <div class="inline property-label">UserType:</div>

            <div class="inline property-value">${mentorInstance.userType.toString()}</div>
        </li>
        <li class="property">
            <div class="inline property-label">Email:</div>

            <div class="inline property-value">${mentorInstance.email}</div>
        </li>
        <li class="property">
            <div class="inline property-label">Institution:</div>

            <div class="inline property-value">${mentorInstance.institution}</div>
        </li>
        <li class="property">
            <div class="inline property-label">Country:</div>

            <div class="inline property-value">${mentorInstance.country}</div>
        </li>
        <g:if test="${mentorInstance.languages}">
            <li class="property">
                <div class="inline property-label">Languages:</div>

                <div class="inline property-value">
                    <ul class="unstyled">
                        <g:each in="${mentorInstance.languages}" var="language">
                            <li>${language}</li>
                        </g:each>
                    </ul>
                </div>
            </li>
        </g:if>
    </ul>
</g:if>
