package empact

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class ProjectController {

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def user = EndUser.get(session.user.id)
        [
                user: user,
                userType: user?.userType?.name,
                projectInstanceList: Project.list(params),
                projectInstanceTotal: Project.count(),
                modalType: ["newProject", "interested-modal"]
        ]
    }

    def create() {
        [projectInstance: new Project(params)]
    }

    def save() {
        def projectInstance = new Project(params)

        if(projectInstance){
        projectInstance.owner = session.user
        projectInstance.startDate = new Date()
        }
        if (!projectInstance.save(flush: true)) {
            render(view: "create", model: [projectInstance: projectInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'project.label', default: 'Project'), projectInstance.id])
        redirect(action: "show", id: projectInstance.id)
    }

    def show(Long id) {
        def projectInstance = Project.get(id)
        if (!projectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect(action: "list")
            return
        }

        def user = EndUser.get(session.user.id)
        [
                user: user,
                userType: user.userType.name,
                projectInstance: projectInstance
        ]
    }

    def edit(Long id) {
        def projectInstance = Project.get(id)
        if (!projectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect(action: "list")
            return
        }

        [projectInstance: projectInstance]
    }

    def showDesc(Long id) {
        def projectInstance = Project.get(id)
        if (!projectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
            return
        }
        render([description: projectInstance.description] as JSON)
    }

    def ajaxShow(Long id) {
        def projectInstance = Project.get(id)
        if (!projectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
            return
        }
        render(template: 'project', model: [projectInstance: projectInstance])
    }

    def mapMarkers() {
        def projectInstanceList = Project.list()
        def markerList = []

        if (!projectInstanceList) {
            render([ok: false] as JSON)
        }

        int index = 0
        for (Project project : projectInstanceList) {
            Country country = project.country
            markerList[index] = [
                    'country': project.name,
                    'lat': country.lat,
                    'lng': country.lng
            ]
            index++
        }

        render(markerList as JSON)
    }

    def ajaxUpdate(Long id) {
        def projectInstance = Project.get(id)
        if (!projectInstance) {
            render([ok: false, error: message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])] as JSON)
            return
        }

        projectInstance.properties = params

        if (!projectInstance.save(flush: true)) {
            render([ok: false, error: "Could not edit project"] as JSON)
            return
        }
        flash.message = message(code: 'default.updated.message', args: [message(code: 'project.label', default: 'Project'), projectInstance.id])
        render([ok: true] as JSON)
    }

    def update(Long id, Long version) {
        def projectInstance = Project.get(id)
        if (!projectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (projectInstance.version > version) {
                projectInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'project.label', default: 'Project')] as Object[],
                        "Another user has updated this Project while you were editing")
                render(view: "/project/edit", model: [projectInstance: projectInstance])
                return
            }
        }

        projectInstance.properties = params

        if (!projectInstance.save(flush: true)) {
            render(view: "/project/edit", model: [projectInstance: projectInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'project.label', default: 'Project'), projectInstance.id])
        redirect(action: "show", id: projectInstance.id)
    }

    def delete(Long id) {
        def projectInstance = Project.get(id)
        if (!projectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect(action: "list")
            return
        }

        try {
            projectInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect(action: "show", id: id)
        }
    }

    def myprojects(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def projectInstanceList
        def projectInstanceTotal = 0
        def user = EndUser.get(session.user.id)
        def userType = user.userType?.name

        // Student Analyst
        if (userType?.equals('Student Analyst')) {
            projectInstanceList = Project.executeQuery("FROM Project p WHERE ? IN ELEMENTS(p.analysts) ", session.user)

            for (Project projectInstance : projectInstanceList) {
                projectInstanceTotal++
            }
        }

        // Superuser && Moderator
        else if (userType?.equals('Moderator') || userType?.equals('Superuser') || (userType?.equals('WHO Official')) && user.whoOffice.name.equals('Global Headquarters')) {
            projectInstanceList = Project.list()
            projectInstanceTotal = Project.count()
        }

        // Country Official and WHO Official from Country Office
        else if (userType?.equals('Country Official') || (userType?.equals('WHO Official') && (user.whoOffice.name.equals('Country Office')))) {
            projectInstanceList = Project.findAllByOwnerOrCountry(session.user, user.country)
            projectInstanceTotal = Project.count()
        }

        // WHO Official
        else if (userType?.equals('WHO Official')) {
            projectInstanceList = Project.executeQuery("FROM Project p WHERE p.country IN ELEMENTS(?) ", ((WhoOffice) ((EndUser) session.user)).countries)

            for (Project projectInstance : projectInstanceList) {
                projectInstanceTotal++
            }
        }

        // Mentor
        else if (userType?.equals('Mentor')) {
            projectInstanceList = Project.executeQuery("FROM Project p WHERE ? IN ELEMENTS(p.mentors) ", session.user)

            for (Project projectInstance : projectInstanceList) {
                projectInstanceTotal++
            }
        }

        // Expert
        else if (userType?.equals('Expert')) {
            projectInstanceList = Project.executeQuery("FROM Project p WHERE ? IN ELEMENTS(p.experts) ", session.user)

            for (Project projectInstance : projectInstanceList) {
                projectInstanceTotal++
            }
        }

        // NGO Official
        else if (userType?.equals('NGO Official')) {
            projectInstanceList = Project.executeQuery("FROM Project p WHERE ? IN ELEMENTS(p.ngoOfficials) ", session.user)

            for (Project projectInstance : projectInstanceList) {
                projectInstanceTotal++
            }
        }

        [
                user: user,
                userType: userType,
                projectInstanceList: projectInstanceList,
                projectInstanceTotal: projectInstanceTotal,
                modalType: ["requestData", "newProject", "uploadFile"]
        ]
    }
}
