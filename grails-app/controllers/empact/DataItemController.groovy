package empact

import org.springframework.dao.DataIntegrityViolationException

class DataItemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [dataItemInstanceList: DataItem.list(params), dataItemInstanceTotal: DataItem.count()]
    }

    def create() {
        [dataItemInstance: new DataItem(params)]
    }

    def save() {
        def dataItemInstance = new DataItem(params)

        def f = request.getFile('file')

        def origname = f.getOriginalFilename()

        def ext = ""
        int i = origname.lastIndexOf('.');
        if (i > 0) {
            ext = origname.substring(i+1);
        }

        dataItemInstance.setDataType(ext)

        if (!dataItemInstance.save(flush: true)) {
            render(view: "create", model: [dataItemInstance: dataItemInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'dataItem.label', default: 'DataItem'), dataItemInstance.id])
        redirect(action: "show", id: dataItemInstance.id)
    }

    def show(Long id) {
        def dataItemInstance = DataItem.get(id)
        if (!dataItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dataItem.label', default: 'DataItem'), id])
            redirect(action: "list")
            return
        }

        [dataItemInstance: dataItemInstance]
    }

    def edit(Long id) {
        def dataItemInstance = DataItem.get(id)
        if (!dataItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dataItem.label', default: 'DataItem'), id])
            redirect(action: "list")
            return
        }

        [dataItemInstance: dataItemInstance]
    }

    def update(Long id, Long version) {

        def dataItemInstance = DataItem.get(id)


        if (!dataItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dataItem.label', default: 'DataItem'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (dataItemInstance.version > version) {
                dataItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'dataItem.label', default: 'DataItem')] as Object[],
                        "Another user has updated this DataItem while you were editing")
                render(view: "edit", model: [dataItemInstance: dataItemInstance])
                return
            }
        }


        def f = request.getFile('file')

        def origname = f.getOriginalFilename()

        def ext = ""
        int i = origname.lastIndexOf('.');
        if (i > 0) {
            ext = origname.substring(i+1);
        }

        dataItemInstance.setDataType(ext)

        dataItemInstance.properties = params





        if (!dataItemInstance.save(flush: true)) {
            render(view: "edit", model: [dataItemInstance: dataItemInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'dataItem.label', default: 'DataItem'), dataItemInstance.id])
        redirect(action: "show", id: dataItemInstance.id)
    }

    def delete(Long id) {
        def dataItemInstance = DataItem.get(id)
        if (!dataItemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dataItem.label', default: 'DataItem'), id])
            redirect(action: "list")
            return
        }

        try {
            dataItemInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'dataItem.label', default: 'DataItem'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'dataItem.label', default: 'DataItem'), id])
            redirect(action: "show", id: id)
        }
    }

    def download(long id){
        def dataItemInstance = DataItem.get(id)

        byte[] bytes = dataItemInstance.file

        if(bytes){
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=${dataItemInstance.name}.${dataItemInstance.dataType}")
            response.outputStream << bytes
            response.getOutputStream().flush()

        }

        else render "Error"

        redirect(action: "show", id:id)
    }
}
