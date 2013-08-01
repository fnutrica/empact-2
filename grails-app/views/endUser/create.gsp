<%@ page import="empact.EndUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'endUser.label', default: 'EndUser')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">
    <form id="register" action="/empact/endUser/save" method="post" class="form-horizontal">
        <g:render template="form"/>
    </form>
</div>


<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {

        $('.page').first().addClass('active').show();

        $(document).on('blur', '.required', function () {
            controls($(this));
        });

        $(document).on('click', '.ctrl-btn', function (event) {
            var pageid;

            if ($(this).hasClass('next')) {
                event.preventDefault();
                if (check($('.page.active').attr('id'))) {
                    $('.page.active').removeClass('active').hide().next('.page').addClass('active');
                    pageid = $('.page.active').attr('id');

                    if (pageid === 'page-2') {
                        $('.pager > .previous').removeClass('disabled');
                    } else if (pageid === 'page-3') {
                        subpage();
                        $(this).hide().next('.save').show();
                    }
                    $('.page.active').show();
                }
            } else if ($(this).hasClass('previous')) {
                event.preventDefault();
                $('.page.active').removeClass('active').hide().prev('.page').addClass('active');
                pageid = $('.page.active').attr('id');

                if (pageid === 'page-1') {
                    $('.pager > .previous').addClass('disabled');
                } else if (pageid === 'page-2') {
                    $('.control-group.hidden, legend.hidden').hide();
                    $('.save').hide().prev('.next').show();
                }
                $('.page.active').show();
            }
        });

        function check(id) {
            var req = $('#' + id + ' > fieldset > .control-group > .controls > input.required');
            var cur = req.first();
            var i;

            var arr = [];
            req.each(function (index) {
                arr[index] = $(this);
            });

            for (i = 0; i < arr.length; i++) {
                if (controls(arr[i])) {
                    return false;
                }
            }
            return true;
        }

        function controls(elem) {
            var cond, error;
            var email = /^[\w!#$%&\’*+\/=?^`{|}~.-]+@(?:[a-z\d][a-z\d-]*(?:\.[a-z\d][a-z\d-]*)?)+\.(?:[a-z][a-z\d-]+)$/i;
            var other = /^[a-zA-Z0-9_\.-]{3,20}$/;

            switch (elem.attr('id')) {
                case 'email':
                    cond = (elem.val().length == 0) && !email.test(elem.val());
                    error = "Please enter a valid email address";
                    break;
                case 'password':
                    cond = elem.val().length < 8;
                    error = "Password needs to be at least 8 characters";
                    break;
                case 'cpasswd':
                    cond = $('#password').val() !== elem.val();
                    error = "Passwords do not match";
                    break;
                default:
                    cond = (elem.val().length == 0) && !other.test(elem.val());
                    error = "Please enter a valid " + elem.attr('placeholder').toLowerCase();
                    break;
            }

            if (cond) {
                elem.after("<span class='error'>" + error + "</span>")
                        .next('span.error').fadeOut(5000);
            }

            return cond;
        }

        function subpage() {
            $.ajax({
                url: "${g.createLink(controller:'endUser', action:'additionalInfo')}",
                type: 'post',
                data: {id: $("input[name='userType.id']:checked").val()},
                success: function (data) {
                    $('#page-3').html(data);
                },
                error: function (request, status, error) {
                    alert(error)
                },
                complete: function () {

                }
            });
        }

    });
</script>

</body>
</html>
