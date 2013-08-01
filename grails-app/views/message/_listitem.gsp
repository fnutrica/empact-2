<ul id="message-thread" class="unstyled">
    <g:if test="${messageInstanceTotal > 0}">
        <g:each in="${messageInstanceList.sort { a, b -> a.sent.compareTo(b.sent) }}" status="i" var="messageInstance">
            <li class='separator'>
                <div class='subject'>${fieldValue(bean: messageInstance, field: "subject")}</div>
                <ul class='unstyled' data-message-id="${messageInstance.id}">
                    <li class="message round4${((String) messageInstance.owner).equals(session.user.toString()) ? ' owner' : ' other-user'}">
                        <div class='sender'>${messageInstance.owner.toString()}</div>

                        <div class='details'>${fieldValue(bean: messageInstance, field: "details")}</div>
                    </li>

                %{--Message Responses--}%
                    <g:if test="${messageInstance.responses}">
                        <g:each in="${messageInstance.responses.sort { a, b -> a.sent.compareTo(b.sent) }}"
                                var="responseInstance">
                            <li class="message round4${((String) responseInstance.owner).equals(session.user.toString()) ? ' owner' : ' other-user'}">
                                <div class='sender'>${responseInstance.owner.toString()}</div>

                                <div class='details'>${fieldValue(bean: responseInstance, field: "details")}</div>
                            </li>
                        </g:each>
                    </g:if>
                </ul>
            </li>
        </g:each>
    </g:if>
    <g:else>
        <div class="span8 alert alert-info">There are no messages between ${session.user.toString()} and ${messageInstanceOwner.toString()}</div>
    </g:else>
</ul>