package empact

class EndUser {
    // All Users (Required)
    String userName
    String password
    String securityQuestion
    String securityAnswer
    String email
    String firstName
    String lastName
    String address
    String avatarType
    String avataraddress
    Integer phone
    UserType userType
    Country country
    byte[] file
    String resumeType

    // Student Analysts, Mentors
    String institution

    // WHO Officials
    WhoOffice whoOffice

    // All but Moderator and Superuser
    Boolean verified

    // Student Analysts
    String mentorEmail
    String mentorName
    String mentorInstitution

    String toString () {
        "${firstName + ' ' + lastName}"
    }

    static hasMany = [
            languages: Language,
            interests: String,
            skills: String
    ]

    static constraints = {
        address(nullable:true)
        phone(nullable:true)
        institution(nullable: true)
        securityAnswer(nullable: true)
        securityQuestion(nullable: true)
        email(nullable: true)
        firstName(blank: false)
        lastName(blank: false)
        userName(blank: false)
        password(password:true)
        languages(nullable: true)
        userType(nullable: true)
        interests(nullable: true)
        skills(nullable: true)
        country(blank: false)
        whoOffice(nullable: true)
        avataraddress(nullable: true)
        avatarType(nullable: true)
        verified(nullable: true)
        mentorEmail(nullable: true)
        mentorName(nullable: true)
        mentorInstitution(nullable: true)
        file(nullable: true, maxSize: 1000000)
        resumeType(nullable: true)
    }
}
