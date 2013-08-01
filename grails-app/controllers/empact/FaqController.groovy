package empact

import org.springframework.dao.DataIntegrityViolationException

class FaqController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [faqInstanceList: Faq.list(params), faqInstanceTotal: Faq.count()]
    }

    def create() {
        [faqInstance: new Faq(params)]
    }

    def save() {
        def faqInstance = new Faq(params)
        if (!faqInstance.save(flush: true)) {
            render(view: "create", model: [faqInstance: faqInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'faq.label', default: 'Faq'), faqInstance.id])
        redirect(action: "show", id: faqInstance.id)
    }

    def show(Long id) {
        def faqInstance = Faq.get(id)
        if (!faqInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'faq.label', default: 'Faq'), id])
            redirect(action: "list")
            return
        }

        [faqInstance: faqInstance]
    }

    def edit(Long id) {
        def faqInstance = Faq.get(id)
        if (!faqInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'faq.label', default: 'Faq'), id])
            redirect(action: "list")
            return
        }

        [faqInstance: faqInstance]
    }

    def update(Long id, Long version) {
        def faqInstance = Faq.get(id)
        if (!faqInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'faq.label', default: 'Faq'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (faqInstance.version > version) {
                faqInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'faq.label', default: 'Faq')] as Object[],
                        "Another user has updated this Faq while you were editing")
                render(view: "edit", model: [faqInstance: faqInstance])
                return
            }
        }

        faqInstance.properties = params

        if (!faqInstance.save(flush: true)) {
            render(view: "edit", model: [faqInstance: faqInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'faq.label', default: 'Faq'), faqInstance.id])
        redirect(action: "show", id: faqInstance.id)
    }

    def delete(Long id) {
        def faqInstance = Faq.get(id)
        if (!faqInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'faq.label', default: 'Faq'), id])
            redirect(action: "list")
            return
        }

        try {
            faqInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'faq.label', default: 'Faq'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'faq.label', default: 'Faq'), id])
            redirect(action: "show", id: id)
        }
    }
}
