package empact

class Thread {

    String title
    Date created
    String details
    EndUser threadOwner
    static hasMany = [
            responses: ThreadResponse
    ]
    static mapping = {
        responses cascade: "all-delete-orphan"
    }

    static constraints = {
        threadOwner()
        created(blank:false)
        details(blank:false)
        responses(nullable:true)
    }


    String toString() {
        details
    }
}
