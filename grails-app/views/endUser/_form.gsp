<%@ page import="empact.EndUser" %>

<div id="page-1" class="page">
    <fieldset>
        <legend>Account Information</legend>
        <div class="control-group">
            <label class="control-label" for="firstName">First Name<sup class='red'>*</sup></label>
            <div class="controls">
                <input type="text" id="firstName" name="firstName" class="required" placeholder="First Name">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="lastName">Last Name<sup class='red'>*</sup></label>
            <div class="controls">
                <input type="text" id="lastName" name="lastName" class="required" placeholder="Last Name">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="userName">userName<sup class='red'>*</sup></label>
            <div class="controls">
                <input type="text" id="userName" name="userName" class="required" placeholder="userName">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="email">Email<sup class='red'>*</sup></label>
            <div class="controls">
                <input type="text" id="email" name="email" class="required" placeholder="Email">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="password">Password<sup class='red'>*</sup></label>
            <div class="controls">
                <input type="password" id="password" name="password" class="required" placeholder="Password">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="cpasswd">Confirm Password<sup class='red'>*</sup></label>
            <div class="controls">
                <input type="password" id="cpasswd" class="required" placeholder="Confirm Password">
            </div>
        </div>
    </fieldset>
</div>

<div id="page-2" class="page">
    <fieldset>
        <legend>Role and Additional Questions</legend>
        <div class="control-group">
            <label class="control-label" for="securityQuestion">Security Question<sup class='red'>*</sup></label>
            <div class="controls">
                <input type="text" id="securityQuestion" name="securityQuestion" class="required" placeholder="Security Question">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="securityAnswer">securityAnswer<sup class='red'>*</sup></label>
            <div class="controls">
                <input type="text" id="securityAnswer" name="securityAnswer" class="required" placeholder="Security Answer">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="userType">User Type<sup class='red'>*</sup></label>
            <div class="controls">
                <g:each in="${empact.UserType.list()}" var="userTypeInstance">
                    <g:if test="${!(userTypeInstance?.name?.equals('Superuser') && userTypeInstance?.name?.equals('Moderator'))}">
                        <label class="radio">
                            <input type="radio" name="userType.id" value="${userTypeInstance?.id}"> ${userTypeInstance?.name}
                        </label>
                    </g:if>
                </g:each>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="address">Address<sup class='red'>*</sup></label>
            <div class="controls">
                <textarea placeholder="Postal Address" id="address" name="address"></textarea>
            </div>
        </div>
        <g:hiddenField name="verified" value="${false}" />

    </fieldset>
</div>

<div id="page-3" class="page">

</div>

<div id='reg-controller'>
    <ul class='pager'>
        <li class='previous disabled ctrl-btn'><a href='#'>&larr; prev</a></li>

        <li class='cancel'>
            <g:link class='btn btn-danger' url="/empact/">Cancel</g:link>
        </li>

        <li class='next ctrl-btn'><a href='#'>next &rarr;</a></li>
        <li class="save ctrl-btn hide"><g:submitButton name="create" value="Create" /></li>
    </ul>
</div>