<%@ page import="empact.EndUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'project.label', default: 'All Projects')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<!--NAVIGATION BAR-->
<!-- End NavBar -->


<!-- Begin Main Container -->
<div class='container'>
    <div id='match-display'>
        <div id='display-panel' class='column inline'>
            <div id='search-box'>
                <input type='text' class='search' id='project-search' placeholder='Search for projects'>
            </div>
            <ul id='project-list' class='unstyled'>
                <g:each in="${projectInstanceList}" status="i" var="projectInstance">
                    <li data-project-id="${fieldValue(bean: projectInstance, field: 'id')}" class='project'>${fieldValue(bean: projectInstance, field: "name")}</li>
                </g:each>
            </ul>

            <ul id='users' class='unstyled hide'>
                <g:each in="${endUserInstanceList}" status="i" var="endUserInstance">
                    <li id="user-${i + 1}" data-user-id="${endUserInstance.id}" class='user'>
                        <div class='category name inline'>${endUserInstance.toString()}</div>
                        <div class='viewed inline'></div>
                    </li>
                </g:each>

            </ul>

            <div id='divider'>Preview</div>

            <div class='mini-preview round8'></div>
        </div>

        <div id='multi-display' class='column inline'>
            <!-- THIS IS WHERE USERS WILL BE COMPARED -->
        </div>

        <div id='selected-users'>
            <div class='placeholder round4'>Selected Users</div>
        </div>
    </div>
</div>


<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {

        $('.dropdown-toggle').dropdown();

        init();

        $(document).on('click', '#project-list > li.project', function () {
            if (!$(this).hasClass('active')) {
                $('#project-list > li.project').removeClass('active');
                $(this).addClass('active');

                showPreview($(this), false);
            }

        });

        $(document).on('click', '.mini-preview > .btn-mini', function(event) {
            event.preventDefault();

            if (!$(this).hasClass('disabled') && ($(this).attr('id') === 'view-analysts')) {
                $('#project-list').hide().next('#users').show();

                $('#view-projects').removeClass('disabled');

            } else if (!$(this).hasClass('disabled') && ($(this).attr('id') === 'view-projects')) {
                $('#users').hide().prev('#project-list').show();

                $('#view-analysts').removeClass('disabled');
            }

            $(this).addClass('disabled');
        });

        $(document).on('dblclick', '#users > li.user', function () {
            if (!$(this).hasClass('in-use')) {
                $(this).addClass('in-use');
                var user_id = $(this).data('user-id');
                var id = $(this).attr('id');

                $.ajax({
                    url: "${g.createLink(controller:'endUser', action:'analystPreview')}",
                    type: 'post',
                    data: {id: user_id},
                    success: function (project) {
                        $('#multi-display .blank').first().addClass('active').removeClass('blank').attr('id', id + '-disp').html(project)
                    },
                    error: function (request, status, error) {
                        alert(error)
                    },
                    complete: function () {

                    }
                });

                // If there are no blank student containers
                if ($('#multi-display .active').length === $('#multi-display .student-preview').length) {
                    profileContainer();
                }
            }
        });

        $(document).on('click', '.preview-header > .icons > a', function (event) {
            event.preventDefault();
            // Get the user id and mark the user as viewed
            var arr = $(this).parent().parent().parent().attr('id').split(/(user-[0-9])/);

            if ($(this).hasClass('remove')) {
                if ($('#selected-users > #' + arr[1] + '-selected').length === 1) {
                    $('#users > #' + arr[1]).slideUp(500);
                } else {
                    $('#users > #' + arr[1]).removeClass('in-use').find('.viewed').addClass('active').text('viewed');
                }

                // Remove the preview box
                $(this).parent().parent().parent().remove();

            } else if ($(this).hasClass('select')) {
                if ($('#selected-users .placeholder').length === 1) {
                    $('#selected-users .placeholder').hide();
                }
                $('#selected-users').append(
                        "<span id='" + arr[1] + "-selected' class='round4'>" +
                                "<a href='#'>" +
                                $('#users > #' + arr[1] + ' > .name').text() +
                                "</a>" +
                                "<a href='#' rel='tooltip' data-original-title='Unselect User' class='remove'>" +
                                "<i class='icon-remove icon-white'></i>" +
                                "</a>" +
                                "</span>"
                );
                $('#users > #' + arr[1]).removeClass('in-use').slideUp(500);
                $('[rel=tooltip]').tooltip();

                // Remove the preview box
                $(this).parent().parent().parent().remove();
            }

            // If there are no blank student containers
            if ($('#multi-display .student-preview').length < 2) {
                profileContainer();
            }
        });

        $(document).on('click', '#selected-users a', function (event) {
            event.preventDefault();

            var arr = $(this).parent().attr('id').split(/(user-[0-9])/);
            if (!$(this).hasClass('remove')) {
                showProfile(arr[1]);
                $('#users > #' + arr[1]).addClass('in-use').slideDown(500);
            } else {
                // Popup asking user whether they are sure

                // Check if the profile is currently being previewed and remove the preview

                // Show the user from the side panel
                $('#users > #' + arr[1]).slideDown(500).find('.viewed').addClass('active').text('viewed');
                $(this).parent().empty().remove();

                if ($('#selected-users span').length === 0) {
                    $('#selected-users .placeholder').show();
                }
            }

            // If there are no blank student containers
            if ($('#multi-display .active').length === $('#multi-display .student-preview').length) {
                profileContainer();
            }
        });

        function init() {
            // Draw two student containers
            profileContainer();
            profileContainer();
        }

        function showPreview(elem, showTitle) {
            var txt = elem.html();

            $('#display-panel > #divider').html(txt);

            $.ajax({
                url: "${g.createLink(controller:'project', action:'showDesc')}",
                type: 'post',
                dataType: 'json',
                data: {id: elem.data('project-id')},
                success: function (data) {
                    $('.mini-preview').html(
                            (showTitle ? "<h4 id='project-title'>" + txt + "</h4>" : "") +
                            "<div id='description'>" + data.description + "</div>" +
                            "<button id='view-projects' class='btn btn-primary btn-mini disabled'>View Projects</button>" +
                            "<button id='view-analysts' class='btn btn-primary btn-mini'>View Analysts</button>"
                    );
                },
                error: function (request, status, error) {
                    alert(error)
                },
                complete: function () {

                }
            });
        }

        function profileContainer() {
            $('#multi-display').append(
                    "<div class='student-preview round8 blank'>" +
                            "<div class='placeholder round4'>Double Click on a student to preview profile</div>" +
                            "</div>"
            );
        }

    });
</script>
</body>
</html>