import empact.ConceptNote
import empact.Country
import empact.EndUser
import empact.Language
import empact.UserType
import empact.WhoOffice

class BootStrap {

    def init = { servletContext ->

        def africa = [
                'Algeria', 'Angola', 'Benin', 'Botswana', 'Burkina Faso', 'Burundi',
                'Cameroon', 'Cape Verde', 'Central African Republic', 'Chad', 'Comoros',
                'Congo', "Côte d'Ivoire", 'Democratic Republic of the Congo', 'Equatorial Guinea',
                'Eritrea', 'Ethiopia', 'Gabon', 'Gambia', 'Ghana', 'Guinea', 'Guinea-Bissau', 'Kenya',
                'Lesotho', 'Liberia', 'Madagascar', 'Malawi', 'Mali', 'Mauritania', 'Mauritius',
                'Mozambique', 'Namibia', 'Niger', 'Nigeria', 'Rwanda', 'Sao Tome and Principe',
                'Senegal', 'Seychelles', 'Sierra Leone', 'South Africa', 'Swaziland', 'Togo',
                'Uganda', 'United Republic of Tanzania', 'Zambia', 'Zimbabwe'
        ]

        def africa_lat = [
                33.0971, -11.4798, 6.3176, -22.9906, 12.1204,
                -3.2836, 5.1296, 15.1111, 5.7735, 13.6216,
                -12.0236, -2.0903, 7.1317, -2.6633, 1.9248,
                15.1177, 9.4969, -0.3799, 13.4171, 7.4490,
                10.2716, 11.8493, -0.4252, -29.5495, 6.3636,
                -18.3714, -13.8383, 14.8128, 18.6597, -20.1625,
                -18.9296, -21.7391, 14.8592, 7.6219, -2.0241,
                0.3176, 14.6943, -4.6308, 8.4731, -29.8191,
                -26.6474, 8.3357, 1.1027, -5.6944, -13.7195,
                -18.8640

        ]

        def africa_lng = [
                3.2318, 15.6241, 5.6145, 25.1557, -1.7841,
                29.8293, 11.4381, -23.6167, 19.5969, 17.9087,
                43.8069, 14.2120, -5.5230, 23.8864, 10.1116,
                38.9125, 36.8961, 11.7572, -15.9523, -0.9056,
                -11.7188, -15.2996, 36.7517, 28.1851, -9.4659,
                47.5424, 34.4429, -5.5030, -11.7001, 58.2903,
                35.3244, 17.2146, 6.4590, 6.9743, 29.6695,
                6.6688, -15.5953, 55.4619, -12.2465, 25.3499,
                31.5516, 1.0495, 32.3968, 36.3223, 28.2433,
                30.3339
        ]

        def america = [
                'Antigua and Barbuda', 'Argentina', 'Bahamas', 'Barbados', 'Belize', 'Bolivia (Plurinational State of)',
                'Brazil', 'Canada', 'Chile', 'Colombia', 'Costa Rica', 'Cuba', 'Dominica',
                'Dominican Republic', 'Ecuador', 'El Salvador', 'Grenada', 'Guatemala', 'Guyana',
                'Haiti', 'Honduras', 'Jamaica', 'Mexico', 'Nicaragua', 'Panama', 'Paraguay',
                'Peru', 'Saint Kitts and Nevis', 'Saint Lucia', 'Saint Vincent and the Grenadines',
                'Suriname', 'Trinidad and Tobago', 'United States of America', 'Uruguay',
                'Venezuela (Bolivarian Republic of)'
        ]

        def america_lat = [
                17.0500, -34.0000, 24.3196, 13.1594, 17.4789,
                -18.4258, -15.6778, 56.7577, -35.1234, 5.0689,
                9.9247, 23.1333, 15.4058, 18.9473, -0.1500,
                13.7176, 12.2826, 14.6317, 6.3490, 18.9411,
                14.7806, 18.1315, 19.0000, 12.5969, 8.7515,
                -24.9217, -11.2583, 17.2827, 13.8989, 13.1992,
                5.0631, 10.5526, 40.4230, -33.0000, 9.3928
        ]

        def america_lng = [
                -61.8000, -64.0000, -76.2765, -59.5300, -88.5162,
                -66.5304, -47.4384, -86.4196, -71.5720, -74.5263,
                -84.0780, -82.3833, -61.3607, -70.4811, -78.3500,
                -89.0279, -61.7170, -90.5236, -58.5820, -72.7034,
                -87.4384, -77.2736, -99.0000, -85.8795, -79.8772,
                -57.3708, -75.1374, -62.7182, -60.9682, -61.2109,
                -55.4265, -61.3152, -98.7372, -56.0000, -66.3562
        ]

        def sea = [
                'Bangladesh', 'Bhutan', "Democratic People's Republic of Korea", 'India',
                'Indonesia', 'Maldives', 'Myanmar', 'Nepal', 'Sri Lanka', 'Thailand', 'Timor-Leste'
        ]

        def sea_lat = [
                23.8511, 27.5274, 40.2012, 21.7679, -3.2591,
                4.1667, 19.8761, 27.9389, 7.5653, 13.9202,
                -8.8484
        ]

        def sea_lng = [
                89.9250, 90.0453, 127.2565, 78.8718, 109.7028,
                73.5000, 96.0452, 84.9408, 80.4303, 101.0168,
                125.5942
        ]

        def europe = [
                'Albania', 'Andorra', 'Armenia', 'Austria', 'Azerbaijan', 'Belarus', 'Belgium',
                'Bosnia and Herzegovina', 'Bulgaria', 'Croatia', 'Cyprus', 'Czech Republic', 'Denmark',
                'Estonia', 'Finland', 'France', 'Georgia', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland',
                'Israel', 'Italy', 'Kazakhstan', 'Kyrgyzstan', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta',
                'Monaco', 'Montenegro', 'Netherlands', 'Norway', 'Poland', 'Portugal', 'Republic of Moldova',
                'Romania', 'Russian Federation', 'San Marino', 'Serbia', 'Slovakia', 'Slovenia', 'Spain',
                'Sweden', 'Switzerland', 'Tajikistan', 'The former Yugoslav Republic of Macedonia', 'Turkey',
                'Turkmenistan', 'Ukraine', 'United Kingdom', 'Uzbekistan'
        ]

        def europe_lat = [
                41.0092, 42.5344, 40.2885, 48.1200, 40.1833,
                53.3275, 50.7802, 44.1285, 42.3755, 44.8313,
                35.2251, 49.7500, 55.7200, 58.7673, 62.4302,
                46.0000, 42.1902, 51.0000, 38.3228, 47.2753,
                64.8343, 53.0000, 31.7833, 44.2632, 43.3503,
                41.7584, 57.0035, 55.3006, 49.6117, 35.8997,
                43.7328, 42.5119, 52.2066, 60.3800, 51.4273,
                38.7000, 47.6333, 45.7909, 54.8270, 43.9366,
                44.9778, 48.6300, 45.8002, 40.6986, 59.2685,
                46.57, 38.6997, 41.5101, 39.1988, 39.0206,
                49.2144, 53.1142, 40.6818
        ]
        def europe_lng = [
                20.0194, 1.5208, 44.9795, 16.2200, 47.1542,
                27.4014, 4.4269, 17.9249, 25.1629, 16.1552,
                33.6124, 15.7500, 12.5700, 24.7990, 24.7271,
                2.0000, 43.2781, 9.0000, 22.2592, 20.5528,
                -18.9770, 7.0000, 35.2167, 11.4403, 79.0804,
                74.2526, 24.3446, 23.8491, 6.1300, 14.5172,
                7.4197, 19.0782, 5.6422, 5.3400, 20.1726,
                -9.1833, 28.1500, 24.7731, 55.0423, 12.4676,
                20.1268, 19.5561, 15.9039, -3.2949, 15.7591,
                7.27, 70.0035, 21.4617, 34.0723, 58.7951,
                30.2937, 2.5771, 66.8099

        ]

        def medit = [
                'Afghanistan', 'Bahrain', 'Djibouti', 'Egypt', 'Iran (Islamic Republic of)', 'Iraq', 'Jordan',
                'Kuwait', 'Lebanon', 'Libya', 'Morocco', 'Oman', 'Pakistan', 'Qatar', 'Saudi Arabia', 'Somalia',
                'South Sudan', 'Sudan', 'Syrian Arab Republic', 'Tunisia', 'United Arab Emirates', 'Yemen'
        ]

        def medit_lat = [
                33.9791, 26.0275, 11.5857, 28.8013, 33.6804, 33.0000, 31.9277, 29.3286,
                33.9270, 29.9569, 32.7502, 22.7465, 32.0162, 25.3000, 24.1631, 6.0442,
                4.8500, 12.4204, 34.8545, 35.4187, 25.0895, 14.5697
        ]

        def medit_lng = [
                66.4849, 50.5500, 42.6190, 31.1711, 51.1689, 44.0000, 35.8793, 48.0034,
                35.6951, 15.7461, -6.1916, 57.1203, 71.6926, 51.5333, 43.6021, 45.7194,
                31.6000, 30.6753, 37.0261, 9.9875, 55.6068, 46.1003
        ]

        def pacific = [
                'Australia', 'Brunei Darussalam', 'Cambodia', 'China', 'Cook Islands', 'Fiji', 'Japan',
                'Kiribati', "Lao People's Democratic Republic", 'Malaysia', 'Marshall Islands',
                'Micronesia (Federated States of)', 'Mongolia', 'Nauru', 'New Zealand', 'Niue', 'Palau',
                'Papua New Guinea', 'Philippines', 'Republic of Korea', 'Samoa', 'Singapore', 'Solomon Islands',
                'Tonga', 'Tuvalu', 'Vanuatu', 'Viet Nam'
        ]

        def pacific_lat = [
                -32.3456, 4.8167, 12.4317, 32.9043, -21.2000,
                -18.1667, 35.4112, 1.3333, 18.2912, 4.1936,
                7.2971, 6.9319, 47.7694, -0.5273, -41.4395,
                -19.0633, 7.3497, -5.9054, 11.8728, 36.4693,
                -13.7745, 1.3667, -8.9389, -19.6964, -8.5167,
                -17.7500, 15.4549
        ]

        def pacific_lng = [
                141.4346, 114.7694, 104.5291, 110.4677, -159.7667,
                178.4500, 135.8337, 173.0000, 103.6069, 103.7249,
                168.7061, 158.2224, 100.1790, 166.9367, 172.1936,
                -169.8697, 134.5097, 147.4080, 122.8613, 127.6243,
                -172.0428, 103.7500, 159.5305, -175.0270, 179.2167,
                168.3000, 106.5760
        ]

        def languages = [
                'Arabic', 'Chinese', 'English', 'French', 'Russian', 'Spanish'
        ]

        def userType = [
                'Student Analyst', 'Expert', 'Mentor', 'WHO Official', 'Country Official', 'NGO Official', 'Moderator', 'Superuser', 'Bot'
        ]

        def cnShortTitles = [
                'Elimination of NTDs',
                'Connecting Poverty to NTDs',
                'Youth, Education and NTDs',
                'Health Sector Planning',
                'Economic Toll of NTDs'
        ]

        def cnFullTitles = [
                'Health sector planning to reach and sustain elimination of NTDs',
                'Connecting dimensions of poverty to NTDs: how poverty-reduction programs can incorporate NTD control modalities',
                'Youth, education, and NTDs: Measuring the impact of NTD control on community-level education initiatives',
                'Evaluating the impact of NTDs on maternal and child health (MCH) and integrating NTD control into MCH programs',
                'The Economic Toll of NTDs: Assessing the role of NTD control on human capital development'
        ]

        def cnDescriptions = [
                'Long-term health sector planning and analysis is critical to the elimination of NTDs. Strategizing about the program costs of mass drug administration is a first step toward implementing an effective and sustainable NTD control program.',
                'Although the intersection between poverty and NTDs has long been recognized, there has been limited exploration of how NTD control through Preventive Chemotherapy (PCT) affects the socioeconomic status of individuals. Providing evidence-based data of the relationship between poverty and NTDs would legitimize investment of PCT as a facet of poverty-reduction strategies',
                'High rates of NTDs in children have long been linked to decreased cognitive development and increased school absenteeism. Evaluating the relationship between preventive chemotherapy and educational outcomes would dictate whether mass drug administration is an effective tool for improving community-level educational outcomes',
                'NTDs exacerbate existing issues of low birth weight, poor nutritional status, and anemia in pregnancy, yet rarely are NTD control efforts incorporated into broader maternal and child health (MCH) initiatives. Establishing the relationship between NTD control and improved MCH outcomes, such as Soil Transmitted Helminth (STH) control on increased birth weight, will facilitate the integration of NTD control into future MCH initiatives',
                'Past studies show that NTDs drain a country of its social, political and economic capital. But can NTD control jumpstart capital development? Evidence of the relationship between NTD control and human capital development must be explored further in order to more fully understand the economic impact of NTDs and develop strategies to combat their economic tolls'
        ]

        if (!ConceptNote.count()) {
            for (int i = 0; i < cnShortTitles.size(); i++) {
                new ConceptNote(
                        shortTitle: cnShortTitles[i],
                        fullTitle: cnFullTitles[i],
                        description: cnDescriptions[i]
                ).save()
            }
        }

        if (!UserType.count()) {
            for (String type : userType) {
                new UserType(
                        name: type
                ).save()
            }
        }

        if (!Language.count()) {
            for (String lang : languages) {
                new Language(
                        name: lang
                ).save()
            }
        }

        if (!WhoOffice.count()) {
            def co = new WhoOffice()
            co.setName("Country Office")
            co.save()

            def hq = new WhoOffice()
            hq.setName("Global Headquarters")
            hq.save()

            def rofa = new WhoOffice()
            rofa.setName("Regional Office for Africa")

            int index = 0
            for (String name : africa) {
                Country country = new Country()
                country.setName(name)
                country.setLat(africa_lat[index])
                country.setLng(africa_lng[index])
                country.save()

                rofa.addToCountries(country)
                index++
            }
            rofa.save(failOnError: true)

            def rofta = new WhoOffice()
            rofta.setName("Regional Office for the Americas")

            index = 0
            for (String name : america) {
                Country country = new Country()
                country.setName(name)
                country.setLat(america_lat[index])
                country.setLng(america_lng[index])
                country.save()

                rofta.addToCountries(country)
                index++
            }
            rofta.save(failOnError: true)

            def rofsea = new WhoOffice()
            rofsea.setName("Regional Office for South-East Asia")

            index = 0
            for (String name : sea) {
                Country country = new Country()
                country.setName(name)
                country.setLat(sea_lat[index])
                country.setLng(sea_lng[index])
                country.save()

                rofsea.addToCountries(country)
                index++
            }
            rofsea.save(failOnError: true)

            def rofe = new WhoOffice()
            rofe.setName("Regional Office for Europe")

            index = 0
            for (String name : europe) {
                Country country = new Country()
                country.setName(name)
                country.setLat(europe_lat[index])
                country.setLng(europe_lng[index])
                country.save()

                rofe.addToCountries(country)
                index++
            }
            rofe.save(failOnError: true)

            def rofem = new WhoOffice()
            rofem.setName("Regional Office for Eastern Meditarranean")

            index = 0
            for (String name : medit) {
                Country country = new Country()
                country.setName(name)
                country.setLat(medit_lat[index])
                country.setLng(medit_lng[index])
                country.save()

                rofem.addToCountries(country)
                index++
            }
            rofem.save(failOnError: true)

            def roftwp = new WhoOffice()
            roftwp.setName("Regional Office for the Western Pacific")

            index = 0
            for (String name : pacific) {
                Country country = new Country()
                country.setName(name)
                country.setLat(pacific_lat[index])
                country.setLng(pacific_lng[index])
                country.save()

                roftwp.addToCountries(country)
                index++
            }

            roftwp.save(failOnError: true)
        }

        if (!EndUser.count()) {

            // Bots
            def GuestBot = new EndUser(
                    version: 0,
                    email: 'GuestMod@empact.org',
                    firstName: 'Guest',
                    lastName: 'Bot',
                    password: 'password',
                    userName: 'GuestBot'
            )
            GuestBot.setUserType(UserType.findByName('Bot'))
            GuestBot.setCountry(Country.get(50))
            GuestBot.save(failOnError: true)

            def ForumBot = new EndUser(
                    version: 0,
                    email: 'ForumBot@empact.org',
                    firstName: 'Forum',
                    lastName: 'Bot',
                    password: 'password',
                    userName: 'forum'
            )
            ForumBot.setUserType(UserType.findByName('Bot'))
            ForumBot.setCountry(Country.get(50))
            ForumBot.save(failOnError: true)

            //Student Analyst
            def sngobese = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'sngobese@macalester.edu',
                    firstName: 'Sibusiso',
                    institution: 'Macalester College',
                    lastName: 'Ngobese',
                    password: 'password',
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'sngobese',
                    verified: false,
                    mentorName: 'Issa Ali',
                    mentorEmail: 'iali1@macalester.edu',
                    mentorInstitution: 'Macalester College'
            )
            sngobese.setUserType(UserType.findByName('Student Analyst'))
            sngobese.setCountry(Country.get(168))
            sngobese.addToLanguages(Language.get(1))
            sngobese.addToLanguages(Language.get(4))
            sngobese.addToLanguages(Language.get(6))

            sngobese.save(failOnError: true)

            //Mentor
            def iali1 = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'iali1@macalester.edu',
                    firstName: 'Issa',
                    institution: 'Macalester College',
                    lastName: 'Ali',
                    password: 'password',
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'iali1',
                    verified: false
            )
            iali1.setUserType(UserType.findByName('Mentor'))
            iali1.setCountry(Country.get(78))
            iali1.save(failOnError: true)

