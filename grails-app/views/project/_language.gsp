<select id="language" name='language.id' multiple="multiple" size="6">
    <g:each in="${empact.Language.list().sort { a, b -> a.name.compareTo(b.name) }}" var="languageInstance">
        <option value="${languageInstance.id}">${languageInstance.name}</option>
    </g:each>
</select>