package empact

import org.springframework.dao.DataIntegrityViolationException

class DataRequestController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [dataRequestInstanceList: DataRequest.list(params), dataRequestInstanceTotal: DataRequest.count()]
    }

    def create() {
        [dataRequestInstance: new DataRequest(params)]
    }

    def save() {
        def dataRequestInstance = new DataRequest(params)
        if (!dataRequestInstance.save(flush: true)) {
            render(view: "create", model: [dataRequestInstance: dataRequestInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'dataRequest.label', default: 'DataRequest'), dataRequestInstance.id])
        redirect(action: "show", id: dataRequestInstance.id)
    }

    def saveReq() {
        def dataRequestInstance = new DataRequest()

        def projectInstance = Project.get(params.get("project.id"))

        if(!projectInstance){
            System.out.println("Fuck your face")
        }

        dataRequestInstance.setRequestor(session.user)
        dataRequestInstance.setRecipient(projectInstance.owner)
        dataRequestInstance.setSent(new Date())
        dataRequestInstance.setReason(params.reason)
        dataRequestInstance.setUploaded(false)


        if (!dataRequestInstance.save(flush: true)) {
            render(view: "create", model: [dataRequestInstance: dataRequestInstance])
            return
        }


        def messageInstance = new Message()
        messageInstance.setOwner(EndUser.findByUserName(session.user.userName))
        messageInstance.setSent(new Date())
        messageInstance.setSubject(session.user.toString() + "Has made a Request for Data")
        messageInstance.setDetails(dataRequestInstance.reason.toString())

        if (!messageInstance.save(flush: true)) {
            render(view: "create", model: [messageInstance: messageInstance])
            return
        }

        def user = session.user
        def recipient = dataRequestInstance.recipient

        def conversationInstanceOne = Conversation.findByRecipientAndOwner(recipient, user)
        def conversationInstanceTwo = Conversation.findByOwnerAndRecipient(recipient, user)
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
        conversationInstance.setRecipient(recipient)
        conversationInstance.addToMessages(messageInstance)
        conversationInstance.setUpdated(new Date())

        if (!conversationInstance.save(flush: true)) {
            render(view: "create", model: [messageInstance: messageInstance])
            return
        }

        redirect(controller: "project", action: "list")

    }

    def show(Long id) {
        def dataRequestInstance = DataRequest.get(id)
        if (!dataRequestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dataRequest.label', default: 'DataRequest'), id])
            redirect(action: "list")
            return
        }

        [dataRequestInstance: dataRequestInstance]
    }

    def edit(Long id) {
        def dataRequestInstance = DataRequest.get(id)
        if (!dataRequestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dataRequest.label', default: 'DataRequest'), id])
            redirect(action: "list")
            return
        }

        [dataRequestInstance: dataRequestInstance]
    }

    def update(Long id, Long version) {
        def dataRequestInstance = DataRequest.get(id)
        if (!dataRequestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dataRequest.label', default: 'DataRequest'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (dataRequestInstance.version > version) {
                dataRequestInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'dataRequest.label', default: 'DataRequest')] as Object[],
                        "Another user has updated this DataRequest while you were editing")
                render(view: "edit", model: [dataRequestInstance: dataRequestInstance])
                return
            }
        }

        dataRequestInstance.properties = params

        if (!dataRequestInstance.save(flush: true)) {
            render(view: "edit", model: [dataRequestInstance: dataRequestInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'dataRequest.label', default: 'DataRequest'), dataRequestInstance.id])
        redirect(action: "show", id: dataRequestInstance.id)
    }

    def delete(Long id) {
        def dataRequestInstance = DataRequest.get(id)
        if (!dataRequestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dataRequest.label', default: 'DataRequest'), id])
            redirect(action: "list")
            return
        }

        try {
            dataRequestInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'dataRequest.label', default: 'DataRequest'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'dataRequest.label', default: 'DataRequest'), id])
            redirect(action: "show", id: id)
        }
    }
}
