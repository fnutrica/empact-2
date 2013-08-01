<%@ page import="empact.ModeratorQuestion" %>



<div class="fieldcontain ${hasErrors(bean: moderatorQuestionInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="moderatorQuestion.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${moderatorQuestionInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: moderatorQuestionInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="moderatorQuestion.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="email" required="" value="${moderatorQuestionInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: moderatorQuestionInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="moderatorQuestion.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="question" cols="40" rows="5" maxlength="5000" required="" value="${moderatorQuestionInstance?.question}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: moderatorQuestionInstance, field: 'response', 'error')} ">
	<label for="response">
		<g:message code="moderatorQuestion.response.label" default="Response" />
		
	</label>
	<g:textArea name="response" cols="40" rows="5" maxlength="5000" value="${moderatorQuestionInstance?.response}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: moderatorQuestionInstance, field: 'endUser', 'error')} ">
	<label for="endUser">
		<g:message code="moderatorQuestion.endUser.label" default="End User" />
		
	</label>
	<g:select id="endUser" name="endUser.id" from="${empact.EndUser.list()}" optionKey="id" value="${moderatorQuestionInstance?.endUser?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

