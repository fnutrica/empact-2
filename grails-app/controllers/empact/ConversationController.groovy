package empact

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class ConversationController {

//    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        def conversationInstanceList = Conversation.findAllByOwnerOrRecipient(session.user, session.user, [sort:"updated", order:"desc"])

        if (!conversationInstanceList) {
            [messageInstanceTotal: 0, endUserInstanceTotal: 0]
            return
        }
        def endUserInstanceList = new ArrayList<EndUser>()
        for (Conversation conversation : conversationInstanceList) {
            endUserInstanceList.add((conversation.owner.toString()).equals(session.user.toString()) ? conversation.recipient : conversation.owner)
        }

        def conversationInstance = conversationInstanceList?.first()

        [
                conversationInstance: conversationInstance,
                messageInstanceList: conversationInstance?.messages,
                messageInstanceTotal: conversationInstance?.messages?.size(),
                endUserInstanceList: endUserInstanceList,
                endUserInstanceTotal: endUserInstanceList.size()
        ]
    }

    def create() {
        [conversationInstance: new Conversation(params)]
    }

    def ajaxCreate() {
        def messageInstance = new Message(params)
        messageInstance.setOwner(session.user)
        messageInstance.setSent(new Date())

        if (!messageInstance.save(flush: true)) {
            render(view: "create", model: [messageInstance: messageInstance])
            return
        }

        def recipient = EndUser.get(params.recipient)
        def conversationInstanceOne = Conversation.findByRecipientAndOwner(session.user, recipient)
        def conversationInstanceTwo = Conversation.findByOwnerAndRecipient(session.user, recipient)
        def conversationInstance

        // Check if users already have a conversation
        if (conversationInstanceOne) {
            conversationInstance = conversationInstanceOne
        } else if (conversationInstanceTwo) {
            conversationInstance = conversationInstanceTwo
        } else {
            conversationInstance = new Conversation()
        }

        conversationInstance.setOwner(session.user)
        conversationInstance.setIsRead(false)
        conversationInstance.setRecipient(recipient)
        conversationInstance.addToMessages(messageInstance)
        conversationInstance.setUpdated(new Date())

        if (!conversationInstance.save(flush: true)) {
            render(view: "create", model: [messageInstance: messageInstance])
            return
        }

        // Get all conversations a.k.a refresh inbox
        renderInbox()

    }

    def createInPlace() {
        def tempMessageInstance = Message.get(params.message_id)
        if (!tempMessageInstance) {
            // Print out error here
            return
        }
        // params.remove('message_id')
        def messageInstance = new Message(params)
        messageInstance.setOwner(session.user)
        messageInstance.setSent(new Date())

        if (!messageInstance.save(flush: true)) {
            render(view: "create", model: [messageInstance: messageInstance])
            return
        }

        def tempConversationInstance = Conversation.executeQuery("FROM Conversation c WHERE ? IN elements(c.messages) ", tempMessageInstance)

        // This check is kinda useless, but hey it has to be there
        if (!tempConversationInstance) {
            // Return some error here
            return
        }
        def conversationInstance = tempConversationInstance?.first()
        def own = conversationInstance?.owner
        def receive = conversationInstance?.recipient

        conversationInstance?.addToMessages(messageInstance)
        conversationInstance?.setIsRead(false)

        // If the logged in user is the owner of the message then the recipient is going to be the owner otherwise...
        conversationInstance?.setRecipient(conversationInstance?.owner?.toString().equals(session.user.toString()) ? receive : own)
        conversationInstance?.setOwner(session.user)
        conversationInstance?.setUpdated(new Date())

        if (!conversationInstance.save(flush: true)) {
            // Generate some error here
            return
        }

        renderInbox()
    }

    def getConversation(Long id) {
        def endUserInstance = EndUser.get(id)
        def conversationInstanceOne = Conversation.findByOwnerAndRecipient(endUserInstance, session.user)
        def conversationInstanceTwo = Conversation.findByOwnerAndRecipient(session.user, endUserInstance)
        def conversationInstance

        if (conversationInstanceOne) {
            conversationInstance = conversationInstanceOne
        } else if (conversationInstanceTwo) {
            conversationInstance = conversationInstanceTwo
        } else {
            // Show some error here
            render(
                    template: 'listitem',
                    model: [
                            messageInstanceTotal: 0,
                            endUserInstanceTotal: 0,
                            create: false,
                            is_dif_thread: true
                    ]
            )
            return
        }

        if (!conversationInstance.isRead && !conversationInstance.owner.toString().equals(session.user.toString())) {
            conversationInstance.setIsRead(true)

            if (!conversationInstance.save(flush: true)) {
                // Show some error here
                render(
                        template: 'listitem',
                        model: [
                                messageInstanceTotal: 0,
                                endUserInstanceTotal: 0,
                                create: false,
                                is_dif_thread: true
                        ]
                )
                return
            }
        }

        render(
                template: 'listitem',
                model: [
                        messageInstanceList: conversationInstance.messages,
                        messageInstanceTotal: conversationInstance?.messages?.size(),
                        messageInstanceOwner: endUserInstance,
                        create: false,
                        is_dif_thread: true
                ]
        )
    }

    def respond() {
        def messageInstance = Message.get(params.message_id)
        def responseInstance = new MessageResponse(params)
        responseInstance.setOwner(session.user)
        responseInstance.setSent(new Date())
        if (!responseInstance.save(flush: true)) {
            render([ok: false, error: "Response could not be saved"] as JSON)
            return
        }

        messageInstance.addToResponses(responseInstance)
        if (!messageInstance.save(flush: true)) {
            render([ok: false, error: "Message could not be saved"] as JSON)
            return
        }

        def tempConversationInstance = Conversation.executeQuery("FROM Conversation c WHERE ? IN elements(c.messages) ", messageInstance)

        // This check is kinda useless, but hey it has to be there
        if (!tempConversationInstance) {
            // Return some error here
            return
        }
        def conversationInstance = tempConversationInstance?.first()
        conversationInstance?.setIsRead(false)

        def receive = conversationInstance?.recipient

        // If the logged in user is the owner of the message then the recipient is going to be the owner otherwise...
        conversationInstance?.setRecipient(conversationInstance?.owner?.toString().equals(session.user.toString()) ? receive : conversationInstance?.owner)
        conversationInstance?.setOwner(session.user)
        conversationInstance?.setUpdated(new Date())

        if (!conversationInstance.save(flush: true)) {
            // Generate some error here
            return
        }

        renderInbox()
    }

    def save() {
        def conversationInstance = new Conversation(params)
        if (!conversationInstance.save(flush: true)) {
            render(view: "create", model: [conversationInstance: conversationInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'conversation.label', default: 'Conversation'), conversationInstance.id])
        redirect(action: "show", id: conversationInstance.id)
    }

    def show(Long id) {
        def conversationInstance = Conversation.get(id)
        if (!conversationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'conversation.label', default: 'Conversation'), id])
            redirect(action: "list")
            return
        }

        [conversationInstance: conversationInstance]
    }

    def edit(Long id) {
        def conversationInstance = Conversation.get(id)
        if (!conversationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'conversation.label', default: 'Conversation'), id])
            redirect(action: "list")
            return
        }

        [conversationInstance: conversationInstance]
    }

    def update(Long id, Long version) {
        def conversationInstance = Conversation.get(id)
        if (!conversationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'conversation.label', default: 'Conversation'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (conversationInstance.version > version) {
                conversationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'conversation.label', default: 'Conversation')] as Object[],
                        "Another user has updated this Conversation while you were editing")
                render(view: "edit", model: [conversationInstance: conversationInstance])
                return
            }
        }

        conversationInstance.properties = params

        if (!conversationInstance.save(flush: true)) {
            render(view: "edit", model: [conversationInstance: conversationInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'conversation.label', default: 'Conversation'), conversationInstance.id])
        redirect(action: "show", id: conversationInstance.id)
    }

    def delete(Long id) {
        def conversationInstance = Conversation.get(id)
        if (!conversationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'conversation.label', default: 'Conversation'), id])
            redirect(action: "list")
            return
        }

        try {
            conversationInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'conversation.label', default: 'Conversation'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'conversation.label', default: 'Conversation'), id])
            redirect(action: "show", id: id)
        }
    }

    private void renderInbox() {
        def conversationInstanceList = Conversation.findAllByOwnerOrRecipient(session.user, session.user, [sort:"updated", order:"desc"])

        if (!conversationInstanceList) {
            render(
                    template: 'inbox',
                    model: [
                            messageInstanceTotal: 0,
                            endUserInstanceTotal: 0
                    ]
            )
            return
        }
        def endUserInstanceList = new ArrayList<EndUser>()
        for (Conversation conversation : conversationInstanceList) {
            endUserInstanceList.add((conversation.owner.toString()).equals(session.user.toString()) ? conversation.recipient : conversation.owner)
        }

        def conversationInstance = conversationInstanceList?.first()

        render(
                template: 'inbox',
                model: [
                        conversationInstance: conversationInstance,
                        messageInstanceList: conversationInstance?.messages,
                        messageInstanceTotal: conversationInstance?.messages?.size(),
                        endUserInstanceList: endUserInstanceList,
                        endUserInstanceTotal: endUserInstanceList.size()
                ]
        )
    }
}
