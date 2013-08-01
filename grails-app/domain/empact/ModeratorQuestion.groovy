package empact


class ModeratorQuestion {

    String name
    String email
    String question
    String response

    static constraints = {
        name(blank:false)
        email(blank:false)
        question(blank:false, maxSize:5000)
        response(nullable: true , maxSize:5000)
        endUser(nullable: true)
    }

    static belongsTo = [
            endUser:EndUser
    ]

    String toString() {
        question
    }
}

