package empact



import org.junit.*
import grails.test.mixin.*

@TestFor(ConceptNoteController)
@Mock(ConceptNote)
class ConceptNoteControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/conceptNote/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.conceptNoteInstanceList.size() == 0
        assert model.conceptNoteInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.conceptNoteInstance != null
    }

    void testSave() {
        controller.save()

        assert model.conceptNoteInstance != null
        assert view == '/conceptNote/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/conceptNote/show/1'
        assert controller.flash.message != null
        assert ConceptNote.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/conceptNote/list'

        populateValidParams(params)
        def conceptNote = new ConceptNote(params)

        assert conceptNote.save() != null

        params.id = conceptNote.id

        def model = controller.show()

        assert model.conceptNoteInstance == conceptNote
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/conceptNote/list'

        populateValidParams(params)
        def conceptNote = new ConceptNote(params)

        assert conceptNote.save() != null

        params.id = conceptNote.id

        def model = controller.edit()

        assert model.conceptNoteInstance == conceptNote
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/conceptNote/list'

        response.reset()

        populateValidParams(params)
        def conceptNote = new ConceptNote(params)

        assert conceptNote.save() != null

        // test invalid parameters in update
        params.id = conceptNote.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/conceptNote/edit"
        assert model.conceptNoteInstance != null

        conceptNote.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/conceptNote/show/$conceptNote.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        conceptNote.clearErrors()

        populateValidParams(params)
        params.id = conceptNote.id
        params.version = -1
        controller.update()

        assert view == "/conceptNote/edit"
        assert model.conceptNoteInstance != null
        assert model.conceptNoteInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/conceptNote/list'

        response.reset()

        populateValidParams(params)
        def conceptNote = new ConceptNote(params)

        assert conceptNote.save() != null
        assert ConceptNote.count() == 1

        params.id = conceptNote.id

        controller.delete()

        assert ConceptNote.count() == 0
        assert ConceptNote.get(conceptNote.id) == null
        assert response.redirectedUrl == '/conceptNote/list'
    }
}
