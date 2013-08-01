package empact

class MessageResponse {
    EndUser owner
    Date sent
    String details
    String toString() {
        details
    }

    static constraints = {
        owner(blank: false)
        sent(nullable: true)
        details(blank: false, maxSize: 5000)
    }

    static belongsTo = Message
}
