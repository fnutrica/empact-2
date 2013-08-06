<g:if test="${suggestedUserInstanceTotal}">
    <g:each in="${suggestedUserInstanceList}" var="suggestedUserInstance">
        <div class='student-preview active round8' data-user-name="${suggestedUserInstance.user.toString()}" data-user-id="${suggestedUserInstance.userId}">
            <div class='preview-header'>
                <span class='icons'>
                    <a href='#' rel='tooltip' data-original-title='Approve User' class='select'>
                        <i class='icon-ok'></i>
                    </a>
                    <a href='#' rel='tooltip' data-original-title='Remove User' class='remove'>
                        <i class='icon-remove'></i>
                    </a>
                    <a href='#' rel='tooltip' data-original-title='Download Resume' class='resume'>
                        <i class='icon-file'></i>
                    </a>
                </span>
                <span class='student-name'>${suggestedUserInstance.user.toString()}</span> &middot;
                <span class='student-institution'>${fieldValue(bean: suggestedUserInstance.user, field: "institution")}</span>
            </div>

            <div class='info-box languages round4'>
                <div class='box-header'>Languages</div>
                <ul class='unstyled'>
                    <g:if test="${suggestedUserInstance.user.languages.size() > 0}">
                        <g:each in="${suggestedUserInstance.user.languages}" status="i" var="lang">
                            <li>${lang}</li>
                        </g:each>
                    </g:if>
                    <g:else>
                        <li>No known languages</li>
                    </g:else>
                </ul>

            </div>

            <div class='info-box skills round4'>
                <div class='box-header'>Skills</div>
                <ul class='unstyled'>
                    <g:if test="${suggestedUserInstance.user.skills.size() > 0}">
                        <g:each in="${suggestedUserInstance.user.skills}" status="i" var="skill">
                            <li>${skill}</li>
                        </g:each>
                    </g:if>
                    <g:else>
                        <li>No known skills</li>
                    </g:else>
                </ul>
            </div>

            <div class='info-box interests round4'>
                <div class='box-header'>Interests</div>
                <ul class='unstyled'>
                    <g:if test="${suggestedUserInstance.user.interests.size() > 0}">
                        <g:each in="${suggestedUserInstance.user.interests}" status="i" var="interest">
                            <li>${interest}</li>
                        </g:each>
                    </g:if>
                    <g:else>
                        <li>No known interests</li>
                    </g:else>
                </ul>
            </div>
        </div>
    </g:each>
</g:if>
<g:else>
    <div class="no-suggestions-message">There are no suggestions for this project</div>
</g:else>

