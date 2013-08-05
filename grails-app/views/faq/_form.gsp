<%@ page import="empact.Faq" %>



<div class="fieldcontain ${hasErrors(bean: faqInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="faq.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="question" cols="40" rows="5" maxlength="5000" required="" value="${faqInstance?.question}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: faqInstance, field: 'answer', 'error')} required">
	<label for="answer">
		<g:message code="faq.answer.label" default="Answer" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="answer" cols="40" rows="5" maxlength="5000" required="" value="${faqInstance?.answer}"/>
</div>

