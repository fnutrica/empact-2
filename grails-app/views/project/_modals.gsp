<%@ page import="empact.EndUser" %>
<g:if test="${modalType.contains('requestData')}">
%{--request data--}%
    <div id="requestData" class="modal hide fade" tabindes="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>

            <h3>Request Data</h3>
        </div>

        <div class="modalbody-requestData">
            <div class="container">
                <g:form class="form-horizontal">
                    <div class="control-group">
                        <p>Please briefly describe the data you are requesting and why you need this data.</p>

                        <div class="controls">
                            <textarea id="reason" name="reason" class="span3"
                                      placeholder="Reasoning" rows="5"></textarea>
                        </div>
                    </div>
                </g:form>
            </div>
        </div>

        <div class="control-buttons">
            <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Cancel</button>
            <g:submitButton id="submit-request" name="submit-request" value="Submit" class="btn btn-primary"/>
        </div>
    </div>
</g:if>

<g:if test="${modaltype == 'editProject'}">
%{--edit project--}%
    <div id="editProject" class="modal hide fade" tabindes="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>

            <h3>Request Data</h3>
        </div>

        <div class="modalbody-editProject">
            <div class="container">
            </div>
        </div>

        <div class="modal-footer">
            %{--buttons--}%
        </div>
    </div>
</g:if>

<g:if test="${session.user && (modalType.contains('newProject') && (userType?.equals("Moderator") || userType?.equals("WHO Official") || userType?.equals("Country Official") || userType?.equals("Superuser")))}">
%{--new project--}%
    <div id="newProject" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>

            <h3>New Project</h3>
        </div>

        <div class="modalbody-newProject">
            <div class="container">
                <g:form name="newProject" class="form-horizontal" url="[controller: 'project', action: 'save']">
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="name">Title:<sup class='red'>*</sup></label>

                            <div class="controls">
                                <input type="text" name="name" id="name">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="country">Country:<sup class='red'>*</sup></label>

                            <div class="controls">
                                <select id='country' name="country.id" class="input-medium bfh-countries" size="10">
                                    <g:each in="${empact.Country.list().sort { a, b -> a.name.compareTo(b.name) }}" var="countryInstance">
                                        <option value="${countryInstance.id}">${countryInstance.name}</option>
                                    </g:each>
                                </select>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="conceptnote">Concept Note<sup class='red'>*</sup></label>

                            <div class="controls">
                                <!--Drop Down Menu with Concept notes -->
                                <select name='conceptnote.id' id='conceptnote' class="input-medium bfh-conceptNotes"
                                        data-country="one">
                                    <g:each in="${empact.ConceptNote.list()}" var="conceptNote" status="i">
                                        <option value="${conceptNote.id}">${fieldValue(bean: conceptNote, field: "shortTitle")}</option>
                                    </g:each>
                                </select>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="description">Description of Project<sup
                                    class='red'>*</sup></label>

                            <div class="controls">
                                <textarea id="description" name="description" class="span3"
                                          placeholder="Project Description" rows="5"></textarea>
                            </div>
                        </div>

                        <div class="control-buttons">
                            <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Cancel</button>
                            <g:submitButton id="submit-project" name="create" value="Create" class="btn btn-primary"/>
                        </div>

                    </fieldset>
                </g:form>
            </div>
        </div>
    </div>
</g:if>

<g:if test="${modalType.contains('interested-modal')}">
%{--I Am Interested Modal--}%
    <div id="interested-modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-body">
            <p>If you are seriously interested, please <g:link controller="endUser"
                                                               action="create">register</g:link> and or <g:link
                    controller="endUser" action="login">log in</g:link></p>
        </div>

        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
        </div>
    </div>
</g:if>

<g:if test="${modalType.contains('uploadFile')}">
%{--Upload File--}%
    <div id="uploadFile" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-body">
            upload file stuff
        </div>

        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
        </div>
    </div>
</g:if>