package empact



import org.junit.*
import grails.test.mixin.*

@TestFor(DataItemController)
@Mock(DataItem)
class DataItemControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/dataItem/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.dataItemInstanceList.size() == 0
        assert model.dataItemInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.dataItemInstance != null
    }

    void testSave() {
        controller.save()

        assert model.dataItemInstance != null
        assert view == '/dataItem/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/dataItem/show/1'
        assert controller.flash.message != null
        assert DataItem.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/dataItem/list'

        populateValidParams(params)
        def dataItem = new DataItem(params)

        assert dataItem.save() != null

        params.id = dataItem.id

        def model = controller.show()

        assert model.dataItemInstance == dataItem
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/dataItem/list'

        populateValidParams(params)
        def dataItem = new DataItem(params)

        assert dataItem.save() != null

        params.id = dataItem.id

        def model = controller.edit()

        assert model.dataItemInstance == dataItem
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/dataItem/list'

        response.reset()

        populateValidParams(params)
        def dataItem = new DataItem(params)

        assert dataItem.save() != null

        // test invalid parameters in update
        params.id = dataItem.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/dataItem/edit"
        assert model.dataItemInstance != null

        dataItem.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/dataItem/show/$dataItem.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        dataItem.clearErrors()

        populateValidParams(params)
        params.id = dataItem.id
        params.version = -1
        controller.update()

        assert view == "/dataItem/edit"
        assert model.dataItemInstance != null
        assert model.dataItemInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/dataItem/list'

        response.reset()

        populateValidParams(params)
        def dataItem = new DataItem(params)

        assert dataItem.save() != null
        assert DataItem.count() == 1

        params.id = dataItem.id

        controller.delete()

        assert DataItem.count() == 0
        assert DataItem.get(dataItem.id) == null
        assert response.redirectedUrl == '/dataItem/list'
    }
}
