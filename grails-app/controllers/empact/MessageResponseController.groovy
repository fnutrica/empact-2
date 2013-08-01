package empact

import org.springframework.dao.DataIntegrityViolationException

class MessageResponseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [messageResponseInstanceList: MessageResponse.list(params), messageResponseInstanceTotal: MessageResponse.count()]
    }

    def create() {
        [messageResponseInstance: new MessageResponse(params)]
    }

    def save() {
        def messageResponseInstance = new MessageResponse(params)
        if (!messageResponseInstance.save(flush: true)) {
            render(view: "create", model: [messageResponseInstance: messageResponseInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'messageResponse.label', default: 'MessageResponse'), messageResponseInstance.id])
        redirect(action: "show", id: messageResponseInstance.id)
    }

    def show(Long id) {
        def messageResponseInstance = MessageResponse.get(id)
        if (!messageResponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'messageResponse.label', default: 'MessageResponse'), id])
            redirect(action: "list")
            return
        }

        [messageResponseInstance: messageResponseInstance]
    }

    def edit(Long id) {
        def messageResponseInstance = MessageResponse.get(id)
        if (!messageResponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'messageResponse.label', default: 'MessageResponse'), id])
            redirect(action: "list")
            return
        }

        [messageResponseInstance: messageResponseInstance]
    }

    def update(Long id, Long version) {
        def messageResponseInstance = MessageResponse.get(id)
        if (!messageResponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'messageResponse.label', default: 'MessageResponse'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (messageResponseInstance.version > version) {
                messageResponseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'messageResponse.label', default: 'MessageResponse')] as Object[],
                        "Another user has updated this MessageResponse while you were editing")
                render(view: "edit", model: [messageResponseInstance: messageResponseInstance])
                return
            }
        }

        messageResponseInstance.properties = params

        if (!messageResponseInstance.save(flush: true)) {
            render(view: "edit", model: [messageResponseInstance: messageResponseInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'messageResponse.label', default: 'MessageResponse'), messageResponseInstance.id])
        redirect(action: "show", id: messageResponseInstance.id)
    }

    def delete(Long id) {
        def messageResponseInstance = MessageResponse.get(id)
        if (!messageResponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'messageResponse.label', default: 'MessageResponse'), id])
            redirect(action: "list")
            return
        }

        try {
            messageResponseInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'messageResponse.label', default: 'MessageResponse'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'messageResponse.label', default: 'MessageResponse'), id])
            redirect(action: "show", id: id)
        }
    }
}
