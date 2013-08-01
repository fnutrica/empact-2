package empact

class ProjectRequest {

    EndUser owner
    Date sent
    Boolean suggested
    String details

    static constraints = {
        owner(blank: false)
        sent(blank: false)
        suggested(blank: false)
        details(blank: false, maxSize: 5000)
    }

    static belongsTo = [
            project: Project
    ]

    String toString() {
        details
    }
}
