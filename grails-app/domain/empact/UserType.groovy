package empact

class UserType {

    String name

    static constraints = {
        name(blank: false)
    }

    String toString() {
        name
    }
}
