<%@ page import="empact.Project" %>

<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="EMPaCT"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'global.css')}" type="text/css">
    <g:layoutHead/>
    <r:layoutResources/>

    <style type="text/css">
    .askArea {
        width: 500px;
    }
    </style>
</head>

<body>
<!--NAVIGATION BAR-->
<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">
            <ul class="nav">
                <g:if test="${session.user}">
                    <li><g:link class="brand" url="/empact/">EMPaCT</g:link></li>
                    <li><g:link controller="conceptNote">Concept Notes</g:link></li>
                    <!--Projects Dropdown-->
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            Projects <b class="caret" data-forbidden-users='guest'></b>
                        </a>
                        <ul class="dropdown-menu">
                            <li><g:link controller="project" action="list">All Projects</g:link></li>
                            <li><g:link controller="project" action="myprojects">My Projects</g:link></li>
                        </ul>
                    </li>

                    <li><g:link controller="thread" action="list">Forum</g:link></li>

                    <li id="nav-messages">
                        <g:link controller="message">
                            Messages
                            <g:set var="notifications"
                                   value="${empact.Conversation.findAllByIsReadAndRecipient(false, session.user).size()}"/>
                            <g:if test="${notifications > 0}">
                                <span class="notification round4 red">${notifications}</span>
                            </g:if>
                        </g:link>
                    </li>

                    <!--Profile Dropdown-->
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            Profile <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                            <li><g:link controller="endUser" action="show"
                                        id="${session?.user?.id}">My Profile</g:link></li>
                            <li><g:link controller="endUser" action="edit">Edit Profile</g:link></li>
                        </ul>
                    </li>

                    <li><g:link controller="endUser" action="logout">LogOut</g:link></li>

                </g:if>

                <g:elseif test="!${session.user}">
                    <!--Log In Dropdown-->
                    <li><g:link class="brand" url="/empact/">EMPaCT</g:link></li>
                    <li><g:link controller="project" action="list">All Projects</g:link></li>
                    <li><g:link controller="conceptNote">Concept Notes</g:link></li>
                    <li class="dropdown">

                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            Login <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu">
                            <li><g:link controller="endUser" action="login">Login</g:link></li>
                            <li><g:link controller="endUser" action="create">Register</g:link></li>
                        </ul>
                    </li>
                </g:elseif>
            </ul>
        </div>
    </div>
</div>

<g:layoutBody/>
<footer>
    <div class='items'>
        <g:link controller="faq">FAQ</g:link> &middot;
        <g:link controller="link">Links</g:link>
        <a href="#askMod" data-toggle="modal">&middot;Ask Us</a>
    </div>
</footer>

%{--Ask Mod Modal--}%
<div class="modal hide fade" id="askMod">
    <g:form controller="moderatorQuestion" action="saveMod">

        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

            <h3>Ask Us a Question</h3>
        </div>
        <div class="modal-body">
            <div class='controls'>
        <g:if test="${!session.user}">
            <div class='control-group'>
                <label class='control-label' for='name'>Name:</label>

                <div class='controls'>
                    <g:textArea name="name" type='text' placeholder="Name"></g:textArea>
                </div>
            </div>

            <div class='control-group'>
                <label class='control-label' for='email'>E-mail:</label>

                <div class='controls'>
            <g:textArea name="email" type='text'></g:textArea>
            </div>
        </g:if>
        <div class="control-group">
            <label class='control-label' for='message'>Message:</label>
            <g:textArea name="question" rows="5" class="replyBox"></g:textArea>
        </div>
        </div>
    </div>

        <div class="modal-footer">
            <a href="#" class="btn" class="close" data-dismiss="modal">Cancel</a>
            <input type="submit" class="btn btn-primary"></input>
        </div>
    </g:form>
</div>

    <g:javascript library="application"/>
    <r:layoutResources/>
</body>
</html>
