package empact

import org.springframework.dao.DataIntegrityViolationException

class ConceptNoteController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if (session.user) {
            def user = EndUser.get(session.user.id)
            [
                    user : user,
                    userType : user.userType.name,
                    conceptNoteInstanceList: ConceptNote.list(params),
                    conceptNoteInstanceTotal: ConceptNote.count()
            ]
        }
        [
                conceptNoteInstanceList: ConceptNote.list(params),
                conceptNoteInstanceTotal: ConceptNote.count()
        ]

    }

    def create() {
        [conceptNoteInstance: new ConceptNote(params)]
    }

    def save() {
        def conceptNoteInstance = new ConceptNote(params)
        if (!conceptNoteInstance.save(flush: true)) {
            render(view: "create", model: [conceptNoteInstance: conceptNoteInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'conceptNote.label', default: 'ConceptNote'), conceptNoteInstance.id])
        redirect(action: "show", id: conceptNoteInstance.id)
    }

    def show(Long id) {
        def conceptNoteInstance = ConceptNote.get(id)
        if (!conceptNoteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'conceptNote.label', default: 'ConceptNote'), id])
            redirect(action: "list")
            return
        }

        [conceptNoteInstance: conceptNoteInstance]
    }

    def edit(Long id) {
        def conceptNoteInstance = ConceptNote.get(id)
        if (!conceptNoteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'conceptNote.label', default: 'ConceptNote'), id])
            redirect(action: "list")
            return
        }

        [conceptNoteInstance: conceptNoteInstance]
    }

    def update(Long id, Long version) {
        def conceptNoteInstance = ConceptNote.get(id)
        if (!conceptNoteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'conceptNote.label', default: 'ConceptNote'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (conceptNoteInstance.version > version) {
                conceptNoteInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'conceptNote.label', default: 'ConceptNote')] as Object[],
                          "Another user has updated this ConceptNote while you were editing")
                render(view: "edit", model: [conceptNoteInstance: conceptNoteInstance])
                return
            }
        }

        conceptNoteInstance.properties = params

        if (!conceptNoteInstance.save(flush: true)) {
            render(view: "edit", model: [conceptNoteInstance: conceptNoteInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'conceptNote.label', default: 'ConceptNote'), conceptNoteInstance.id])
        redirect(action: "show", id: conceptNoteInstance.id)
    }

    def delete(Long id) {
        def conceptNoteInstance = ConceptNote.get(id)
        if (!conceptNoteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'conceptNote.label', default: 'ConceptNote'), id])
            redirect(action: "list")
            return
        }

        try {
            conceptNoteInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'conceptNote.label', default: 'ConceptNote'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'conceptNote.label', default: 'ConceptNote'), id])
            redirect(action: "show", id: id)
        }
    }
}
