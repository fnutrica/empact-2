<g:if test="${forgotType=='password'}">
%{--Forgot Password--}%
<div id="forgot-password" class="hero-unit">
    <h2>Forgot Password</h2>
    <p>Please provide your e-mail address. A password reset will be sent to this e-mail address.</p>
    <input type="text" class="email" placeholder="Enter Email...">
    <a href="#" class="btn btn-primary submit-email">Submit</a>
    <br><a href="#" class="forgot-info" data-forgotten-info="login">Forgot E-mail/Username?</a>
</div>
</g:if>
<g:elseif test="${forgotType=='login'}">
%{--Forgot Email/Username--}%
%{--<div class="hero-unit">--}%
    %{--<h2>Forgot Email/Username</h2>--}%
    %{--<p>We need to verify your identity before providing you with additional information. Please provide your phone number so that we can verify your identity.</p>--}%
    %{--<input type="text" class="phone-number">--}%
    %{--<a href=# class="btn btn-primary">Submit</a>--}%
    %{--<a href="#">I don't want to provide my phone number.</a>--}%
%{--</div>--}%
%{--</g:elseif>--}%
%{--Security Questions--}%
%{--<div class="hero-unit">--}%
    %{--<h2>Answer Security Question</h2>--}%
    %{--<p>Please answer the following security question. If you answer correctly, we can provide you with your Log In information.</p>--}%
    %{--<sub>Answer is case sensitive.</sub><br>--}%
    %{--<input type="password" class="password">--}%
    %{--<a href="#" class="btn btn-primary">Submit</a>--}%
%{--</div>--}%
%{--Reset Sent--}%
%{--<div class="hero-unit">--}%
    %{--<h2>Reset Password Sent</h2>--}%
    %{--<p>We have sent a password reset to the email [GET EMAIL].</p>--}%
%{--</div>--}%

%{--Could Not Reset--}%
<div id="forgot-login" class="hero-unit">
    <p>We are sorry, but we were unable to verify your identity at this time. Please <a href=#>contact our moderator</a> for additional help.</p>
</div>
</g:elseif>