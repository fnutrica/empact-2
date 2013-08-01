package empact

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class SuggestedUserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [suggestedUserInstanceList: SuggestedUser.list(params), suggestedUserInstanceTotal: SuggestedUser.count()]
    }

    def create() {
        [suggestedUserInstance: new SuggestedUser(params)]
    }

    def suggest() {
        def projectInstance = Project.get(params.project_id)
        if (!projectInstance) {
            render([ok: false, error: 'Could not find project'] as JSON)
            return
        }

        // Here we subtract 3 from params because there are three parameters that we do not care about: [project_id, action, controller]
        for (int i = 0; i < (getParams().size() - 3); i++) {
            def endUserInstance = EndUser.get(params.get("users[" + i + "]"))
            def suggestedUserInstance = new SuggestedUser(
                    version: 0,
                    user: endUserInstance,
                    approved: false,
                    project: projectInstance
            )

            if (!suggestedUserInstance.save(flush: true)) {
                render([ok: false, error: 'Could not save user'] as JSON)
                return
            }

            // Mark the request as suggested
            def projectRequestInstance = ProjectRequest.findByOwnerAndProject(endUserInstance, projectInstance)
            if (!projectRequestInstance) {
                render([ok: false, error: 'Could not find project request'] as JSON)
                return
            }

            projectRequestInstance.setSuggested(true)
            if (!projectRequestInstance.save(flush: true)) {
                render([ok: false, error: 'Could not save project request'] as JSON)
                return
            }
        }

        // Notify project owner through a message
        /*
        if (!projectInstance.owner.toString().equals(session.user.toString())) {
            def messageInstance = new Message()
            messageInstance.setOwner(session.user)
            messageInstance.setSent(new Date())
            messageInstance.setSubject(session.user.toString() + " has posted a reply to your thread.")
            messageInstance.setDetails(threadResp.details)


            if (!messageInstance.save(flush: true)) {
                render(view: "create", model: [messageInstance: messageInstance])
                return
            }

            def forum = EndUser.findByUserName("forum")
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
        */

        render([ok: true] as JSON)
    }

    def save() {
        def suggestedUserInstance = new SuggestedUser(params)
        if (!suggestedUserInstance.save(flush: true)) {
            render(view: "create", model: [suggestedUserInstance: suggestedUserInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'suggestedUser.label', default: 'SuggestedUser'), suggestedUserInstance.id])
        redirect(action: "show", id: suggestedUserInstance.id)
    }

    def show(Long id) {
        def suggestedUserInstance = SuggestedUser.get(id)
        if (!suggestedUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'suggestedUser.label', default: 'SuggestedUser'), id])
            redirect(action: "list")
            return
        }

        [suggestedUserInstance: suggestedUserInstance]
    }

    def edit(Long id) {
        def suggestedUserInstance = SuggestedUser.get(id)
        if (!suggestedUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'suggestedUser.label', default: 'SuggestedUser'), id])
            redirect(action: "list")
            return
        }

        [suggestedUserInstance: suggestedUserInstance]
    }

    def update(Long id, Long version) {
        def suggestedUserInstance = SuggestedUser.get(id)
        if (!suggestedUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'suggestedUser.label', default: 'SuggestedUser'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (suggestedUserInstance.version > version) {
                suggestedUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'suggestedUser.label', default: 'SuggestedUser')] as Object[],
                        "Another user has updated this SuggestedUser while you were editing")
                render(view: "edit", model: [suggestedUserInstance: suggestedUserInstance])
                return
            }
        }

        suggestedUserInstance.properties = params

        if (!suggestedUserInstance.save(flush: true)) {
            render(view: "edit", model: [suggestedUserInstance: suggestedUserInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'suggestedUser.label', default: 'SuggestedUser'), suggestedUserInstance.id])
        redirect(action: "show", id: suggestedUserInstance.id)
    }

    def delete(Long id) {
        def suggestedUserInstance = SuggestedUser.get(id)
        if (!suggestedUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'suggestedUser.label', default: 'SuggestedUser'), id])
            redirect(action: "list")
            return
        }

        try {
            suggestedUserInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'suggestedUser.label', default: 'SuggestedUser'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'suggestedUser.label', default: 'SuggestedUser'), id])
            redirect(action: "show", id: id)
        }
    }
}
