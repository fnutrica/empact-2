package empact



import org.junit.*
import grails.test.mixin.*

@TestFor(DataRequestController)
@Mock(DataRequest)
class DataRequestControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/dataRequest/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.dataRequestInstanceList.size() == 0
        assert model.dataRequestInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.dataRequestInstance != null
    }

    void testSave() {
        controller.save()

        assert model.dataRequestInstance != null
        assert view == '/dataRequest/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/dataRequest/show/1'
        assert controller.flash.message != null
        assert DataRequest.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/dataRequest/list'

        populateValidParams(params)
        def dataRequest = new DataRequest(params)

        assert dataRequest.save() != null

        params.id = dataRequest.id

        def model = controller.show()

        assert model.dataRequestInstance == dataRequest
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/dataRequest/list'

        populateValidParams(params)
        def dataRequest = new DataRequest(params)

        assert dataRequest.save() != null

        params.id = dataRequest.id

        def model = controller.edit()

        assert model.dataRequestInstance == dataRequest
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/dataRequest/list'

        response.reset()

        populateValidParams(params)
        def dataRequest = new DataRequest(params)

        assert dataRequest.save() != null

        // test invalid parameters in update
        params.id = dataRequest.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/dataRequest/edit"
        assert model.dataRequestInstance != null

        dataRequest.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/dataRequest/show/$dataRequest.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        dataRequest.clearErrors()

        populateValidParams(params)
        params.id = dataRequest.id
        params.version = -1
        controller.update()

        assert view == "/dataRequest/edit"
        assert model.dataRequestInstance != null
        assert model.dataRequestInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/dataRequest/list'

        response.reset()

        populateValidParams(params)
        def dataRequest = new DataRequest(params)

        assert dataRequest.save() != null
        assert DataRequest.count() == 1

        params.id = dataRequest.id

        controller.delete()

        assert DataRequest.count() == 0
        assert DataRequest.get(dataRequest.id) == null
        assert response.redirectedUrl == '/dataRequest/list'
    }
}
