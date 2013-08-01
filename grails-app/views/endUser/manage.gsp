
<%@ page import="empact.EndUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'endUser.label', default: 'EndUser')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'global.css')}" type="text/css">
</head>
<body>
<div class="container">
    <div class="pagination">
        <g:paginate total="${endUserInstanceTotal}" />
    </div>
    <ul class="unstyled">
        <g:each in="${endUserInstanceList}" status="i" var="endUserInstance">
            <li class="user-list-item round4 pointer" data-user-id="${endUserInstance.id}">
                <div class="user-name">${endUserInstance.toString()} <a href="#" class="delete pull-right no-deco hide"><i class="icon-remove"></i> Delete</a></div>
                <div class="user-preview hide round4"></div>
            </li>
        </g:each>
    </ul>
</div>
<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {
        pagination();

        $(document).on('click', '.user-list-item', function () {
            if ($(this).hasClass('active')) {
                $('.user-list-item.active .delete').hide(200);
                $(this).removeClass('active').find('.user-preview').slideUp(200);
            } else {
                $('.user-list-item').removeClass('active');

                if ($(this).find('.user-preview').html().length) {
                    $(this).addClass('active');
                    $('.user-list-item.active > .user-preview').slideDown(200);
                    $('.user-list-item.active .delete').show(200);
                } else {
                    var user_id = $(this).data('user-id');
                    $(this).addClass('active');
                    $.ajax({
                        url: "${g.createLink(controller:'endUser', action:'previewInList')}",
                        type: 'post',
                        data: {id: user_id},
                        success: function (data) {
                            $('.user-list-item.active > .user-preview').html(data).slideDown(200);
                            $('.user-list-item.active .delete').show(200);
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

        $(document).on('click', '.user-list-item.active .delete', function (event) {
            event.preventDefault();
            var user_id = $('.user-list-item.active').data('user-id');

            $.ajax({
                url: "${g.createLink(controller:'endUser', action:'ajaxDelete')}",
                type: 'post',
                dataType: 'json',
                data: {id: user_id},
                success: function (data) {
                    $(".user-list-item[data-user-id='" + user_id + "']").removeClass('active').remove();
                    $('.user-list-item:last').after(
                            "<div class='alert " + (data.ok ? "alert-success" : "alert-error") + " span10'>" +
                                    (data.ok ? data.msg : data.error) +
                            "</div>"
                    );
                    $('.alert').fadeOut(5000);
                },
                error: function (request, status, error) {
                    alert(error)
                },
                complete: function () {

                }
            });
        });

        // Do this on load
        function pagination() {
            if ($('.pagination').children()) {
                // Create new pagination object
                $('.pagination').after("<ul class='pager'></ul>");

                // If the grails pagination has a previous link, add it to the new pagination object,
                // otherwise add a disabled previous button
                $('.pager').append(
                        "<li class='previous" + ($('.pagination > .prevLink').length ? "" : " disabled") + "'>" +
                                "<a href='" + ($('.pagination > .prevLink').length ? $('.pagination > .prevLink').attr('href') : "#") + "'>&larr; prev</a>" +
                                "</li>"
                );

                $('.pagination').children().each(function () {
                    // Ignore next and previous link
                    if (!($(this).hasClass('nextLink') || $(this).hasClass('prevLink'))) {
                        if ($(this).hasClass('step')) {
                            $('.pager').append(
                                    "<li class='page-num'>" +
                                            "<a href='" + $(this).attr('href') + "'>" + $(this).text() + "</a>" +
                                            "</li>"
                            );
                        } else if ($(this).hasClass('currentStep')) {
                            $('.pager').append(
                                    "<li class='page-num disabled'>" +
                                            "<a href='#' onClick='return false'>" + $(this).text() + "</a>" +
                                            "</li>"
                            );
                        }
                    }
                });

                $('.pager').append(
                        "<li class='next" + ($('.pagination > .nextLink').length ? "" : " disabled") + "'>" +
                                "<a href='" + ($('.pagination > .nextLink').length ? $('.pagination > .nextLink').attr('href') : "#") + "'>next &rarr;</a>" +
                                "</li>"
                );
                $('.pagination').remove();
            }

        }
    });
</script>
</body>
</html>
