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
        <div tabindex="-1" class="alert span10 update-alert hide"></div>
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

            $('.inline-edit').each(function(index) {
                var txt = $(this).data('property-value');

                if ($(this).data('property-name') == 'country'){
                    $(this).html("<select name='country' class='input-medium bfh-countries' size='10'></select>");
                    for (var i = 0; i < countries.length; i++) {
                        if ($(this).data('property-value') == codes[i]) {
                            $(".bfh-countries").append("<option value='" + codes[i] + "' selected='selected'>" + countries[i] + "</option>");
                        } else {
                            $(".bfh-countries").append("<option value='" + codes[i] + "'>" + countries[i] + "</option>");
                        }
                    }
                } else if ($(this).data('property-name') == 'language') {
                    $(this).html(
                            "<select name='language' size='6'>" +
                                    "<option value='ara'>Arabic</option>" +
                                    "<option value='chi'>Chinese</option>" +
                                    "<option value='eng'>English</option>" +
                                    "<option value='fre'>French</option>" +
                                    "<option value='rus'>Russian</option>" +
                                    "<option value='spa'>Spanish</option>" +
                                    "</select>"
                    );
                    $(this).find('select').find("option[value='" + $(this).data('property-value') + "']").attr('selected', 'selected');
                } else if ($(this).data('property-name') != 'description') {
                    $(this).html("<input type='text' class='inline-text' name='" + $(this).data('property-name') +
                            "' value='" + txt +"' />");
                }

                else {
                    $(this).html("<textarea type='text' class='inline-text' name='" + $(this).data('property-name') +
                            "'>" + txt + "</textarea>");
                }
            });
            /*$('.link-to-edit > ul').hide().after(
             "<a href='" + "${g.createLink(controller:'endUser', action:'matchusers')}" + "' class='external-link'>Add Users</a>"
             );*/
            $(this).removeClass('edit-project').addClass('save-project').html('Save Project');
        });

        $(document).on('click', '.save-project', function(event) {
            event.preventDefault();

            var edited = {id: $('.project-controls a.active').data('project-id')};
            $('.inline-edit > .inline-text').each(function() {
                edited[$(this).attr('name')] = $(this).val();
            });
            $('.inline-edit > select > option:selected').each(function() {
                edited[$(this).parent().attr('name')] = $(this).val();
            });

            $.ajax({
                url: "${g.createLink(controller:'project', action:'ajaxUpdate')}",
                type: 'post',
                dataType: 'json',
                data: edited,
                success: function (data) {
                    if (data.ok) {
                        $('.inline-edit > .inline-text').each(function() {
                            $(this).after($(this).val());
                        });
                        $('.inline-edit > .inline-text').empty().remove();

                        $('.inline-edit > select > option:selected').each(function() {
                            $(this).parent().after($(this).text());
                        });
                        $('.inline-edit > select').empty().remove();

                        $('.save-project').removeClass('save-project').addClass('edit-project').html('Edit Project');
                        $('.update-alert').removeClass('hide alert-error').addClass('alert-success').html(
                                "Project successfully updated"
                        ).show().fadeOut(5000);
                    } else {
                        $('.update-alert').removeClass('hide alert-success').addClass('alert-error').html(
                                "Project could not be updated"
                        ).show().fadeOut(5000);
                    }
                },
                error: function (request, status, error) {
                    $('.update-alert').removeClass('hide alert-success').addClass('alert-error').html(
                            error
                    ).show().fadeOut(5000);
                },
                complete: function () {

                }
            });
        });

    });
</script>
</body>
</html>
