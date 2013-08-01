package empact

class ThreadResponse {

    EndUser owner
    Date created
    String details

    static constraints = {
        owner(blank:false)
        created(blank:false)
        details(blank:false, maxSize:5000)
    }

    static belongsTo = [thread: Thread]

    String toString() {
        details
    }
}

