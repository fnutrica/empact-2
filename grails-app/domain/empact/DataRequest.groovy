package empact


class DataRequest {
    EndUser requestor
    EndUser recipient
    Date sent
    Boolean approved
    String reason

    static constraints = {
        sent(blank:false)
        approved(blank:false)
        reason(blank:false, maxSize:5000)
    }

    String toString() {
        reason
    }
}