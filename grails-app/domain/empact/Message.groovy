package empact

class Message {

    EndUser owner
    Date sent
    String details
    String subject
    static hasMany = [
            responses: MessageResponse
    ]

    static constraints = {
        owner(blank: false)
        subject(blank: false)
        sent(nullable: true)
        details(blank:false, maxSize:5000)
        responses(nullable: true)
    }

    String toString() {
        details
    }
}
