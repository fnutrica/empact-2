package empact

class Note {

    String name
    EndUser owner
    Date uploaded
    String description
    Boolean visible
    byte[] file

    static constraints = {
        uploaded(blank:false)
        visible(blank:false)
        description(blank:false, maxSize:5000)
        file(nullable:false, maxSize:1000000)
    }

    static belongsTo = [
            project:Project
    ]

    String toString() {
        description
    }
}


