package empact

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class ProjectRequestController {

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [projectRequestInstanceList: ProjectRequest.list(params), projectRequestInstanceTotal: ProjectRequest.count()]
    }

    def create() {
        [projectRequestInstance: new ProjectRequest(params)]
    }

    def matchAnalysts(Integer max) {
        def requestInstanceList = ProjectRequest.findAllBySuggested(false)
        def projects = new ArrayList<Project>()

        int count = 0
        for (ProjectRequest request : requestInstanceList) {
            def parentProject = request.project
            if (!inProjectList(parentProject, projects)) {
                projects.add(parentProject)
                count++
            }
        }

        [
                type: 'projects',
                projectInstanceList: projects,
                projectInstanceTotal: count
        ]
    }

    def requestsByProject(Long id) {
        def projectInstance = Project.get(id)
        if (!projectInstance) {
            // Some error here
            return
        }

        def requestInstanceList = projectInstance.projectRequests
        if (!requestInstanceList) {
            render(
                    template: 'listitem',
                    model: [
                            type: 'users',
                            endUserInstanceTotal: 0
                    ]
            )
            return
        }

        def endUserInstanceList = new ArrayList<EndUser>()
        int total = 0
        for (ProjectRequest request : requestInstanceList) {
            if (!request.suggested) {
                endUserInstanceList.add(request.getOwner())
                total++
            }
        }

        render(
                template: 'listitem',
                model: [
                        type: 'users',
                        endUserInstanceTotal: total,
                        endUserInstanceList: endUserInstanceList
                ]
        )
    }

    def analystPreview(Long id) {
        def endUserInstance = EndUser.get(id)

        if (!endUserInstance) {
            render(
                    template: 'preview',
                    model: [
                            ok: false
                    ]
            )
            return
        }

        render(
                template: 'preview',
                model: [
                        ok: true,
                        endUserInstance: endUserInstance
                ]
        )
    }

    def ajaxSave() {
        params.put('suggested', false)
        params.put('owner', session.user)
        params.put('sent', new Date())
        params.put('project', Project.get(params.project_id))
        def requestInstance = new ProjectRequest(params)

        if (!requestInstance.save(flush: true)) {
            render([ok: false, error: 'Could not save request'] as JSON)
            return
        }

        render([ok: true] as JSON)
    }

    private boolean inProjectList(projectInstance, projectInstanceList) {
        for (Project project : projectInstanceList) {
            if (project.id == projectInstance.id) {
                return true
            }
        }
        return false;
    }

    def save() {
        def projectRequestInstance = new ProjectRequest(params)
        if (!projectRequestInstance.save(flush: true)) {
            render(view: "create", model: [projectRequestInstance: projectRequestInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), projectRequestInstance.id])
        redirect(action: "show", id: projectRequestInstance.id)
    }

    def show(Long id) {
        def projectRequestInstance = ProjectRequest.get(id)
        if (!projectRequestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), id])
            redirect(action: "list")
            return
        }

        [projectRequestInstance: projectRequestInstance]
    }

    def edit(Long id) {
        def projectRequestInstance = ProjectRequest.get(id)
        if (!projectRequestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), id])
            redirect(action: "list")
            return
        }

        [projectRequestInstance: projectRequestInstance]
    }

    def update(Long id, Long version) {
        def projectRequestInstance = ProjectRequest.get(id)
        if (!projectRequestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (projectRequestInstance.version > version) {
                projectRequestInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'projectRequest.label', default: 'ProjectRequest')] as Object[],
                        "Another user has updated this ProjectRequest while you were editing")
                render(view: "edit", model: [projectRequestInstance: projectRequestInstance])
                return
            }
        }

        projectRequestInstance.properties = params

        if (!projectRequestInstance.save(flush: true)) {
            render(view: "edit", model: [projectRequestInstance: projectRequestInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), projectRequestInstance.id])
        redirect(action: "show", id: projectRequestInstance.id)
    }

    def delete(Long id) {
        def projectRequestInstance = ProjectRequest.get(id)
        if (!projectRequestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), id])
            redirect(action: "list")
            return
        }

        try {
            projectRequestInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'projectRequest.label', default: 'ProjectRequest'), id])
            redirect(action: "show", id: id)
        }
    }
}
