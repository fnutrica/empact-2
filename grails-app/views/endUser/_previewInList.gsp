<div class='info-box languages round4'>
    <div class='box-header'>Languages</div>
    <ul class='unstyled'>
        <g:if test="${endUserInstance.languages.size() > 0}">
            <g:each in="${endUserInstance.languages}" status="i" var="lang">
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
        <g:if test="${endUserInstance.skills.size() > 0}">
            <g:each in="${endUserInstance.skills}" status="i" var="skill">
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
        <g:if test="${endUserInstance.interests.size() > 0}">
            <g:each in="${endUserInstance.interests}" status="i" var="interest">
                <li>${interest}</li>
            </g:each>
        </g:if>
        <g:else>
            <li>No known interests</li>
        </g:else>
    </ul>
</div>