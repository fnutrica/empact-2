package empact



class Faq {
    String question
    String answer

    static constraints = {
        question(blank:false, maxSize:5000)
        answer(blank:false, maxSize:5000)
    }

    String toString() {
        "$question... $answer"
    }
}

