<%@ page import="empact.ProjectRequest; empact.EndUser; empact.Project" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'project.label', default: 'All Projects')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">

    <h3 id="my-projects" class="inline">My Projects</h3>

    <g:if test="${session.user && (userType?.equals("Moderator") || userType?.equals("WHO Official") || userType?.equals("Country Official") || userType?.equals("Superuser"))}">
        <a href="#newProject" class="inline btn btn-primary" data-toggle="modal">New Project</a>
    </g:if>

    <g:if test="${projectInstanceTotal != 0}">
        <div class="row-fluid">
            <g:if test="${projectInstanceList.size() > 0}"><!--If a user has a project assigned to them.-->
                <div class="span4">
                    <div class="well">
                        <h5 style="margin-bottom: 0.8em;">My Projects List</h5>
                        <ul class="unstyled project-controls">
                            <g:each in="${projectInstanceList}" status="i" var="projectInstance">
                                <li><g:link action="show" id="${projectInstance.id}" data-project-id="${projectInstance.id}">${fieldValue(bean: projectInstance, field: "name")}</g:link></li>
                            </g:each>
                        </ul>
                    </div>
                    <div class="well">
                        <h5>Helpful Links</h5>
                        <ul class="unstyled project-controls">
                            <li><a href="http://www.macalester.edu">Macalester College</a></li>
                            <li><a href="http://who.int">World Health Organization</a></li>
                        </ul>
                    </div>
                </div>

                <div id="project" class="span8 project-content round8-top">
                    <g:render template="project"/>
                </div>
            </g:if>
        </div>
        <div class="alert span10 update-alert hide"></div>
    </g:if>
    <g:else>
        <div class="alert alert-info span10 no-items-message">
            Looks like you do not have any projects. Visit our
            <g:link controller="project" action="list">projects page</g:link>
            to request to be on one.
        </div>
    </g:else>
</div>
<g:render template="modals" />

<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {

        $('.project-controls > li').first().find('a').addClass('active');

        $(document).on('click', 'ul.project-controls > li > a', function (event) {
            event.preventDefault();

            if (!$(this).hasClass('active')) {
                $.ajax({
                    url: "${g.createLink(controller:'project', action:'ajaxShow')}",
                    type: 'post',
                    data: {id: $(this).data('project-id')},
                    success: function (project) {
                        $('#project').html(project);
                    },
                    error: function (request, status, error) {
                        alert(error)
                    },
                    complete: function () {

                    }
                });
                $(this).parent().parent().find('li > a').removeClass('active');
                $(this).addClass('active');
            }
        });

        $(document).on('click', '.edit-project', function(event) {
            event.preventDefault();

            event.preventDefault();
            var project_id = $(this).data('project-id');

            $.ajax({
                url: "${g.createLink(controller:'project', action:'inPlaceEdit')}",
                type: 'post',
                data: {id: project_id},
                success: function (project) {
                    $('#details > .row > ul.unstyled').html(project);
                },
                error: function (request, status, error) {
                    alert(error)
                },
                complete: function () {

                }
            });

            $(this).removeClass('edit-project').addClass('save-project').html('Save Project');
        });

        $(document).on('click', '.save-project', function(event) {
            event.preventDefault();

            if (!$(this).hasClass('disabled')) {
                $(this).addClass('disabled');

                var edited = {edited_project_id: $('.project-controls a.active').data('project-id')};
                $('.inline-text').each(function() {
                    edited[$(this).attr('name')] = $(this).val();
                });
                $('.inline-select > option:selected').each(function() {
                    edited[$(this).parent().attr('name')] = $.trim($(this).val());
                });

                $.ajax({
                    url: "${g.createLink(controller:'project', action:'ajaxSave')}",
                    type: 'post',
                    data: edited,
                    success: function (project) {
                        $('#project').html(project);
                        $('.save-project').removeClass('disabled');
                    },
                    error: function (request, status, error) {
                        $('.update-alert').removeClass('hide alert-success').addClass('alert-error').html(
                                error
                        ).show().fadeOut(5000);
                    },
                    complete: function () {

                    }
                });
            }
        });

    });
</script>
</body>
</html>
