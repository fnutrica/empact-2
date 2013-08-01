<%@ page import="empact.EndUser; empact.ProjectRequest; empact.Project" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'project.label', default: projectInstance.name)}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">
    <div class="row-fluid">
        <h3 class="inline">${projectInstance.name}</h3>
        <g:if test="${session.user && (userType?.equals("Student Analyst") && projectInstance.analysts.contains(session.user))}">
            <a id="request-trigger" href="#request-modal" class="inline btn btn-primary disabled" data-toggle="modal">Request Approved</a>
        </g:if>
        <g:elseif test="${session.user && (userType?.equals("Expert") && projectInstance.experts.contains(session.user))}">
            <a id="request-trigger" href="#request-modal" class="inline btn btn-primary disabled" data-toggle="modal">Request Approved</a>
        </g:elseif>
        <g:elseif test="${session.user && ((userType?.equals("Student Analyst") || userType?.equals("Expert")) && !ProjectRequest.findByOwnerAndProject(session.user, projectInstance))}">
            <a id="request-trigger" href="#request-modal" class="inline btn btn-primary" data-toggle="modal">Request to be on project</a>
        </g:elseif>
        <g:elseif test="${session.user && (userType?.equals("Student Analyst") || userType?.equals("Expert"))}">
            <a id="request-trigger" href="#request-modal" class="inline btn btn-primary disabled" data-toggle="modal">Request Sent</a>
        </g:elseif>
        <div class="span10 project-content round8-top">
            <g:render template="project"/>
        </div>
    </div>
</div>
<g:if test="${session.user && ((userType?.equals("Student Analyst") || userType?.equals("Expert")) && !ProjectRequest.findByOwnerAndProject(session.user, projectInstance))}">
    <div id="request-modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-body">
            <p>Please let us know why you would like to be in this project.</p>
            <textarea id="request-reason" data-project-id="${projectInstance.id}" placeholder="Enter Reason Here"></textarea>
        </div>

        <div class="modal-footer">
            <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Close</button>
            <button class="btn btn-primary" id="request-submit">Submit Request</button>
        </div>
    </div>
</g:if>
<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $(document).on('click', '#request-submit', function () {
            if (!$(this).hasClass('disabled')) {
                var params = {
                    details: $('#request-reason').val(),
                    project_id: $('#request-reason').data('project-id')
                };

                $.ajax({
                    url: "${g.createLink(controller:'projectRequest', action:'ajaxSave')}",
                    type: 'post',
                    dataType: 'json',
                    data: params,
                    success: function (data) {
                        var txt;
                        if (data.ok) {
                            txt = "Request Successfully sent. You will be contacted " +
                                    "confirmation by our moderators as soon as possible.";
                            $('#request-trigger').addClass('disabled').text('Request Pending');
                        } else {
                            txt = data.error;
                        }
                        $('.container > .row-fluid').after(
                                "<div class='alert " + data.ok ? "alert-error" : "alert-success" + " span10'>" + txt + "</div>"
                        );
                        $('.alert').fadeOut(5000);
                        $('#request-modal').modal('hide');
                    },
                    error: function (request, status, error) {
                        alert(error)
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