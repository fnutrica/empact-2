package empact



import org.junit.*
import grails.test.mixin.*

@TestFor(ModeratorQuestionController)
@Mock(ModeratorQuestion)
class ModeratorQuestionControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/moderatorQuestion/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.moderatorQuestionInstanceList.size() == 0
        assert model.moderatorQuestionInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.moderatorQuestionInstance != null
    }

    void testSave() {
        controller.save()

        assert model.moderatorQuestionInstance != null
        assert view == '/moderatorQuestion/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/moderatorQuestion/show/1'
        assert controller.flash.message != null
        assert ModeratorQuestion.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/moderatorQuestion/list'

        populateValidParams(params)
        def moderatorQuestion = new ModeratorQuestion(params)

        assert moderatorQuestion.save() != null

        params.id = moderatorQuestion.id

        def model = controller.show()

        assert model.moderatorQuestionInstance == moderatorQuestion
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/moderatorQuestion/list'

        populateValidParams(params)
        def moderatorQuestion = new ModeratorQuestion(params)

        assert moderatorQuestion.save() != null

        params.id = moderatorQuestion.id

        def model = controller.edit()

        assert model.moderatorQuestionInstance == moderatorQuestion
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/moderatorQuestion/list'

        response.reset()

        populateValidParams(params)
        def moderatorQuestion = new ModeratorQuestion(params)

        assert moderatorQuestion.save() != null

        // test invalid parameters in update
        params.id = moderatorQuestion.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/moderatorQuestion/edit"
        assert model.moderatorQuestionInstance != null

        moderatorQuestion.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/moderatorQuestion/show/$moderatorQuestion.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        moderatorQuestion.clearErrors()

        populateValidParams(params)
        params.id = moderatorQuestion.id
        params.version = -1
        controller.update()

        assert view == "/moderatorQuestion/edit"
        assert model.moderatorQuestionInstance != null
        assert model.moderatorQuestionInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/moderatorQuestion/list'

        response.reset()

        populateValidParams(params)
        def moderatorQuestion = new ModeratorQuestion(params)

        assert moderatorQuestion.save() != null
        assert ModeratorQuestion.count() == 1

        params.id = moderatorQuestion.id

        controller.delete()

        assert ModeratorQuestion.count() == 0
        assert ModeratorQuestion.get(moderatorQuestion.id) == null
        assert response.redirectedUrl == '/moderatorQuestion/list'
    }
}
