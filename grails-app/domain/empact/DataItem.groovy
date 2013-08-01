package empact

class DataItem {
    String name
    EndUser owner
    Date uploaded
    String description
    byte[] file
    String dataType

    static constraints = {
        dataType(nullable: true)
        uploaded(blank:false)
        description(blank:false, maxSize:5000)
        file(nullable:true, maxSize:1000000)
    }

    static belongsTo = [
            project:Project
    ]

    String toString() {
        description
    }
}