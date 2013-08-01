package empact



import org.junit.*
import grails.test.mixin.*

@TestFor(MessageResponseController)
@Mock(MessageResponse)
class MessageResponseControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/messageResponse/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.messageResponseInstanceList.size() == 0
        assert model.messageResponseInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.messageResponseInstance != null
    }

    void testSave() {
        controller.save()

        assert model.messageResponseInstance != null
        assert view == '/messageResponse/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/messageResponse/show/1'
        assert controller.flash.message != null
        assert MessageResponse.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/messageResponse/list'

        populateValidParams(params)
        def messageResponse = new MessageResponse(params)

        assert messageResponse.save() != null

        params.id = messageResponse.id

        def model = controller.show()

        assert model.messageResponseInstance == messageResponse
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/messageResponse/list'

        populateValidParams(params)
        def messageResponse = new MessageResponse(params)

        assert messageResponse.save() != null

        params.id = messageResponse.id

        def model = controller.edit()

        assert model.messageResponseInstance == messageResponse
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/messageResponse/list'

        response.reset()

        populateValidParams(params)
        def messageResponse = new MessageResponse(params)

        assert messageResponse.save() != null

        // test invalid parameters in update
        params.id = messageResponse.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/messageResponse/edit"
        assert model.messageResponseInstance != null

        messageResponse.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/messageResponse/show/$messageResponse.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        messageResponse.clearErrors()

        populateValidParams(params)
        params.id = messageResponse.id
        params.version = -1
        controller.update()

        assert view == "/messageResponse/edit"
        assert model.messageResponseInstance != null
        assert model.messageResponseInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/messageResponse/list'

        response.reset()

        populateValidParams(params)
        def messageResponse = new MessageResponse(params)

        assert messageResponse.save() != null
        assert MessageResponse.count() == 1

        params.id = messageResponse.id

        controller.delete()

        assert MessageResponse.count() == 0
        assert MessageResponse.get(messageResponse.id) == null
        assert response.redirectedUrl == '/messageResponse/list'
    }
}
