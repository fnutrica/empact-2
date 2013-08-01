package empact

import org.springframework.dao.DataIntegrityViolationException

class ThreadResponseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [threadResponseInstanceList: ThreadResponse.list(params), threadResponseInstanceTotal: ThreadResponse.count()]
    }

    def create() {
        [threadResponseInstance: new ThreadResponse(params)]
    }

    def save() {
        def threadResponseInstance = new ThreadResponse(params)
        threadResponseInstance.setOwner(session.user)

        if (!threadResponseInstance.save(flush: true)) {
            render(view: "create", model: [threadResponseInstance: threadResponseInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'threadResponse.label', default: 'ThreadResponse'), threadResponseInstance.id])
        redirect(action: "show", id: threadResponseInstance.id)
    }

    def show(Long id) {
        def threadResponseInstance = ThreadResponse.get(id)
        if (!threadResponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'threadResponse.label', default: 'ThreadResponse'), id])
            redirect(action: "list")
            return
        }

        [threadResponseInstance: threadResponseInstance]
    }

    def edit(Long id) {
        def threadResponseInstance = ThreadResponse.get(id)
        if (!threadResponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'threadResponse.label', default: 'ThreadResponse'), id])
            redirect(action: "list")
            return
        }

        [threadResponseInstance: threadResponseInstance]
    }

    def update(Long id, Long version) {
        def threadResponseInstance = ThreadResponse.get(id)
        if (!threadResponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'threadResponse.label', default: 'ThreadResponse'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (threadResponseInstance.version > version) {
                threadResponseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'threadResponse.label', default: 'ThreadResponse')] as Object[],
                        "Another user has updated this ThreadResponse while you were editing")
                render(view: "edit", model: [threadResponseInstance: threadResponseInstance])
                return
            }
        }

        threadResponseInstance.properties = params

        if (!threadResponseInstance.save(flush: true)) {
            render(view: "edit", model: [threadResponseInstance: threadResponseInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'threadResponse.label', default: 'ThreadResponse'), threadResponseInstance.id])
        redirect(action: "show", id: threadResponseInstance.id)
    }

    def delete(Long id) {
        def threadResponseInstance = ThreadResponse.get(id)
        if (!threadResponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'threadResponse.label', default: 'ThreadResponse'), id])
            redirect(action: "list")
            return
        }

        try {
            threadResponseInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'threadResponse.label', default: 'ThreadResponse'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'threadResponse.label', default: 'ThreadResponse'), id])
            redirect(action: "show", id: id)
        }
    }
}
