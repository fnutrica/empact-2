<%@ page import="empact.EndUser; empact.ProjectRequest" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'project_request.label', default: 'Approve Project Requests')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<!-- Begin Main Container -->
<div class='container'>
    <div id='match-display'>
        <div id='display-panel' class='column inline'>
            <div id='search-box'>
                <input type='text' class='search' id='project-search' placeholder='Search for projects'>
            </div>
            <g:if test="${projectInstanceTotal}">
                <ul id='project-list' class='unstyled small'>
                    <g:each in="${projectInstanceList}" var="projectInstance">
                        <li data-project-id="${fieldValue(bean: projectInstance, field: 'id')}"
                            class='project'>${fieldValue(bean: projectInstance, field: "name")}</li>
                    </g:each>
                </ul>
            </g:if>
            <g:else>
                <ul id='project-list' class='unstyled small'>
                    <li style="text-align: center; margin-top: 10px;">No projects with requests</li>
                </ul>
            </g:else>
        </div>

        <div id='multi-display' class='column inline'>
            <!-- THIS IS WHERE USERS WILL BE COMPARED -->
        </div>

        <div id='display-footer'>
            <a href="#" class="btn btn-primary inline disabled" id="approve-users">Approve</a>
            <div id='selected-users' class="inline">
                <div class='placeholder round4'>Selected Users</div>
            </div>
        </div>
    </div>
</div>


<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {

        $('.dropdown-toggle').dropdown();

        $(document).on('click', '#project-list > li.project', function () {
            if (!$(this).hasClass('active')) {
                $('#project-list > li.project').removeClass('active');
                $(this).addClass('active');

                $.ajax({
                    url: "${g.createLink(controller:'suggestedUser', action:'suggestionsByProject')}",
                    type: 'post',
                    data: {id: $('.project.active').data('project-id')},
                    success: function (users) {
                        $('#multi-display').html(users);
                    },
                    error: function (request, status, error) {
                        alert(error)
                    },
                    complete: function () {

                    }
                });
            }

        });

        $(document).on('click', '.preview-header > .icons > a', function (event) {
            event.preventDefault();
            // Get the user id and mark the user as viewed
            var id = $(this).parent().parent().parent().data('user-id');
            var name = $(this).parent().parent().parent().data('user-name');

            if ($(this).hasClass('remove')) {
                // Remove the preview box
                $(this).parent().parent().parent().remove();

            } else if ($(this).hasClass('select')) {
                if ($('#selected-users .placeholder').length === 1) {
                    $('#selected-users .placeholder').hide();
                }
                $('#selected-users').prepend(
                        "<span id='user-" + id + "-selected' data-user-id='" + id + "' class='round4'>" +
                                "<a href='#'>" + name + "</a>" +
                                "<a href='#' rel='tooltip' data-original-title='Unselect User' class='remove'>" +
                                "<i class='icon-remove icon-white'></i>" +
                                "</a>" +
                                "</span>"
                );
                $('[rel=tooltip]').tooltip();

                // Remove the preview box
                $(this).parent().parent().parent().hide();

                // Remove disabled class from the suggest button
                $('#approve-users').removeClass('disabled');
            }
        });

        $(document).on('click', '#selected-users a', function (event) {
            event.preventDefault();

            var arr = $(this).parent().attr('id').split(/(user-[0-9])/);
            if (!$(this).hasClass('remove')) {
                $('#users > #' + arr[1]).addClass('in-use').slideDown(500);
            } else {
                // TODO: Popup asking user whether they are sure

                // Check if the profile is currently being previewed and remove the preview

                if ($('#selected-users span').length === 0) {
                    $('#selected-users .placeholder').show();

                    // Prevent empty users from being submitted
                    $('#suggest-users').addClass('disabled');
                }
            }
        });

        $(document).on('click', '#approve-users', function (event) {
            event.preventDefault();

            if (!$(this).hasClass('disabled')) {
                if ($('#selected-users span').length > 0) {
                    var users = {};
                    $('#selected-users span').each(function (index) {
                        users[index] = $(this).data('user-id');
                    });
                    var data = {
                        users: users,
                        project_id: $('.project.active').data('project-id')
                    };

                    $.ajax({
                        url: "${g.createLink(controller:'suggestedUser', action:'addUsersToProject')}",
                        type: 'post',
                        dataType: 'json',
                        data: data,
                        success: function (data) {
                            var txt;
                            if (data.ok) {
                                txt = "User" + (users.length > 1 ? "": "s") + " approved";
                                $('#selected-users span').remove();
                                $('#selected-users .placeholder').show();
                                $('#approve-users').addClass('disabled');
                            } else {
                                txt = data.error;
                            }
                            $('body').append(
                                    "<div class='alert span10 " + (data.ok ? "alert-success" : "alert-error") + "'>" + txt + "</div>"
                            );
                            $('.alert').fadeOut(5000);
                        },
                        error: function (request, status, error) {
                            alert(error)
                        },
                        complete: function () {

                        }
                    });
                }
            }
        });

    });
</script>
</body>
</html>