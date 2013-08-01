<%@ page import="empact.EndUser; empact.Project; empact.ConceptNote" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'project.label', default: 'All Projects')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">
    <h3 id="all-projects" class="inline">All Projects</h3>
    <g:if test="${session.user && (userType?.equals("Moderator") || userType?.equals("WHO Official") || userType?.equals("Country Official") || userType?.equals("Superuser"))}">
        <a href="#newProject" class="inline btn btn-primary" data-toggle="modal">New Project</a>
    </g:if>
    <div class="pagination">
        <g:paginate total="${projectInstanceTotal}" />
    </div>
    <table id="projects" class="tablesorter table table-stripped">
        <thead>
        <tr>

            <g:sortableColumn property="name" title="${message(code: 'project.name.label', default: 'Name')}"/>

            <g:sortableColumn property="conceptnote"
                              title="${message(code: 'project.conceptnote.label', default: 'Concept Note')}"/>

            <g:sortableColumn property="country" title="${message(code: 'project.country.label', default: 'Country')}"/>

            <g:sortableColumn property="status" title="${message(code: 'project.status.label', default: 'Status')}"/>

            <th class="preview">Preview</th>

        </tr>
        </thead>
        <tfoot>
        <tr>
            <td colspan='6'>
                Showing
                <input type='text' class='input-tiny' value="${(projectInstanceTotal > 10) ? 10 : projectInstanceTotal}">
                of ${projectInstanceTotal} results
            </td>
        </tr>
        </tfoot>
        <tbody id="proj-list">
        <g:render template="listitem"/>
        </tbody>
    </table>

</div>
<g:render template="modals" />

<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {

        init();

        $(document).on('click', '#projects tbody td', function () {
            if ($(this).hasClass('preview')) {
                return;
            }
            $('#projects tr').removeClass('active');
            $(this).parent().addClass('active');

            // Get project description
            $.ajax({
                url: "${g.createLink(controller:'project', action:'showDesc')}",
                type: 'post',
                dataType: 'json',
                data: {id: $(this).parent().data('project-id')},
                success: function (data) {
                    $('#project-preview > #preview-description').html(data.description);
                },
                error: function (request, status, error) {
                    alert(error)
                },
                complete: function () {

                }
            });
        });

        function init() {
            $('td.preview').parent().addClass('active');
            pagination();
            $('.dropdown-toggle').dropdown();
        }

        // Do this on load
        function pagination() {
            if ($('.pagination').children().length) {
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
                                "<a href='" + ($('.pagination > .nextLink').length ? $('.pagination > .nextLink').attr('href') + "'" : "#'  onClick='return false;'") + ">next &rarr;</a>" +
                        "</li>"
                );

                $('.pagination').remove();
            }
        }
    });
</script>
</body>
</html>