            //Expert
            def mgiesel = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'mgiesel@macalester.edu',
                    firstName: 'Margaret',
                    institution: 'Macalester College',
                    lastName: 'Giesel',
                    password: 'password',
                    verified: false,
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'mgiesel'
            )
            mgiesel.setUserType(UserType.findByName('Expert'))
            mgiesel.setCountry(Country.get(25))
            mgiesel.save(failOnError: true)

            //NGO Official
            def zwang = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'zwang@macalester.edu',
                    firstName: 'Zixiao',
                    institution: 'Macalester College',
                    lastName: 'Wang',
                    password: 'password',
                    verified: true,
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'zwang'
            )
            zwang.setUserType(UserType.findByName('NGO Official'))
            zwang.setCountry(Country.get(176))
            zwang.save(failOnError: true)

            //Country Official
            def snaden = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'snaden@macalester.edu',
                    firstName: 'Sam',
                    institution: 'Macalester College',
                    lastName: 'Naden',
                    password: 'password',
                    verified: true,
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'snaden'
            )
            snaden.setUserType(UserType.findByName('Country Official'))
            snaden.setCountry(Country.get(47))
            snaden.save(failOnError: true)

            //WHO Official - Country
            def anichols1 = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'anichols1@macalester.edu',
                    firstName: 'Annabelle',
                    institution: 'Macalester College',
                    lastName: 'Nichols',
                    password: 'password',
                    verified: true,
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'anichols1'
            )
            anichols1.setUserType(UserType.findByName('WHO Official'))
            anichols1.setCountry(Country.get(46))
            anichols1.setWhoOffice(WhoOffice.findByName('Country Office'))
            anichols1.save(failOnError: true)

            //WHO Official - Region
            def bhillman = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'bhillman@macalester.edu',
                    firstName: 'Ben',
                    institution: 'Macalester College',
                    lastName: 'Hillmann',
                    password: 'password',
                    verified: true,
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'bhillman'
            )
            bhillman.setUserType(UserType.findByName('WHO Official'))
            bhillman.setCountry(Country.get(129))
            bhillman.setWhoOffice(WhoOffice.findByName('Regional Office for Africa'))
            bhillman.save(failOnError: true)

            //WHO Official - Global HQ
            def imarinci = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'imarinci@macalester.edu',
                    firstName: 'Ivana',
                    institution: 'Macalester College',
                    lastName: 'Marincic',
                    password: 'password',
                    verified: true,
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'imarinci'
            )
            imarinci.setUserType(UserType.findByName('WHO Official'))
            imarinci.setCountry(Country.get(116))
            imarinci.setWhoOffice(WhoOffice.findByName('Global Headquarters'))
            imarinci.save(failOnError: true)

            //Moderator
            def price = new EndUser(
                    version: 0,
                    address: '1600 Grand Avenue, St Paul, MN',
                    email: 'price@macalester.edu',
                    firstName: 'Paul',
                    institution: 'Macalester College',
                    lastName: 'Rice',
                    password: 'password',
                    verified: true,
                    securityAnswer: 'asasdfasdf',
                    securityQuestion: 'seasdzsdvf',
                    userName: 'price'
            )
            price.setUserType(UserType.findByName('Moderator'))
            price.setCountry(Country.get(2))
            price.save(failOnError: true)
        }


    }
    def destroy = {
    }
}
