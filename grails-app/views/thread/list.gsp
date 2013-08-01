<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <meta charset="utf-8"/>
    <title>EMPaCT &middot; Forum</title>
    <style type="text/css">
    .well {
        background-color: #e9f2f6;
    }
    </style>
</head>

<body>
<h2><center>Forum Home</center></h2>

<div class="container">

    <div class="pagination">
        <sup>Page 1 of 5</sup>
        <ul>
            <li class="disabled"><a href="#">Prev</a></li>
            <li class="disabled"><a href="#">1</a></li>
            <li><a href="#">2</a></li>
            <li><a href="#">3</a></li>
            <li><a href="#">4</a></li>
            <li><a href="#">5</a></li>
            <li><a href="#">Next</a></li>
        </ul>

        <g:link class="create btn btn-primary pull-right" action="create" style="color:#ffffff">New Question</g:link>
        <br><br>

        <div class="row-fluid">
            <div class="span9">
                <table class="table table-striped table-bordered">
                    <g:each in="${threadInstanceList.sort { a, b -> b.created.compareTo(a.created) }}"
                            var="threadInstance">
                        <tr>
                            <td width="50%"><g:link action="show"
                                                    id="${threadInstance.id}">${threadInstance.title}</g:link><br><sub>Created by ${threadInstance.threadOwner} on ${threadInstance.created}
                            </td>
                            <g:if test="${threadInstance.responses}">
                                <td width="20%">${threadInstance.responses.size()} Replies</td>
                                <td width="20%"><g:link controller="endUser" action="show" id="${threadInstance?.responses.toList().get(0).owner.id}">${threadInstance?.responses.toList().get(0).owner}</g:link><br><sub>${threadInstance?.responses.toList().get(0).created}</sub></td>
                            </g:if>
                            <g:else>
                                <td>0 Replies</td>
                                <td>--<br><sub>--</sub></td>
                            </g:else>
                        </tr>
                    </g:each>
                </table>
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