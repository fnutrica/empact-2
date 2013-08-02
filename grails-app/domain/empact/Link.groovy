package empact

class Link {
    String name
    String link
    String description

    static constraints = {
        name(blank: false)
        link(blank: false)
        description(blank: false)

    }

}
