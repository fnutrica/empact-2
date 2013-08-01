package empact

import org.springframework.dao.DataIntegrityViolationException

class ModeratorQuestionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [moderatorQuestionInstanceList: ModeratorQuestion.list(params), moderatorQuestionInstanceTotal: ModeratorQuestion.count()]
    }

    def create() {
        [moderatorQuestionInstance: new ModeratorQuestion(params)]
    }

    def save() {
        def moderatorQuestionInstance = new ModeratorQuestion(params)
        if (!moderatorQuestionInstance.save(flush: true)) {
            render(view: "create", model: [moderatorQuestionInstance: moderatorQuestionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'moderatorQuestion.label', default: 'ModeratorQuestion'), moderatorQuestionInstance.id])
        redirect(action: "show", id: moderatorQuestionInstance.id)
    }

    def saveMod() {
        def moderatorQuestionInstance = new ModeratorQuestion()

        if (session.user) {
            moderatorQuestionInstance.setEndUser(session.user)
            moderatorQuestionInstance.setEmail(session.user.email.toString())
            moderatorQuestionInstance.setQuestion(params.question)
            moderatorQuestionInstance.setName(session.user.toString())

            if (!moderatorQuestionInstance.save(flush: true)) {
                render(view: "create", model: [moderatorQuestionInstance: moderatorQuestionInstance])
                return
            }

            def messageInstance = new Message()
            messageInstance.setOwner(EndUser.findByUserName(session.user.userName))
            messageInstance.setSent(new Date())
            messageInstance.setSubject(session.user.toString() + " has asked the moderator a question.")
            messageInstance.setDetails(moderatorQuestionInstance.question.toString())

            if (!messageInstance.save(flush: true)) {
                render(view: "create", model: [messageInstance: messageInstance])
                return
            }

            def user = session.user
            def recipient = EndUser.findAllByUserType(UserType.findByName("Moderator"))


            for (EndUser endUser : recipient) {
                def conversationInstanceOne = Conversation.findByRecipientAndOwner(endUser, user)
                def conversationInstanceTwo = Conversation.findByOwnerAndRecipient(endUser, user)
                def conversationInstance

                // Check if users already have a conversation
                if (conversationInstanceOne) {
                    conversationInstance = conversationInstanceOne
                } else if (conversationInstanceTwo) {
                    conversationInstance = conversationInstanceTwo
                } else {
                    conversationInstance = new Conversation()
                }

                conversationInstance.setOwner(user)
                conversationInstance.setIsRead(false)
                conversationInstance.setRecipient(endUser)
                conversationInstance.addToMessages(messageInstance)
                conversationInstance.setUpdated(new Date())

                if (!conversationInstance.save(flush: true)) {
                    render(view: "create", model: [messageInstance: messageInstance])
                    return
                }

            }
        } else {
            moderatorQuestionInstance.setEndUser(EndUser.findByUserName("GuestBot"))
            moderatorQuestionInstance.setEmail(params.email)
            moderatorQuestionInstance.setName(params.name)
            moderatorQuestionInstance.setQuestion(params.question)

            if (!moderatorQuestionInstance.save(flush: true)) {
                render(view: "create", model: [moderatorQuestionInstance: moderatorQuestionInstance])
                return
            }

            def messageInstance = new Message()
            messageInstance.setOwner(EndUser.findByUserName("GuestBot"))
            messageInstance.setSent(new Date())
            messageInstance.setSubject(params.name + " has asked the moderator a question.")
            messageInstance.setDetails(moderatorQuestionInstance.question.toString())

            if (!messageInstance.save(flush: true)) {
                render(view: "create", model: [messageInstance: messageInstance])
                return
            }

            def user = EndUser.findByUserName("GuestBot")
            def recipient = EndUser.findAllByUserType(UserType.findByName("Moderator"))


            for (EndUser endUser : recipient) {
                def conversationInstanceOne = Conversation.findByRecipientAndOwner(endUser, user)
                def conversationInstanceTwo = Conversation.findByOwnerAndRecipient(endUser, user)
                def conversationInstance

                // Check if users already have a conversation
                if (conversationInstanceOne) {
                    conversationInstance = conversationInstanceOne
                } else if (conversationInstanceTwo) {
                    conversationInstance = conversationInstanceTwo
                } else {
                    conversationInstance = new Conversation()
                }

                conversationInstance.setOwner(user)
                conversationInstance.setIsRead(false)
                conversationInstance.setRecipient(endUser)
                conversationInstance.addToMessages(messageInstance)
                conversationInstance.setUpdated(new Date())

                if (!conversationInstance.save(flush: true)) {
                    render(view: "create", model: [messageInstance: messageInstance])
                    return
                }

            }
        }
        flash.message = message(code: 'default.created.message', args: [message(code: 'moderatorQuestion.label', default: 'ModeratorQuestion'), moderatorQuestionInstance.id])
        redirect(uri:'/')


    }

    def show(Long id) {
        def moderatorQuestionInstance = ModeratorQuestion.get(id)
        if (!moderatorQuestionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'moderatorQuestion.label', default: 'ModeratorQuestion'), id])
            redirect(action: "list")
            return
        }

        [moderatorQuestionInstance: moderatorQuestionInstance]
    }

    def edit(Long id) {
        def moderatorQuestionInstance = ModeratorQuestion.get(id)
        if (!moderatorQuestionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'moderatorQuestion.label', default: 'ModeratorQuestion'), id])
            redirect(action: "list")
            return
        }

        [moderatorQuestionInstance: moderatorQuestionInstance]
    }

    def update(Long id, Long version) {
        def moderatorQuestionInstance = ModeratorQuestion.get(id)
        if (!moderatorQuestionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'moderatorQuestion.label', default: 'ModeratorQuestion'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (moderatorQuestionInstance.version > version) {
                moderatorQuestionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'moderatorQuestion.label', default: 'ModeratorQuestion')] as Object[],
                        "Another user has updated this ModeratorQuestion while you were editing")
                render(view: "edit", model: [moderatorQuestionInstance: moderatorQuestionInstance])
                return
            }
        }

        moderatorQuestionInstance.properties = params

        if (!moderatorQuestionInstance.save(flush: true)) {
            render(view: "edit", model: [moderatorQuestionInstance: moderatorQuestionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'moderatorQuestion.label', default: 'ModeratorQuestion'), moderatorQuestionInstance.id])
        redirect(action: "show", id: moderatorQuestionInstance.id)
    }

    def delete(Long id) {
        def moderatorQuestionInstance = ModeratorQuestion.get(id)
        if (!moderatorQuestionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'moderatorQuestion.label', default: 'ModeratorQuestion'), id])
            redirect(action: "list")
            return
        }

        try {
            moderatorQuestionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'moderatorQuestion.label', default: 'ModeratorQuestion'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'moderatorQuestion.label', default: 'ModeratorQuestion'), id])
            redirect(action: "show", id: id)
        }
    }
}
