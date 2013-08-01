package empact

class Country {

    String name
    BigDecimal lat
    BigDecimal lng

    static constraints = {
        name(unique: true)
        lat(blank: false)
        lng(blank: true)
    }

    static belongsTo = [ whoOffice: WhoOffice ]

    String toString() {
        name
    }
}
