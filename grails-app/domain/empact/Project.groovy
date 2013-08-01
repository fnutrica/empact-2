package empact

class Project {
    String name
    String description
    ConceptNote conceptnote
    Country country
    String status
    Date startDate
    EndUser owner
    Language language
    boolean published
    Integer version

    static hasMany = [
            dataItems: DataItem,
            findings: Finding,
            analysts: EndUser,
            mentors: EndUser,
            experts: EndUser,
            ngoOfficials: EndUser,
            projectRequests: ProjectRequest,
            suggestedUsers: SuggestedUser,
            notes: Note
    ]


    static constraints = {
        name(blank: false, unique: true)
        description(maxSize: 5000, blank: false)
        startDate(default: new Date())
        conceptnote(blank: false)
        country(blank:false)
        analysts(nullable: true)
        mentors(nullable: true)
        experts(nullable: true)
        ngoOfficials(nullable:true)
        language(nullable: true)
        owner(blank:false)
        status(nullable: true)
        published(default: false)
        version(default: 0)
    }

    String toString () {
        "${name + ' ' + description}"
    }


}