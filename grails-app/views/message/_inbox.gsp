<section class="inline" id="left">
    <ul id="users" class="unstyled">
        <g:if test="${endUserInstanceTotal > 0}">
            <g:each in="${endUserInstanceList}" status="i" var="endUserInstance">
                <li class="user${(i == 0) ? ' active' : ''}" data-user-id="${endUserInstance.id}">${endUserInstance.toString()}</li>
            </g:each>
        </g:if>
    </ul>
</section>
<section class="inline" id="right">
    <div class="header">
        <input text='text' name="message-search" id="message-search" placeholder="Search For Messages...">
        <button id="delete" class="btn btn-primary">Delete</button>
        <a href="#message-modal" role="button" class="btn btn-primary" data-toggle="modal"
           id="new-message">New Message</a>
    </div>
    <g:if test="${messageInstanceTotal > 0}">
        <ul id="message-thread" class="unstyled">
            <g:each in="${messageInstanceList.sort { a, b -> a.sent.compareTo(b.sent) }}" status="i" var="messageInstance">
                <g:set var="messageInstance" value="${messageInstance}" scope="page" />
                <g:set var="create" value="${false}" scope="page" />

                <li class='separator'>
                    <div class='subject'>${fieldValue(bean: messageInstance, field: "subject")}</div>
                    <ul class='unstyled' data-message-id="${messageInstance.id}">
                        <li class="message round4${((String) messageInstance.owner).equals(session.user.toString()) ? ' owner' : ' other-user'}">
                            <div class='sender'>${messageInstance.owner.toString()}</div>

                            <div class='details'>${fieldValue(bean: messageInstance, field: "details")}</div>
                        </li>
                    %{--Message Responses--}%
                        <g:if test="${messageInstance.responses}">
                            <g:each in="${messageInstance.responses.sort { a, b -> a.sent.compareTo(b.sent) }}" var="responseInstance">
                                <li class="message round4${((String) responseInstance.owner).equals(session.user.toString()) ? ' owner' : ' other-user'}">
                                    <div class='sender'>${responseInstance.owner.toString()}</div>

                                    <div class='details'>${fieldValue(bean: responseInstance, field: "details")}</div>
                                </li>
                            </g:each>
                        </g:if>
                    </ul>
                </li>
            </g:each>
        </ul>

        <div id="respond">
            <!-- Put all this in a form -->
            <label for='new-subject' class="checkbox">
                <input type='checkbox' class="toggle-subject"> New Subject
            </label>
            <input type='text' id='new-subject' class='hidden' placeholder='Enter Subject'>
            <textarea rows='2' id="message-response" placeholder="Respond to latest message"></textarea>
            <button class='btn btn-primary instant-reply'>Reply</button>
        </div>
    </g:if>
    <g:else>
        <div class="span8 alert alert-info">Looks like you don't have any messages...</div>
    </g:else>
</section>