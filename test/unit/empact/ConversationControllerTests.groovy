package empact



import org.junit.*
import grails.test.mixin.*

@TestFor(ConversationController)
@Mock(Conversation)
class ConversationControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/conversation/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.conversationInstanceList.size() == 0
        assert model.conversationInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.conversationInstance != null
    }

    void testSave() {
        controller.save()

        assert model.conversationInstance != null
        assert view == '/conversation/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/conversation/show/1'
        assert controller.flash.message != null
        assert Conversation.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/conversation/list'

        populateValidParams(params)
        def conversation = new Conversation(params)

        assert conversation.save() != null

        params.id = conversation.id

        def model = controller.show()

        assert model.conversationInstance == conversation
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/conversation/list'

        populateValidParams(params)
        def conversation = new Conversation(params)

        assert conversation.save() != null

        params.id = conversation.id

        def model = controller.edit()

        assert model.conversationInstance == conversation
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/conversation/list'

        response.reset()

        populateValidParams(params)
        def conversation = new Conversation(params)

        assert conversation.save() != null

        // test invalid parameters in update
        params.id = conversation.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/conversation/edit"
        assert model.conversationInstance != null

        conversation.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/conversation/show/$conversation.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        conversation.clearErrors()

        populateValidParams(params)
        params.id = conversation.id
        params.version = -1
        controller.update()

        assert view == "/conversation/edit"
        assert model.conversationInstance != null
        assert model.conversationInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/conversation/list'

        response.reset()

        populateValidParams(params)
        def conversation = new Conversation(params)

        assert conversation.save() != null
        assert Conversation.count() == 1

        params.id = conversation.id

        controller.delete()

        assert Conversation.count() == 0
        assert Conversation.get(conversation.id) == null
        assert response.redirectedUrl == '/conversation/list'
    }
}
