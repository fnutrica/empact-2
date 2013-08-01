package empact



import org.junit.*
import grails.test.mixin.*

@TestFor(ProjectRequestController)
@Mock(ProjectRequest)
class ProjectRequestControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/projectRequest/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.projectRequestInstanceList.size() == 0
        assert model.projectRequestInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.projectRequestInstance != null
    }

    void testSave() {
        controller.save()

        assert model.projectRequestInstance != null
        assert view == '/projectRequest/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/projectRequest/show/1'
        assert controller.flash.message != null
        assert ProjectRequest.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/projectRequest/list'

        populateValidParams(params)
        def projectRequest = new ProjectRequest(params)

        assert projectRequest.save() != null

        params.id = projectRequest.id

        def model = controller.show()

        assert model.projectRequestInstance == projectRequest
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/projectRequest/list'

        populateValidParams(params)
        def projectRequest = new ProjectRequest(params)

        assert projectRequest.save() != null

        params.id = projectRequest.id

        def model = controller.edit()

        assert model.projectRequestInstance == projectRequest
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/projectRequest/list'

        response.reset()

        populateValidParams(params)
        def projectRequest = new ProjectRequest(params)

        assert projectRequest.save() != null

        // test invalid parameters in update
        params.id = projectRequest.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/projectRequest/edit"
        assert model.projectRequestInstance != null

        projectRequest.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/projectRequest/show/$projectRequest.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        projectRequest.clearErrors()

        populateValidParams(params)
        params.id = projectRequest.id
        params.version = -1
        controller.update()

        assert view == "/projectRequest/edit"
        assert model.projectRequestInstance != null
        assert model.projectRequestInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/projectRequest/list'

        response.reset()

        populateValidParams(params)
        def projectRequest = new ProjectRequest(params)

        assert projectRequest.save() != null
        assert ProjectRequest.count() == 1

        params.id = projectRequest.id

        controller.delete()

        assert ProjectRequest.count() == 0
        assert ProjectRequest.get(projectRequest.id) == null
        assert response.redirectedUrl == '/projectRequest/list'
    }
}
