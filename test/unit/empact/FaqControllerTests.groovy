package empact



import org.junit.*
import grails.test.mixin.*

@TestFor(FaqController)
@Mock(Faq)
class FaqControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/faq/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.faqInstanceList.size() == 0
        assert model.faqInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.faqInstance != null
    }

    void testSave() {
        controller.save()

        assert model.faqInstance != null
        assert view == '/faq/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/faq/show/1'
        assert controller.flash.message != null
        assert Faq.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/faq/list'

        populateValidParams(params)
        def faq = new Faq(params)

        assert faq.save() != null

        params.id = faq.id

        def model = controller.show()

        assert model.faqInstance == faq
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/faq/list'

        populateValidParams(params)
        def faq = new Faq(params)

        assert faq.save() != null

        params.id = faq.id

        def model = controller.edit()

        assert model.faqInstance == faq
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/faq/list'

        response.reset()

        populateValidParams(params)
        def faq = new Faq(params)

        assert faq.save() != null

        // test invalid parameters in update
        params.id = faq.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/faq/edit"
        assert model.faqInstance != null

        faq.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/faq/show/$faq.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        faq.clearErrors()

        populateValidParams(params)
        params.id = faq.id
        params.version = -1
        controller.update()

        assert view == "/faq/edit"
        assert model.faqInstance != null
        assert model.faqInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/faq/list'

        response.reset()

        populateValidParams(params)
        def faq = new Faq(params)

        assert faq.save() != null
        assert Faq.count() == 1

        params.id = faq.id

        controller.delete()

        assert Faq.count() == 0
        assert Faq.get(faq.id) == null
        assert response.redirectedUrl == '/faq/list'
    }
}
