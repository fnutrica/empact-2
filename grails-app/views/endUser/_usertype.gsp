<fieldset>
    <legend>Additional Information</legend>
    <g:if test="${type.equals('Student Analyst')}">
        <div class="control-group">
            <label class="control-label" for="skills">Skills<sup class='red'>*</sup></label>

            <div class="controls">
                <input type="text" id="skills" name="skills" class="required" placeholder="Skills">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="interests">Areas of Interest<sup class='red'>*</sup></label>

            <div class="controls">
                <input type="text" id="interests" name="interests" class="required" placeholder="Areas of Interest">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="language">Languages<sup class='red'>*</sup></label>

            <div class="controls">
                <select id="language" name='language.id' multiple="multiple" size="6">
                    <g:each in="${empact.Language.list().sort { a, b -> a.name.compareTo(b.name) }}"
                            var="languageInstance">
                        <option value="${languageInstance.id}">${languageInstance.name}</option>
                    </g:each>
                </select>
            </div>
        </div>

        <div data-visible-to="analyst advisor" class="control-group hidden">
            <label class="control-label" for="institution">Institution<sup class='red'>*</sup></label>

            <div class="controls">
                <input type="text" id="institution" name="institution" class="required" placeholder="Institution">
            </div>
        </div>

        <legend>Advisor Information</legend>

        <div class="control-group">
            <label class="control-label" for="analyst-advisor-name">Full Name<sup class='red'>*</sup></label>

            <div class="controls">
                <input type="text" id="analyst-advisor-name" class="required" placeholder="Advisor Full Name">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="analyst-advisor-email">Email<sup class='red'>*</sup></label>

            <div class="controls">
                <input type="text" id="analyst-advisor-email" class="required" placeholder="Advisor Email">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="analyst-advisor-institution">Institution<sup class='red'>*</sup></label>

            <div class="controls">
                <input type="text" id="analyst-advisor-institution" class="required" placeholder="Advisor Institution">
            </div>
        </div>
    </g:if>
    <g:elseif test="${type.equals('Expert')}">
        <div class="control-group">
            <label class="control-label" for="skills">Skills<sup class='red'>*</sup></label>

            <div class="controls">
                <input type="text" id="skills" name="skills" class="required" placeholder="Skills">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="interests">Areas of Interest<sup class='red'>*</sup></label>

            <div class="controls">
                <input type="text" id="interests" name="interests" class="required" placeholder="Areas of Interest">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="language">Languages<sup class='red'>*</sup></label>

            <div class="controls">
                <select id="language" name='language.id' multiple="multiple" size="6">
                    <g:each in="${empact.Language.list().sort { a, b -> a.name.compareTo(b.name) }}"
                            var="languageInstance">
                        <option value="${languageInstance.id}">${languageInstance.name}</option>
                    </g:each>
                </select>
            </div>
        </div>
    </g:elseif>

    <g:elseif test="${type.equals('Mentor')}">
        <div class="control-group">
            <label class="control-label" for="language">Languages<sup class='red'>*</sup></label>

            <div class="controls">
                <select id="language" name='language.id' multiple="multiple" size="6">
                    <g:each in="${empact.Language.list().sort { a, b -> a.name.compareTo(b.name) }}"
                            var="languageInstance">
                        <option value="${languageInstance.id}">${languageInstance.name}</option>
                    </g:each>
                </select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="institution">Institution<sup class='red'>*</sup></label>

            <div class="controls">
                <input type="text" id="institution" name="institution" class="required" placeholder="Institution">
            </div>
        </div>
    </g:elseif>

    <g:elseif test="${type.equals('WHO Official')}">
        <div class="control-group">
            <label class="control-label" for="who-office">WHO Office<sup class='red'>*</sup></label>

            <div class="controls">
                <select id="who-office">
                    <g:each in="${empact.WhoOffice.list()}" name="whoOffice.id" var="whoOfficeInstance">
                        <option value="${whoOfficeInstance.id}">${whoOfficeInstance.name}</option>
                    </g:each>
                </select>
            </div>
        </div>
    </g:elseif>

    <div class="control-group">
        <label class="control-label" for="country">Country<sup class='red'>*</sup></label>

        <div class="controls">
            <select id='country' name="country.id" class="input-medium bfh-countries" size="10">
                <g:each in="${empact.Country.list().sort { a, b -> a.name.compareTo(b.name) }}" var="countryInstance">
                    <option value="${countryInstance.id}">${countryInstance.name}</option>
                </g:each>
            </select>
        </div>
    </div>
</fieldset>

