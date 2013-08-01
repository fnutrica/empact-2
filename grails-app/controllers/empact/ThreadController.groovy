package empact

import org.springframework.dao.DataIntegrityViolationException

class ThreadController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [threadInstanceList: Thread.list(params), threadInstanceTotal: Thread.count()]
    }

    def create() {
        [threadInstance: new Thread(params)]
    }

    def save() {
        def threadInstance = new Thread(params)

        threadInstance.setThreadOwner(session.user)
        threadInstance.setCreated(new Date())
        if (!threadInstance.save(flush: true)) {
            render(view: "create", model: [threadInstance: threadInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'thread.label', default: 'Thread'), threadInstance.id])
        redirect(action: "show", id: threadInstance.id)
    }

    def show(Long id) {
        def threadInstance = Thread.get(id)
//        threadInstance.responses.sort {threadInstance.responses.created}
        if (!threadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'thread.label', default: 'Thread'), id])
            redirect(action: "list")
            return
        }

        [threadInstance: threadInstance, threadInstanceList: Thread.list()]
    }

    def edit(Long id) {
        def threadInstance = Thread.get(id)
        if (!threadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'thread.label', default: 'Thread'), id])
            redirect(action: "list")
            return
        }

        [threadInstance: threadInstance]
    }

    def update(Long id, Long version) {
        def threadInstance = Thread.get(id)
        if (!threadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'thread.label', default: 'Thread'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (threadInstance.version > version) {
                threadInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'thread.label', default: 'Thread')] as Object[],
                        "Another user has updated this Thread while you were editing")
                render(view: "edit", model: [threadInstance: threadInstance])
                return
            }
        }

        threadInstance.properties = params

        if (!threadInstance.save(flush: true)) {
            render(view: "edit", model: [threadInstance: threadInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'thread.label', default: 'Thread'), threadInstance.id])
        redirect(action: "show", id: threadInstance.id)
    }

    def delete(Long id) {
        def threadInstance = Thread.get(id)
        if (!threadInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'thread.label', default: 'Thread'), id])
            redirect(action: "list")
            return
        }

        try {
            threadInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'thread.label', default: 'Thread'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'thread.label', default: 'Thread'), id])
            redirect(action: "show", id: id)
        }
    }

    def deleteResponse(Long id) {
        def responseInstance = ThreadResponse.get(id)
        def threadInstance = responseInstance.thread

        if(threadInstance){
            threadInstance.removeFromResponses(responseInstance)
            threadInstance.save(flush: true)

            redirect(action: "show", id: responseInstance.ownerId)
        }
    }

    def saveResponse(Long id) {

        String d1
        def threadResp = new ThreadResponse()
        threadResp.setDetails(params.details)
        threadResp.setOwner(session.user)
        threadResp.setCreated(new Date())
        threadResp.save(flush: true)

        def threadinst = Thread.get(id)
        threadinst.addToResponses(threadResp)

        // If save ...
        threadinst.save(flush: true)

        if (!threadinst.threadOwner.toString().equals(session.user.toString())) {
            def forum = EndUser.findByUserName("ForumBot")
            def messageInstance = new Message()
            messageInstance.setOwner(forum)
            messageInstance.setSent(new Date())
            messageInstance.setSubject(session.user.toString() + " has posted a reply to your thread.")
            messageInstance.setDetails(threadResp.details)


            if (!messageInstance.save(flush: true)) {
                render(view: "create", model: [messageInstance: messageInstance])
                return
            }


            def recipient = threadResp.thread.threadOwner

            def conversationInstanceOne = Conversation.findByRecipientAndOwner(recipient, forum)
            def conversationInstanceTwo = Conversation.findByOwnerAndRecipient(recipient, forum)
            def conversationInstance

            // Check if users already have a conversation
            if (conversationInstanceOne) {
                conversationInstance = conversationInstanceOne
            } else if (conversationInstanceTwo) {
                conversationInstance = conversationInstanceTwo
            } else {
                conversationInstance = new Conversation()
            }

            conversationInstance.setOwner(forum)
            conversationInstance.setIsRead(false)
            conversationInstance.setRecipient(recipient)
            conversationInstance.addToMessages(messageInstance)
            conversationInstance.setUpdated(new Date())

            if (!conversationInstance.save(flush: true)) {
                render(view: "create", model: [messageInstance: messageInstance])
                return
            }
        }

        if(threadResp){
            redirect(action: "show", id: id)
        }
        else render "fuck off"

    }
}
