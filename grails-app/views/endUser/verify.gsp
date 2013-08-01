<%@ page import="empact.EndUser; empact.ProjectRequest" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'project_request.label', default: 'Verify Users')}"/>
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
                <input type='text' class='search' id='user-search' placeholder='Search Users'>
            </div>
            <ul id='users' class='unstyled tall'>
            %{--List Analysts--}%
                <g:if test="${analystsTotal > 0}">
                    <li class="divider" data-divider-for="student-analyst">Student Analysts</li>
                    <g:each in="${analysts}" var="analyst">
                        <li class="user" data-user-type="student-analyst" data-user-id="${analyst.id}">
                            <div class='category name inline'>${analyst.toString()}</div>
                            <div class='viewed inline'></div>
                        </li>
                    </g:each>
                </g:if>

            %{--List Experts--}%
                <g:if test="${expertsTotal > 0}">
                    <li class="divider" data-divider-for="expert">Experts</li>
                    <g:each in="${experts}" var="expert">
                        <li class="user" data-user-type="expert" data-user-id="${expert.id}">
                            <div class='category name inline'>${expert.toString()}</div>
                            <div class='viewed inline'></div>
                        </li>
                    </g:each>
                </g:if>

            %{--List WHO Officials--}%
                <g:if test="${whoOfficialsTotal > 0}">
                    <li class="divider" data-divider-for="who-fficial">WHO Officials</li>
                    <g:each in="${whoOfficials}" var="whoOfficial">
                        <li class="user" data-user-type="who-official" data-user-id="${whoOfficial.id}">
                            <div class='category name inline'>${whoOfficial.toString()}</div>
                            <div class='viewed inline'></div>
                        </li>
                    </g:each>
                </g:if>

            %{--List Country Officials--}%
                <g:if test="${countryOfficialsTotal > 0}">
                    <li class="divider" data-divider-for="country-official">Country Officials</li>
                    <g:each in="${countryOfficials}" var="countryOfficial">
                        <li class="user" data-user-type="country-official" data-user-id="${countryOfficial.id}">
                            <div class='category name inline'>${countryOfficial.toString()}</div>
                            <div class='viewed inline'></div>
                        </li>
                    </g:each>
                </g:if>

            %{--List NGO Officials--}%
                <g:if test="${ngoOfficialsTotal > 0}">
                    <li class="divider" data-divider-for="ngo-official">NGO Officials</li>
                    <g:each in="${ngoOfficials}" var="ngoOfficial">
                        <li class="user" data-user-type="ngo-official" data-user-id="${ngoOfficial.id}">
                            <div class='category name inline'>${ngoOfficial.toString()}</div>
                            <div class='viewed inline'></div>
                        </li>
                    </g:each>
                </g:if>
            </ul>
        </div>

        <div id='user-1' class='column inline'>
            <div class='preview-header'>
                <span class='round4'>Click On User To Preview Profile</span>
            </div>
            <div class='preview'></div>
        </div>
    </div>
</div>


<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.dropdown-toggle').dropdown();

        $(document).on('click', '#users > .user', function () {
            if (!$(this).hasClass('in-use')) {
                $('#users > .user').removeClass('in-use');
                $(this).addClass('in-use');

                var data = {
                    id: $(this).data('user-id'),
                    userType: $(this).data('user-type')
                };

                $.ajax({
                    url: "${g.createLink(controller:'endUser', action:'preview')}",
                    type: 'post',
                    data: data,
                    success: function (preview) {
                        $('#user-1').html(preview);
                    },
                    error: function (request, status, error) {
                        alert(error)
                    },
                    complete: function () {

                    }
                });
            }
        });

        $(document).on('click', '.preview-header > a.pull-right', function (event) {
            event.preventDefault();

            if ($(this).hasClass('approve')) {
                var data = {
                    id: $('#users > .user.in-use').data('user-id'),
                    userType: $('#users > .user.in-use').data('user-type')
                };

                if ($('#users > .user.in-use').data('user-type') === 'student-analyst') {
                    data['mentorId'] = $('#mentor-preview').data('mentor-id');
                }
                $.ajax({
                    url: "${g.createLink(controller:'endUser', action:'approve')}",
                    type: 'post',
                    dataType: 'json',
                    data: data,
                    success: function (data) {
                        $('#match-display').before(
                                "<div class='alert " + (data.ok ? "alert-success" : "alert-error") + " span10'>" +
                                        (data.ok ? data.msg : data.error) +
                                "</div>"
                        );
                        $('.alert').fadeOut(5000);

                        // Remove the user from the list
                        hideUser(true);
                    },
                    error: function (request, status, error) {
                        alert(error)
                    },
                    complete: function () {

                    }
                });
            } else {
                hideUser(false);
            }
        });

        function hideUser(remove) {
            if (remove) {
                // Remove the user
                var userType = $('#users > .user.in-use').data('user-type');
                $('#users > .user.in-use').remove();

                // If there are no other users like this one, remove the divider
                if ($(".user[data-user-type='" + userType + "']").length === 0) {
                    $(".divider[data-divider-for='" + userType + "']").remove();
                }
            } else {
                $('#users > .user.in-use').removeClass('in-use').find('.viewed').text("viewed");
            }
            $('#user-1').html(
                    "<div class='preview-header'>" +
                            "<span class='round4'>Click On User To Preview Profile</span>" +
                    "</div>" +
                    "<div class='preview'></div>"
            );
        }

    });
</script>
</body>
</html>