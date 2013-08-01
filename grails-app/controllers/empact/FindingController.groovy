package empact

import org.springframework.dao.DataIntegrityViolationException

class FindingController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [findingInstanceList: Finding.list(params), findingInstanceTotal: Finding.count()]
    }

    def create() {
        [findingInstance: new Finding(params)]
    }

    def save() {
        def findingInstance = new Finding(params)
        if (!findingInstance.save(flush: true)) {
            render(view: "create", model: [findingInstance: findingInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'finding.label', default: 'Finding'), findingInstance.id])
        redirect(action: "show", id: findingInstance.id)
    }

    def show(Long id) {
        def findingInstance = Finding.get(id)
        if (!findingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'finding.label', default: 'Finding'), id])
            redirect(action: "list")
            return
        }

        [findingInstance: findingInstance]
    }

    def edit(Long id) {
        def findingInstance = Finding.get(id)
        if (!findingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'finding.label', default: 'Finding'), id])
            redirect(action: "list")
            return
        }

        [findingInstance: findingInstance]
    }

    def update(Long id, Long version) {
        def findingInstance = Finding.get(id)
        if (!findingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'finding.label', default: 'Finding'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (findingInstance.version > version) {
                findingInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'finding.label', default: 'Finding')] as Object[],
                        "Another user has updated this Finding while you were editing")
                render(view: "edit", model: [findingInstance: findingInstance])
                return
            }
        }

        findingInstance.properties = params

        if (!findingInstance.save(flush: true)) {
            render(view: "edit", model: [findingInstance: findingInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'finding.label', default: 'Finding'), findingInstance.id])
        redirect(action: "show", id: findingInstance.id)
    }

    def delete(Long id) {
        def findingInstance = Finding.get(id)
        if (!findingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'finding.label', default: 'Finding'), id])
            redirect(action: "list")
            return
        }

        try {
            findingInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'finding.label', default: 'Finding'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'finding.label', default: 'Finding'), id])
            redirect(action: "show", id: id)
        }
    }
}
