
<%@ page import="empact.Faq" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'faq.label', default: 'Faq')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

    <div class="container">
        <center><h2>FAQs</h2></center>
        <br>
		<g:if test="${faqInstanceTotal == 0}">
            <div class="alert alert-info">
                There are no FAQ's at this time.
            </div>
		</g:if>
        <g:else>
            <div class="accordion" id="faq-accordion">
                <g:each in="${faqInstanceList}" status="i" var="faqInstance">
                    <g:form method="post">
                        <div class="accordion-group" data-faq="${i}">
                            <div class="accordion-heading">
                                <a class="accordion-toggle heading-text" data-toggle="collapse" data-parent="#faq-accordion"
                                   href="#collapse-${i}">
                                    ${fieldValue(bean: faqInstance, field: "question")}
                                </a>
                            </div>

                            <div id="collapse-${i}" class="accordion-body collapse in">
                                <div class="accordion-inner">
                                    <h5>${fieldValue(bean: faqInstance, field: "question")}</h5> <br>
                                    ${fieldValue(bean: faqInstance, field: "answer")} <br>
                                    <div class="pull-right">
                                        <g:form>
                                            <g:if test="${session.user && (userType?.equals("Moderator") || userType?.equals("Superuser"))}">
                                                <fieldset class="buttons">
                                                    <g:hiddenField name="id" value="${faqInstance?.id}" />
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
        </g:else>
    <g:javascript library="jquery"/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
	</body>
</html>
