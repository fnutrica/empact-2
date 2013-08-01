package empact

class Language {

    String name

    static constraints = {
        name(blank: false)
    }

    String toString() {
        name
    }
}
