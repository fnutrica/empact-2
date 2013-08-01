<%@ page import="empact.EndUser" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="EMPaCT Login" />
    <title><g:message code="EMPaCT Log In" args="[entityName]" /></title>
</head>
<body>
<div class='container'>
    <div id="login-box" class='hero-unit'>
        <div id="create-endUser" class="content scaffold-create" role="main">
            <h2><g:message code="Log In" /></h2>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${endUserInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${endUserInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form action="authenticate" >
                <fieldset class="form">
                    <div class="fieldcontain ${hasErrors(bean: endUserInstance, field: 'userName', 'error')} ">
                        <label for="userName">
                            <g:message code="endUser.userName.label" default="User Name" />

                        </label>
                        <g:textField name="userName" value="${endUserInstance?.userName}"/>
                    </div>

                    <div class="fieldcontain ${hasErrors(bean: endUserInstance, field: 'password', 'error')} ">
                        <label for="password">
                            <g:message code="endUser.password.label" default="Password" />

                        </label>
                        <g:field type="password" name="password" value="${endUserInstance?.password}"/>
                    </div>
                </fieldset>
                <fieldset class="button">
                    <g:submitButton name="login" class="save btn btn-primary" value="Login" />
                </fieldset>
            </g:form>
            <g:link controller="endUser" action="create">Sign Up</g:link> &middot;
            <a href="#" class="forgot-info" data-forgotten-info="password">Forgot Password?</a>&middot;
            <a href="#" class="forgot-info" data-forgotten-info="login">Forgot E-mail/Username?</a>
        </div>
    </div>


</div>
<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $(document).on('click', '.forgot-info', function(event){
            event.preventDefault();

            var elem = $("#forgot-" + $(this).data('forgotten-info'));

            if (elem.length == 1) {
                if ($('.hero-unit').length > 1) {
                    $('#login-box').siblings('.hero-unit').hide();
                }
                elem.show();
            } else {
                $.ajax({
                    url: "${g.createLink(controller:'endUser', action:'forgot')}",
                    type: 'post',
                    data: {forgotType: $(this).data('forgotten-info')},
                    success: function (data) {
                        if ($('.hero-unit').length > 1) {
                            $('#login-box').siblings('.hero-unit').hide();
                        }
                        $('#login-box').after(data);
                    },
                    error: function (request, status, error) {
                        alert(error)
                    },
                    complete: function () {

                    }
                });
            }
        });

        $(document).on('click', '.submit-email', function(event) {
            event.preventDefault();

            $.ajax({
                url: "${g.createLink(controller:'endUser', action:'resetPassword')}",
                type: 'post',
                dataType: 'json',
                data: {email: $('.email').val()},
                success: function (data) {
                    $('#forgot-password').after("<div class='alert " + (data.ok ? 'alert-success' : 'alert-error') + " span10'>" + data.message + "</div>");
                },
                error: function (request, status, error) {
                    alert(error)
                },
                complete: function () {

                }
            });
        })
    });
</script>
</body>
</html>