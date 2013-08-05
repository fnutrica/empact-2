package empact

class Skill {

    String name

    static constraints = {
        name(blank: false)
    }
    String toString() {
        name
    }
}
