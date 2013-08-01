package empact



import org.junit.*
import grails.test.mixin.*

@TestFor(FindingController)
@Mock(Finding)
class FindingControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/finding/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.findingInstanceList.size() == 0
        assert model.findingInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.findingInstance != null
    }

    void testSave() {
        controller.save()

        assert model.findingInstance != null
        assert view == '/finding/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/finding/show/1'
        assert controller.flash.message != null
        assert Finding.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/finding/list'

        populateValidParams(params)
        def finding = new Finding(params)

        assert finding.save() != null

        params.id = finding.id

        def model = controller.show()

        assert model.findingInstance == finding
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/finding/list'

        populateValidParams(params)
        def finding = new Finding(params)

        assert finding.save() != null

        params.id = finding.id

        def model = controller.edit()

        assert model.findingInstance == finding
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/finding/list'

        response.reset()

        populateValidParams(params)
        def finding = new Finding(params)

        assert finding.save() != null

        // test invalid parameters in update
        params.id = finding.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/finding/edit"
        assert model.findingInstance != null

        finding.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/finding/show/$finding.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        finding.clearErrors()

        populateValidParams(params)
        params.id = finding.id
        params.version = -1
        controller.update()

        assert view == "/finding/edit"
        assert model.findingInstance != null
        assert model.findingInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/finding/list'

        response.reset()

        populateValidParams(params)
        def finding = new Finding(params)

        assert finding.save() != null
        assert Finding.count() == 1

        params.id = finding.id

        controller.delete()

        assert Finding.count() == 0
        assert Finding.get(finding.id) == null
        assert response.redirectedUrl == '/finding/list'
    }
}
