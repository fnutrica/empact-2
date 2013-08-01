package empact

class SuggestedUser {

    EndUser user
    Boolean approved

    static constraints = {
        user(blank: false)
        approved(blank: false)
    }

    static belongsTo = [
            project: Project
    ]

    String toString() {
        user.toString() + ": " + approved.toString()
    }
}
