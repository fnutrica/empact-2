package empact

class WhoOffice {

    String name

    static hasMany = [
            countries: Country
    ]

    static constraints = {
        name(blank: false)

    }

    String toString() {
        name
    }
}
