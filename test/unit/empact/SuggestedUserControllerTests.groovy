package empact



import org.junit.*
import grails.test.mixin.*

@TestFor(SuggestedUserController)
@Mock(SuggestedUser)
class SuggestedUserControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/suggestedUser/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.suggestedUserInstanceList.size() == 0
        assert model.suggestedUserInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.suggestedUserInstance != null
    }

    void testSave() {
        controller.save()

        assert model.suggestedUserInstance != null
        assert view == '/suggestedUser/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/suggestedUser/show/1'
        assert controller.flash.message != null
        assert SuggestedUser.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/suggestedUser/list'

        populateValidParams(params)
        def suggestedUser = new SuggestedUser(params)

        assert suggestedUser.save() != null

        params.id = suggestedUser.id

        def model = controller.show()

        assert model.suggestedUserInstance == suggestedUser
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/suggestedUser/list'

        populateValidParams(params)
        def suggestedUser = new SuggestedUser(params)

        assert suggestedUser.save() != null

        params.id = suggestedUser.id

        def model = controller.edit()

        assert model.suggestedUserInstance == suggestedUser
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/suggestedUser/list'

        response.reset()

        populateValidParams(params)
        def suggestedUser = new SuggestedUser(params)

        assert suggestedUser.save() != null

        // test invalid parameters in update
        params.id = suggestedUser.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/suggestedUser/edit"
        assert model.suggestedUserInstance != null

        suggestedUser.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/suggestedUser/show/$suggestedUser.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        suggestedUser.clearErrors()

        populateValidParams(params)
        params.id = suggestedUser.id
        params.version = -1
        controller.update()

        assert view == "/suggestedUser/edit"
        assert model.suggestedUserInstance != null
        assert model.suggestedUserInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/suggestedUser/list'

        response.reset()

        populateValidParams(params)
        def suggestedUser = new SuggestedUser(params)

        assert suggestedUser.save() != null
        assert SuggestedUser.count() == 1

        params.id = suggestedUser.id

        controller.delete()

        assert SuggestedUser.count() == 0
        assert SuggestedUser.get(suggestedUser.id) == null
        assert response.redirectedUrl == '/suggestedUser/list'
    }
}
