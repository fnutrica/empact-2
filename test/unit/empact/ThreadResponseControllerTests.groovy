package empact



import org.junit.*
import grails.test.mixin.*

@TestFor(ThreadResponseController)
@Mock(ThreadResponse)
class ThreadResponseControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/threadResponse/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.threadResponseInstanceList.size() == 0
        assert model.threadResponseInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.threadResponseInstance != null
    }

    void testSave() {
        controller.save()

        assert model.threadResponseInstance != null
        assert view == '/threadResponse/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/threadResponse/show/1'
        assert controller.flash.message != null
        assert ThreadResponse.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/threadResponse/list'

        populateValidParams(params)
        def threadResponse = new ThreadResponse(params)

        assert threadResponse.save() != null

        params.id = threadResponse.id

        def model = controller.show()

        assert model.threadResponseInstance == threadResponse
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/threadResponse/list'

        populateValidParams(params)
        def threadResponse = new ThreadResponse(params)

        assert threadResponse.save() != null

        params.id = threadResponse.id

        def model = controller.edit()

        assert model.threadResponseInstance == threadResponse
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/threadResponse/list'

        response.reset()

        populateValidParams(params)
        def threadResponse = new ThreadResponse(params)

        assert threadResponse.save() != null

        // test invalid parameters in update
        params.id = threadResponse.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/threadResponse/edit"
        assert model.threadResponseInstance != null

        threadResponse.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/threadResponse/show/$threadResponse.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        threadResponse.clearErrors()

        populateValidParams(params)
        params.id = threadResponse.id
        params.version = -1
        controller.update()

        assert view == "/threadResponse/edit"
        assert model.threadResponseInstance != null
        assert model.threadResponseInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/threadResponse/list'

        response.reset()

        populateValidParams(params)
        def threadResponse = new ThreadResponse(params)

        assert threadResponse.save() != null
        assert ThreadResponse.count() == 1

        params.id = threadResponse.id

        controller.delete()

        assert ThreadResponse.count() == 0
        assert ThreadResponse.get(threadResponse.id) == null
        assert response.redirectedUrl == '/threadResponse/list'
    }
}
