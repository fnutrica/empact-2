package empact

class ConceptNote {

    String shortTitle
    String fullTitle
    String description


    static constraints = {
        shortTitle(blank:false)
        fullTitle(blank:false)
        description(blank:false, maxSize:5000)
    }

    String toString() {
        fullTitle
        description
    }
}