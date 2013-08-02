package empact

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class EndUserController {

    def index() {
        redirect(action: "list", params: params)
    }

    def login = {}

    def authenticate = {
        def user = EndUser.findByUserNameAndPassword(params.userName, params.password)

        if (user) {
            if (!(user.userType.toString().equals("Moderator") || user.userType.toString().equals("Superuser")) && !user.verified) {
                flash.message = "Sorry, ${user.toString()}. It looks like our moderator has not approved your account yet."
                redirect(action: "login")
            } else {
                session.user = user
                flash.message = "Hello ${user.toString()}!"
                redirect(controller: "project", action: "list")
            }

        } else {
            flash.message = "Sorry, ${params.userName}. Please try again."
            redirect(action: "login")
        }
    }

    def logout = {
        flash.message = "Goodbye ${session.user.toString()}"
        session.user = null
        redirect(action: "login")
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [endUserInstanceList: EndUser.list(params), endUserInstanceTotal: EndUser.count()]
    }

    def create() {
        [endUserInstance: new EndUser(params)]
    }

    def additionalInfo(Long id) {
        render(
                template: 'usertype',
                model: [
                        type: UserType.get(id).name
                ]
        )
    }

    def save() {
        def endUserInstance = new EndUser(params)

        if (!endUserInstance.save(flush: true)) {
            render(view: "create", model: [endUserInstance: endUserInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'endUser.label', default: 'EndUser'), endUserInstance.id])
        redirect(action: "show", id: endUserInstance.id)
    }

    def manage(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [endUserInstanceList: EndUser.list(params), endUserInstanceTotal: EndUser.count()]
    }

    def ajaxDelete(Long id) {
        def endUserInstance = EndUser.get(id)


        if (!endUserInstance) {
            // flash.message = message(code: 'default.not.found.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            // redirect(action: "list")
            render([ok: false, error: 'Could not find user.'] as JSON)
            return
        }

        try {
            endUserInstance.delete(flush: true)
            // flash.message = message(code: 'default.deleted.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            render([ok: true, msg: endUserInstance.toString() + " successfully deleted."] as JSON)
        }
        catch (DataIntegrityViolationException e) {
            // flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            render([ok: false, error: e.toString()] as JSON)
        }
    }

    def previewInList(Long id) {
        def endUserInstance = EndUser.get(id)
        if (!endUserInstance) {
            // Some error here
            return
        }
        render(
                template: 'previewInList',
                model: [
                        endUserInstance: endUserInstance
                ]
        )
    }

    def verify() {
        def analystInstanceList = EndUser.findAllByVerifiedAndUserType(false, UserType.findByName("Student Analyst"), [sort:"firstName", order:"asc"])
        def expertInstanceList = EndUser.findAllByVerifiedAndUserType(false, UserType.findByName("Expert"), [sort:"firstName", order:"asc"])
        def whoInstanceList = EndUser.findAllByVerifiedAndUserType(false, UserType.findByName("WHO Official"), [sort:"firstName", order:"asc"])
        def countryInstanceList = EndUser.findAllByVerifiedAndUserType(false, UserType.findByName("Country Official"), [sort:"firstName", order:"asc"])
        def ngoInstanceList = EndUser.findAllByVerifiedAndUserType(false, UserType.findByName("NGO Official"), [sort:"firstName", order:"asc"])

        [
                analysts: analystInstanceList,
                analystsTotal: (analystInstanceList ? analystInstanceList.size() : 0),
                experts: expertInstanceList,
                expertsTotal: (expertInstanceList ? expertInstanceList.size() : 0),
                whoOfficials: whoInstanceList,
                whoOfficialsTotal: (whoInstanceList ? whoInstanceList.size() : 0),
                countryOfficials: countryInstanceList,
                countryOfficialsTotal: (countryInstanceList ? countryInstanceList.size() : 0),
                ngoOfficials: ngoInstanceList,
                ngoOfficialsTotal: (ngoInstanceList ? ngoInstanceList.size() : 0)
        ]
    }

    def preview(Long id, String userType) {
        def endUserInstance = EndUser.get(id)
        if (!endUserInstance) {
            // Some error here
            return
        }
        if (userType.equals("student-analyst")) {
            if (endUserInstance.mentorEmail) {
                def mentorInstance = EndUser.findByEmail(endUserInstance.mentorEmail)
                if (!mentorInstance) {
                    render(
                            template: 'preview',
                            model: [
                                    endUserInstance: endUserInstance,
                                    userType: userType,
                                    hasMentor: false
                            ]
                    )
                    return
                }
                render(
                        template: 'preview',
                        model: [
                                endUserInstance: endUserInstance,
                                mentorInstance: mentorInstance,
                                userType: userType,
                                hasMentor: true
                        ]
                )
                return
            }
            render(
                    template: 'preview',
                    model: [
                            endUserInstance: endUserInstance,
                            userType: userType,
                            hasMentor: false
                    ]
            )
            return
        }
        render(
                template: 'preview',
                model: [
                        endUserInstance: endUserInstance,
                        userType: userType
                ]
        )
    }

    def approve(Long id) {
        def endUserInstance = EndUser.get(id)
        if (!endUserInstance) {
            render([ok: true, error: "User could not be found"] as JSON)
            return
        }

        // Approve the user
        endUserInstance.setVerified(true)
        if (!endUserInstance.save(flush: true)) {
            render([ok: true, error: "User could not be saved"] as JSON)
            return
        }

        // If the user is an analyst, find the analyst's mentor and approve them too
        if (params.get('userType').equals('student-analyst')) {
            def mentorInstance = EndUser.get(params.get('mentorId'))
            if (!mentorInstance) {
                render([ok: true, error: "Mentor could not be found"] as JSON)
                return
            }

            if (!mentorInstance.verified) {
                mentorInstance.setVerified(true)

                if (!mentorInstance.save(flush: true)) {
                    render([ok: true, error: "Mentor could not be saved"] as JSON)
                    return
                }
            }
        }

        // TODO: Send the user a message

        render([ok: true, msg: "User verified"] as JSON)
    }

    def show(Long id) {

        def endUserInstance = EndUser.get(id)

        if (!endUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            redirect(action: "list")
            return
        }
        [endUserInstance: endUserInstance]
    }

    def edit(Long id) {
        def endUserInstance = EndUser.get(id)
        if (!endUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            redirect(action: "list")
            return
        }

        [endUserInstance: endUserInstance]
    }

    def update(Long id, Long version) {
        def endUserInstance = EndUser.get(id)
        if (!endUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (endUserInstance.version > version) {
                endUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'endUser.label', default: 'EndUser')] as Object[],
                        "Another user has updated this EndUser while you were editing")
                render(view: "edit", model: [endUserInstance: endUserInstance])
                return
            }
        }

        endUserInstance.properties = params

        if (!endUserInstance.save(flush: true)) {
            render(view: "edit", model: [endUserInstance: endUserInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'endUser.label', default: 'EndUser'), endUserInstance.id])
        redirect(action: "show", id: endUserInstance.id)
    }

    def delete(Long id) {
        def endUserInstance = EndUser.get(id)


        if (!endUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            redirect(action: "list")
            return
        }

        try {
            endUserInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'endUser.label', default: 'EndUser'), id])
            redirect(action: "show", id: id)
        }
    }

    def userInfo(Long id) {
        def userInstance = EndUser.get(id);


        if (!userInstance) {
            return      // All we should do for now, more later
        }

        render(template: 'userInfo', userInstance: userInstance)
    }

    def upload() {
        // Session.evict()
        def userInstance = session.user

        def f = request.getFile('myFile')

        if (f.empty) {
            flash.message = 'file cannot be empty'
            render(view: 'uploadForm')
            return
        }
        def origname = f.getOriginalFilename()

        def ext
        int i = origname.lastIndexOf('.');
        if (i > 0) {
            ext = origname.substring(i+1);
        }

        f.transferTo(new File("web-app/images/${userInstance.userName}-avatar.${ext}"))

        userInstance.avatarType = f.getContentType()
        userInstance.setAvataraddress("${userInstance.userName}-avatar.${ext}")
        userInstance.save()

        redirect(action: "show", id: userInstance.id)
        //${userInstance.userName}-avatar.${arr[ind]}

    }

    def displayImage(){
        def userInstance = session.user
        def something = resource(dir: 'images', file: "${userInstance.avataraddress}")
        response.contentType = "${userInstance.avatarType}"
        response.outputStream << something
        response.outputStream.flush()
    }

    def uploadResume(Long id) {

        def userInstance = EndUser.get(id)

        def g = request.getFile("myResume")


        if (g.empty) {
            flash.message = 'file cannot be empty'
            render(view: 'uploadForm')
            return
        }
        def origname = g.getOriginalFilename()



        def ext
        int i = origname.lastIndexOf('.');
        if (i > 0) {
            ext = origname.substring(i + 1);
        }

        userInstance.setResumeType(ext)

        InputStream file = g.inputStream
        byte[] bytes = file.bytes


        userInstance.file = bytes



        userInstance.save(flush:true)

        redirect(action: "list", controller: "endUser")

    }

    def downloadResume(long id) {

        def userInstance = EndUser.get(id)

        byte[] bytes = userInstance.file

        if (bytes) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=${userInstance.toString()}-resume.${userInstance.resumeType}")
            response.outputStream << bytes
            response.getOutputStream().flush()

        } else render "Error"

        redirect(action: "show", id: id)

    }

}
