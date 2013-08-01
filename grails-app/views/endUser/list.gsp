
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
		<a href="#list-endUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-endUser" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
            <div class="pagination">
                <g:paginate total="${endUserInstanceTotal}" />
            </div>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="address" title="${message(code: 'endUser.address.label', default: 'Address')}" />
					
						<g:sortableColumn property="phone" title="${message(code: 'endUser.phone.label', default: 'Phone')}" />
					
						<g:sortableColumn property="institution" title="${message(code: 'endUser.institution.label', default: 'Institution')}" />
					
						<g:sortableColumn property="securityAnswer" title="${message(code: 'endUser.securityAnswer.label', default: 'Security Answer')}" />
					
						<g:sortableColumn property="securityQuestion" title="${message(code: 'endUser.securityQuestion.label', default: 'Security Question')}" />
					
						<g:sortableColumn property="email" title="${message(code: 'endUser.email.label', default: 'Email')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${endUserInstanceList}" status="i" var="endUserInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${endUserInstance.id}">${fieldValue(bean: endUserInstance, field: "address")}</g:link></td>
					
						<td>${fieldValue(bean: endUserInstance, field: "phone")}</td>
					
						<td>${fieldValue(bean: endUserInstance, field: "institution")}</td>
					
						<td>${fieldValue(bean: endUserInstance, field: "securityAnswer")}</td>
					
						<td>${fieldValue(bean: endUserInstance, field: "securityQuestion")}</td>
					
						<td>${fieldValue(bean: endUserInstance, field: "email")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
    <g:javascript library="jquery"/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            pagination();

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
