
<%@ page import="empact.EndUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'endUser.label', default: 'EndUser')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>


<div id="profile-box" class="container">
    <section id="left" class="pull-left block round4">
        <div id="userStats" class="clearfix block">
            <div class="pic block pull-left">
                <g:img dir="images" file="${endUserInstance?.avataraddress}" absolute="true" alt="Grails" width="150" height="150"/>
            </div>

            <div class="data block pull-left">
                <div class="profile-name">
                    <div class="inline">${endUserInstance?.toString()} [<span class="username">${endUserInstance?.userName}</span>]</div>
                    <g:link action="edit" data-original-title='Edit' class='inline'>
                        <i class='icon-edit'></i>
                    </g:link>
                </div>

                <div class="profile-details">
                    <ul class="no-list inline-edit">
                        <li class="divider">Personal Information</li>
                        <li class="data-item" id="email">${endUserInstance?.email}</li>
                        <li class="data-item" id="usertype">
                            ${endUserInstance?.userType?.name}
                        </li>
                        <li class="data-item" id="institution">${endUserInstance?.institution}</li>
                        <li class="divider">Additional Information</li>
                        <li class="data-item" id="country">${endUserInstance?.country?.name}</li>
                        <li class="data-item" id="address">${endUserInstance?.address}</li>
                        <li class="data-item" id="phone">${endUserInstance?.phone}</li>

                    </ul>
                </div>
            </div>
        </div>
    </section>

    <g:if test="${endUserInstance.userType?.name?.equals('Expert') || endUserInstance.userType?.name?.equals('Student Analyst')}">
        <section id="right" class="pull-left block">
            <div class="gcontent block">
                <div class="head">
                    <div class="inline">Skills</div>
                    <g:link action="edit" data-original-title='Edit' class='inline'>
                        <i class='icon-edit'></i>
                    </g:link>
                </div>

                <div class="boxy" data-content-type='skills'>
                    <ul class="no-list inline-edit">
                        <g:each in="${endUserInstance.skills}" status="i" var="skill">
                            <li>${skill}</li>
                        </g:each>
                    </ul>
                </div>
            </div>

            <div class="gcontent block">
                <div class="head">
                    <div class="inline">Languages</div>
                    <g:link action="edit" data-original-title='Edit' class='inline'>
                        <i class='icon-edit'></i>
                    </g:link>
                </div>

                <div class="boxy" data-content-type='languages'>
                    <ul class="no-list inline-edit">
                        <g:each in="${endUserInstance?.languages}" status="i" var="language">
                            <li>${language?.name}</li>
                        </g:each>
                    </ul>
                </div>
            </div>

            <div class="gcontent block">
                <div class="head">
                    <div class="inline">Interests</div>
                    <g:link action="edit" data-original-title='Edit' class='inline'>
                        <i class='icon-edit'></i>
                    </g:link>
                </div>

                <div class="boxy" data-content-type='interests'>
                    <ul class="no-list inline-edit">
                        <g:each in="${endUserInstance.interests}" status="i" var="interest">
                            <li>${interest}</li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </section>
    </g:if>

        <g:uploadForm action="upload">
            <input type="file" name="myFile" id="file-upload" />
            <input type="submit" class="btn btn-primary save " value="Submit"/>
        </g:uploadForm>
</div>

<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {

        $('.dropdown-toggle').dropdown();
        $('[rel=tooltip]').tooltip();
    });
</script>
</body>
</html>
