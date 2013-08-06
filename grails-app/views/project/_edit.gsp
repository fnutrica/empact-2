<li class="property">
    <div class="inline property-label">Owner:</div>

    <div class="inline property-value">${fieldValue(bean: projectInstance, field: "owner")}</div>
</li>
<li class="property">
    <div class="inline property-label">Country:</div>

    <div class="inline property-value">
        <select id='country' name="country.id" class="bfh-countries inline-select" size="10">
            <g:each in="${empact.Country.list(sort: "name", order: "asc")}" var="countryInstance">
                <g:if test="${projectInstance?.countryId == countryInstance.id}">
                    <option value="${countryInstance.id}" selected="selected">${countryInstance.name}</option>
                </g:if>
                <g:else>
                    <option value="${countryInstance.id}">${countryInstance.name}</option>
                </g:else>
            </g:each>
        </select>
    </div>
</li>
<li class="property">
    <div class="inline property-label">Language:</div>

    <div class="inline property-value">
        <select id="language" name='language.id' multiple="multiple" size="6" class="inline-select">
            <g:each in="${empact.Language.list(sort: "name", order: "asc")}" var="languageInstance">
                <g:if test="${languageInstance.id == projectInstance?.languageId}">
                    <option value="${languageInstance.id}" selected="selected">${languageInstance.name}</option>
                </g:if>
                <g:else>
                    <option value="${languageInstance.id}">${languageInstance.name}</option>
                </g:else>
            </g:each>
        </select>
    </div>
</li>
<li class="property">
    <div class="inline property-label">Analysts:</div>

    <div class="inline property-value">
        <ul class="unstyled">
            <g:each in="${projectInstance?.analysts}" status="j" var="analyst">
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
            <g:each in="${projectInstance?.mentors}" status="j" var="mentor">
                <g:link controller="endUser" action="show"
                        id="${mentor.id}">${mentor.toString()}</g:link>
            </g:each>
        </ul>
    </div>
</li>
<li class="property">
    <div class="inline property-label">Description:</div>

    <div class="inline property-value">
        <textarea class="inline-text" name="description">${fieldValue(bean: projectInstance, field: "description")}</textarea>
    </div>
</li>