<%@ page import="empact.Thread" %>
<%@ page import="empact.ThreadResponse" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta name="layout" content="main">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}" type="text/css">
    <style type="text/css">
    .well{
        background-color: #e9f2f6;
        max-width: 95%;
    }
    .thread-title{
        width: 940px;
    }
    .replyBox{
        width: 100%;
    }
    </style>

</head>

<div class="container">

    <div class="row-fluid">
        <div class="span9">
            <div class="well thread-title">
                <h3>${threadInstance.title}</h3>
                ${threadInstance.details}<br><br>
                    Started by <g:link controller="endUser" action="show" id="${threadInstance.threadOwner.id}">${threadInstance.threadOwner}</g:link> on ${threadInstance.created}
                <g:if test="${threadInstance.threadOwner.toString().contains(session.user.toString())}">
                    <g:form>
                        <fieldset class="buttons pull-right">
                            <g:hiddenField name="id" value="${threadInstance?.id}" />
                            <g:link class="edit btn btn-link" action="edit" id="${threadInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                            <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </fieldset>
                    </g:form>
                </g:if>
            </div>
            <table class="table table-bordered">
                <div class="table-body">
                    %{--<tr>
                        <td width="30%"><g:link controller="endUser" action="show" id="${threadInstance.threadOwner.id}">${threadInstance.threadOwner}</g:link>
                        <br>${threadInstance.threadOwner.userType}
                        <br><g:img dir="images" class='avatar avatar-45 photo avatar-default' file="${threadInstance.threadOwner.avataraddress}" absolute="true" alt="Grails" width="45" height="45"/>
                        </td>
                        <td width="70%"><sup>${threadInstance.created}</sup>
                        <br>${threadInstance.details}
                        </td>
                    </tr>--}%
                    <g:each in="${threadInstance.responses.sort {a,b-> a.created.compareTo(b.created)}}" var="resp">
                    <tr>
                        <td width="30%"><g:link controller="endUser" action="show" id="${resp.owner.id}">${resp.owner}</g:link>
                        <br>${resp.owner.userType.name}
                        <br><g:img dir="images" class='avatar avatar-45 photo avatar-default' file="${resp.owner.avataraddress}" absolute="true" alt="Grails" width="45" height="45"/>
                        </td>
                        <td width="70%">
                            <sup>${resp.created}</sup>
                            <br>${resp.details}
                            <g:if test="${resp.owner.toString().contains(session.user.toString())}">
                            <g:form>
                                <fieldset class="buttons pull-right ">
                                    <g:hiddenField name="id" value="${resp?.id}" />
                                    <g:link class="edit btn btn-mini btn-link" action="edit" id="${resp?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                                    <g:actionSubmit class="delete btn btn-mini btn-link" action="deleteResponse" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                </fieldset>
                            </g:form>
                            </g:if>
                        </td>

                    </tr>
                    </g:each>
                </div>
            </table>

            <div class="well">
                <h4>Reply</h4>
                <g:form action="saveResponse" id="${threadInstance.id}">
                    <g:textArea name = "details" rows="5" class="replyBox"></g:textArea>
                    <input type="submit" class="btn btn-primary pull-right"></input>
                </g:form>
            </div>
         </div>
        <div class="span3 well">
            <center>
                <h5><u>My Questions</u></h5>
                <g:each in="${threadInstanceList}" var="threadInst">
                    <g:if test="${threadInst.threadOwner.toString().contains(session.user.toString())}">
                        &middot;<g:link action="show" id="${threadInst.id}">${threadInst.title}</g:link> <br>
                    </g:if>
                </g:each>
            </center>
        </div>
    </div>
</div>

</body>
</html>