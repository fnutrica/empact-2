<!--CONCEPT NOTES LIST-->


<%@ page import="empact.EndUser; empact.ConceptNote" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'conceptNote.label', default: 'ConceptNote')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class='container'>
    <!-- Title -->
    <h3 class="titleText inline">Concept Notes</h3>

    <g:if test="${session.user && (userType?.equals("Moderator"))}">
        <div class="btn btn-primary pull-right">Hi</div>
    </g:if>

    <div class="accordion" id="conceptnote-accordion">
        <g:each in="${conceptNoteInstanceList}" status="i" var="conceptNoteInstance">
            <g:form method="post">
            <div class="accordion-group" data-concept-note="${i}">
                <div class="accordion-heading">
                    <a class="accordion-toggle heading-text" data-toggle="collapse" data-parent="#conceptnote-accordion"
                       href="#collapse-${i}">
                        ${fieldValue(bean: conceptNoteInstance, field: "shortTitle")}
                    </a>
                </div>

                <div id="collapse-${i}" class="accordion-body collapse in">
                    <div class="accordion-inner">
                        <h4>${fieldValue(bean: conceptNoteInstance, field: "fullTitle")}</h4>
                        ${fieldValue(bean: conceptNoteInstance, field: "description")} <br>
                        <div class="pull-right">
                            <g:form>
                                <g:if test="${session.user && (userType?.equals("Moderator") || userType?.equals("Superuser"))}">
                                <fieldset class="buttons">
                                    <g:hiddenField name="id" value="${conceptNoteInstance?.id}" />
                                    <div class='edit btn btn-link' role='btn'>Edit</div>
                                    <g:actionSubmit class="delete btn btn-link" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                </fieldset>
                                    </g:if>
                            </g:form>
                        </div>
                    </div>
                </div>
            </div>
            </g:form>
        </g:each>
    </div>
</div>

<div id="newConceptNote" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">Add a New Concept Note</h3>
    </div>
    <div class="modal-body">
        <div id="create-conceptNote" class="content scaffold-create" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${conceptNoteInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${conceptNoteInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form action="save" >
                <fieldset class="form">
                    <g:render template="form"/>
        </div>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
        <g:submitButton name="create" class="save btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </fieldset>
            </g:form>
    </div>
</div>

<g:javascript library="jquery"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.dropdown-toggle').dropdown();
        $('[rel=tooltip]').tooltip();

        $(document).on('click', '.accordion-body > .btn-link', function (event) {
            event.preventDefault();

            if ($(this).hasClass('delete')) {
                // Trash
            } else {
                //Get Text
                var elem = $(this).parent().prev('.accordion-toggle');
                var txt = elem.text().replace(/^\s+|\s+$/g, '');
                elem.hide().after(
                        "<input type='text' class='inplace-edit heading-text' value='" + txt + "'>"
                );

                elem = $(this).parent().parent().next('.accordion-body').find('.accordion-inner');
                txt = elem.text().replace(/^\s+|\s+$/g, '');
                elem.hide().after(
                        "<textarea class='inplace-edit body-text'>" + txt + "</textarea>" +
                                "<button class='btn btn-mini btn-primary'>Save</button>"
                );
            }

        });

        $(document).on('click', '.accordion-body > .btn-link', function (event) {
            event.preventDefault();

            var txt = $(this).prev('.inplace-edit').val();
            $(this).siblings('.accordion-inner').text(txt).show().next('textarea').remove();

            txt = $('.accordion-heading input.inplace-edit').val();
            $('.accordion-heading input.inplace-edit').siblings('.accordion-toggle').text(txt).show()
                    .next('input').remove();

            // Remove button
            $(this).remove();
        });

        $(".delete-confirm").click(function(){

            $(this).parent().parent().parent().parent().parent().remove();
        });
    });

</script>
</body>
</html>