package empact

class Conversation {

    // Owner of a message is the last person to send the message
    EndUser owner

    // Recipient of the latest message
    EndUser recipient

    // Whether the message recipient has read the message or not
    Boolean isRead

    // Last time the Conversation was updated
    Date updated

    static hasMany = [
            messages: Message
    ]

    static constraints = {
        owner(blank: false)
        isRead(blank: false)
        recipient(blank: false)
        updated(blank: false)
        messages(nullable: true)
    }
}
