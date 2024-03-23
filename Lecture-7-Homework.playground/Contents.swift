import Foundation

//: # Main Tasks
//: ### ✅ 1. შექმენით Enum-ი სახელით WeekDay შესაბამისი ქეისებით. დაწერეთ ფუნქცია რომელიც იღებს ამ ენამის ტიპს და ბეჭდავს გადაწოდებული დღე სამუშაოა თუ დასვენების.
enum WeekDay {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

func workOrRest(_ weekday: WeekDay) {
    switch weekday{
    case .saturday, .sunday:
        print("🏝️ დასვენების დღე")
    default:
        print("👩🏻‍💻 სამუშაო დღე")
    }
}

workOrRest(WeekDay.monday)
workOrRest(WeekDay.saturday)

//: ✅ ### 2. შექმენით Enum-ი სახელად GialaSquad, რომელიც აღწერს გია სურამელაშვილის ფანკლუბის წევრების დონეებს ქეისებით : “TsigroviManto”, “MoshishvlebuliMkerdi”, “TuGapatio”. შექმენით ფროფერთი GialaSquad-ში, რომელსაც ექნება ინფორმაცია თუ რა ღირს თითოეული დონე თვეში (დონეები დალაგებულია ძვირიდან იაფისაკენ). დაუმატეთ მეთოდი რომელიც დაბეჭდავს თითოეული დონის ფასს
enum GialaSquad {
    case TsigroviManto
    case MoshishvlebuliMkerdi
    case TuGapatio
    
    var monthlySubscription: Decimal {
        switch self {
        case .TsigroviManto:
            return 3000
        case .MoshishvlebuliMkerdi:
            return 2500 // decoy pricing სტრატეგია 💅🏻
        case .TuGapatio:
            return 1500
        }
    }
    
    func sendMessageToCustomer() {
        print("🌹 ექსკლუზიურად თქვენთვის მოცემულ ფანკლუბში გაწევრიანების ფასი იქნება $\(self.monthlySubscription) 🌹")
    }
}

let customer1 = GialaSquad.MoshishvlebuliMkerdi
customer1.sendMessageToCustomer()

let customer2 = GialaSquad.TsigroviManto
customer2.sendMessageToCustomer()

//: ✅ ### 3. შექმენით enum-ი Weather შემდეგი ქეისებით, Sunny, Cloudy, Rainy და Snowy. ამ ქეისებს უნდა ჰქონდეს associated value Celsius-ის სახით. დაწერეთ function რომელიც მიიღებს ამ enum-ს, და მოგვცემს რეკომენდაციას რა უნდა ჩავიცვათ შესაბამისი ამინდის მიხედვით.
enum Weather {
    case Sunny (Celsius: Decimal)
    case Cloudy (Celsius: Decimal)
    case Rainy (Celsius: Decimal)
    case Snowy (Celsius: Decimal)
}

func whatToWear(_ weather: Weather) {
    switch weather {
    case .Sunny(let celsius) where (20.0...) ~= celsius:
        print("👡")
    case .Cloudy(let celsius) where (14.0...20.0) ~= celsius:
        print("👠")
    case .Rainy(let celsius) where (4.0...14.0) ~= celsius:
        print("👢")
    case .Snowy(let celsius) where (...4.0) ~= celsius:
        print("🥾")
    default:
        print("🚨🆘‼️ ცელსიუსის მნიშვნელობა არასწორია ‼️🆘🚨")
    }
}

whatToWear(.Sunny(Celsius: 26))
whatToWear(.Cloudy(Celsius: 16.6))
whatToWear(.Rainy(Celsius: 11.8))
whatToWear(.Snowy(Celsius: -1))

whatToWear(.Sunny(Celsius: 19.99)) // default case

//: ### ✅ 4. შექმენით struct-ი Kanye, ფროფერთებით: album, releaseYear. ამის შემდეგ შექმენით array-ი Kanye-ს ტიპის, ჩაამატეთ რამოდენიმე Kanye-ს ობიექტი, და შეავსეთ მასივი კანიეებით. დაწერეთ ფუნქცია, რომელიც მიიღებს ამ კანიეების მასივს და წელს. ფუნქციამ უნდა დაგვიბრუნოს ყველა ალბომი რომელიც გამოშვებულია გადაწოდებული წლის შემდეგ და დაბეჭდოს ისინი.
struct Kanye {
    var album: String
    var releaseYear: Int
}

var albumArr: [Kanye] = []

    // კანიეს ობიექტები
var album1 = Kanye(album: "Donda", releaseYear: 2021)
var album2 = Kanye(album: "ye", releaseYear: 2018)
var album3 = Kanye(album: "JESUS IS KING", releaseYear: 2019)
var album4 = Kanye(album: "The Life of Pablo", releaseYear: 2016)
var album5 = Kanye(album: "Yeezus", releaseYear: 2013)

    // მასივის შევსება კანიეებით
albumArr.append(contentsOf: [album1, album2, album3, album4, album5])


func filterAlbumsByYear(_ arr: [Kanye], _ year: Int) -> [String] {
    var filteredArr = [String]()
    
    for i in arr {
        if i.releaseYear > year {
            filteredArr.append(i.album)
        }
    }
    
    if filteredArr.count > 0 {
        print("\(year) წლის შემდეგ გამოშვებული ალბომებია: \(filteredArr)")
    } else {
        print("\(year) წლის შემდეგ გამოშვებული ალბომი ვერ მოიძებნა.")
    }
    return filteredArr
}

filterAlbumsByYear(albumArr, 2017)
filterAlbumsByYear(albumArr, 2026)

//: ### ✅ 5. შექმენით String-ის ტიპის lazy property wrapper სახელად, cachedData. ინიციალიზება გაუკეთეთ ქლოჟერით რომელიც აბრუნებს სტრინგს მნიშვნელობით “lazy ინიციალიზებულია”. მიწვდით ამ ფროფერთის და დაბეჭდეთ მისი მნიშვნელობა
@propertyWrapper
struct lazyPropertyWrapper {
    
    lazy var cachedData: String = {
        print("lazy ინიციალიზდება")
        return "lazy ინიციალიზებულია"
    }()
    
    var wrappedValue: Void {
        return
    }
    
    init() {
    }
}

var testLazy = lazyPropertyWrapper()
print(testLazy.cachedData)
print(testLazy.cachedData) // იმის გასატესტად არის თუ არა პარამეტრი ნამდვილად ლეიზი, ვბეჭდავ მეორედაც და ამ პარამეტრის ინიციალიზაციისას დამატებული print("lazy ინიციალიზდება") რადგან აღარ ეშვება მეორედ, ნიშნავს იმას რომ უკვე მოხდა ზარმაცი ინიციალიზაცია.


//: # Optional Task
//: > ბარბარემ გადაწყვიტა პროგრამირებასთან ერთად დამატებითი სამსახური დაეწყო და ტაროს სამკითხაო ჯიხური გახსნა. მისი სახელი უცებ გავარდა და ქართველი ვარსკვლავების ყურამდეც მივიდა. ერთ დღეს მას ჯიხურში ძალიან ნაცნობი სახეები გამოეცხადა, ბედინა და შავი პრინცი. პროფესიონალმა ნათელმხილველმა გაშალა კარტი და დაიწყო მათ მომავალში ხელების ფათური. ბარბარეს ტაროს დასტა საკმაოდ უნიკალურია, ის მხოლოდ 12 კარტს შეიცავს - **Star, Empress, Tower, Hanged Man, Chariot, Moon, Hierophant, Devil, Lovers, Wheel of Fortune, Fool, Magician** და მათ აღწერებს -
//: - Star: წარმოადგენს იმედს, შთაგონებას და სულიერ ხელმძღვანელობას. ეს ნიშნავს განახლებას, ოპტიმიზმს და მომავლის რწმენას.
//: - Empress: განასახიერებს აღზრდას, სიუხვეს და დედობრივ ინსტინქტებს. ის წარმოადგენს ნაყოფიერებას, კრეატიულობას და ჰარმონიას ურთიერთობებში.
//: - Tower: ნიშნავს უეცარ ცვლილებას, ქაოსს და განადგურებას. ის წარმოადგენს აჯანყებას, გამოცხადებას და ძველი სტრუქტურების ნგრევას ახალი წამოწყებისთვის.
//: - Hanged Man: წარმოადგენს მსხვერპლს, დანებებას და გაშვებას. ეს ნიშნავს შეჩერების, ახალი პერსპექტივების მოპოვებისა და თვითრეფლექსიის პერიოდს.
//: - Chariot: განასახიერებს ნებისყოფას, მონდომებას და გამარჯვებას. ის წარმოადგენს საკუთარ ცხოვრებაზე კონტროლის აღებას, მიზნების მიღწევას და დაბრკოლებების გადალახვას ფოკუსირებისა და სწრაფვის გზით.
//: - Moon: აღნიშნავს ინტუიციას, ილუზიას და ქვეცნობიერ აზრებს. ის წარმოადგენს გაურკვევლობას, დაბნეულობას და აუცილებლობას, ენდოთ საკუთარ ინსტინქტებს უცნობისკენ ნავიგაციის დროს.
//: - Hierophant: წარმოადგენს ტრადიციას, შესაბამისობას და სულიერ ხელმძღვანელობას. ეს ნიშნავს სიბრძნის ძიებას დამკვიდრებული რწმენებისგან, ინსტიტუტებისა და მენტორებისგან.
//: - Devil: განასახიერებს ცდუნებას, მონობასა და მატერიალიზმს. ის წარმოადგენს ადამიანის ბუნების ბნელ ასპექტებს, დამოკიდებულებას და შემზღუდველი რწმენებისა და ჩვევებისგან თავის დაღწევის აუცილებლობას.
//: - Lovers: აღნიშნავს პარტნიორობას, არჩევანს და ჰარმონიას. ის წარმოადგენს სიყვარულს, მიზიდულობას და გადაწყვეტილების მიღების აუცილებლობას ღირებულებებზე და სხვებთან კავშირებზე დაყრდნობით.
//: - Wheel of Fortune: წარმოადგენს ბედს, ციკლებს და მოულოდნელ ცვლილებებს. ეს ნიშნავს იღბალს, შესაძლებლობებს და ცხოვრებისეული მოგზაურობის აღმავლობასა და ვარდნას, გვახსენებს, რომ ცვლილება გარდაუვალია.
//: - Fool: განასახიერებს უდანაშაულობას, სპონტანურობას და ახალ წამოწყებებს. ეს წარმოადგენს რწმენის ნახტომს, თავგადასავლების მიღებას და სამყაროს ხელმძღვანელობისადმი ნდობას.
//: - Magician: აღნიშნავს გამოვლინებას, ძალას და პოტენციალს. ის წარმოადგენს კრეატიულობას, უნარს და უნარს, იდეები რეალობად გარდაქმნას ორიენტირებული განზრახვისა და მოქმედების გზით.
//: -----------------------------------------------------------------------------
//: ### ✅ 1. შექმენით Enum სახელად TarotCard და განსაზღვრეთ მასში 12 კარტის ქეისი.
//: ### ✅ 2. შექმენით სტატიკური მეთოდი TarotCard-ში რომელიც დააბრუნებს კარტს შერჩევითად
//: ### ✅ 3. შექმენით მეთოდი TarotCard-ში რომელიც დააბრუნებს კარტის აღწერას string-ის სახით
//: ### ✅ 4. შექმენით სტრუქტურა სახელად TarotReading. გაუწერეთ ფროფერთიები წარსული, აწმყო და მომავალი. გაუკეთეთ ინიციალიზაცია ამ ფროპერთიებს რათა მათ მიიღონ შერჩევითი ტაროს კარტის აღწერის მნიშვნელობა.
//: ### ✅ 5. შექმენით მეთოდი TarotReading-ში, რომელიც დაბეჭდავს ამ სამ არჩეულ ტაროს კარტს.
enum TarotCard: CaseIterable {
    case Star, Empress, Tower, HangedMan, Chariot, Moon, Hierophant, Devil, Lovers, WheelOfFortune, Fool, Magician
    
    static func pickRandomCard() -> TarotCard {
        let randI = Int.random(in: 0..<Self.allCases.count)
        return Self.allCases[randI]
    }
    
    func getCardDescription(_ card: TarotCard) -> String {
        var cardDescription = ""
        
        switch card { // კარტის აღწერები raw მნიშვნელობებადაც შეიძლებოდა გაგვეწერა ქეისებისთვის, მაგრამ არ დავამატებ იმ ვერსიას
        case .Star:
            cardDescription = "წარმოადგენს იმედს, შთაგონებას და სულიერ ხელმძღვანელობას. ეს ნიშნავს განახლებას, ოპტიმიზმს და მომავლის რწმენას."
        case .Empress:
            cardDescription = "განასახიერებს აღზრდას, სიუხვეს და დედობრივ ინსტინქტებს. ის წარმოადგენს ნაყოფიერებას, კრეატიულობას და ჰარმონიას ურთიერთობებში."
        case .Tower:
            cardDescription = "ნიშნავს უეცარ ცვლილებას, ქაოსს და განადგურებას. ის წარმოადგენს აჯანყებას, გამოცხადებას და ძველი სტრუქტურების ნგრევას ახალი წამოწყებისთვის."
        case .HangedMan:
            cardDescription = "წარმოადგენს მსხვერპლს, დანებებას და გაშვებას. ეს ნიშნავს შეჩერების, ახალი პერსპექტივების მოპოვებისა და თვითრეფლექსიის პერიოდს."
        case .Chariot:
            cardDescription = "განასახიერებს ნებისყოფას, მონდომებას და გამარჯვებას. ის წარმოადგენს საკუთარ ცხოვრებაზე კონტროლის აღებას, მიზნების მიღწევას და დაბრკოლებების გადალახვას ფოკუსირებისა და სწრაფვის გზით."
        case .Moon:
            cardDescription = "აღნიშნავს ინტუიციას, ილუზიას და ქვეცნობიერ აზრებს. ის წარმოადგენს გაურკვევლობას, დაბნეულობას და აუცილებლობას, ენდოთ საკუთარ ინსტინქტებს უცნობისკენ ნავიგაციის დროს."
        case .Hierophant:
            cardDescription = "წარმოადგენს ტრადიციას, შესაბამისობას და სულიერ ხელმძღვანელობას. ეს ნიშნავს სიბრძნის ძიებას დამკვიდრებული რწმენებისგან, ინსტიტუტებისა და მენტორებისგან."
        case .Devil:
            cardDescription = "განასახიერებს ცდუნებას, მონობასა და მატერიალიზმს. ის წარმოადგენს ადამიანის ბუნების ბნელ ასპექტებს, დამოკიდებულებას და შემზღუდველი რწმენებისა და ჩვევებისგან თავის დაღწევის აუცილებლობას."
        case .Lovers:
            cardDescription = "აღნიშნავს პარტნიორობას, არჩევანს და ჰარმონიას. ის წარმოადგენს სიყვარულს, მიზიდულობას და გადაწყვეტილების მიღების აუცილებლობას ღირებულებებზე და სხვებთან კავშირებზე დაყრდნობით."
        case .WheelOfFortune:
            cardDescription = "წარმოადგენს ბედს, ციკლებს და მოულოდნელ ცვლილებებს. ეს ნიშნავს იღბალს, შესაძლებლობებს და ცხოვრებისეული მოგზაურობის აღმავლობასა და ვარდნას, გვახსენებს, რომ ცვლილება გარდაუვალია."
        case .Fool:
            cardDescription = "განასახიერებს უდანაშაულობას, სპონტანურობას და ახალ წამოწყებებს. ეს წარმოადგენს რწმენის ნახტომს, თავგადასავლების მიღებას და სამყაროს ხელმძღვანელობისადმი ნდობას."
        case .Magician:
            cardDescription = "აღნიშნავს გამოვლინებას, ძალას და პოტენციალს. ის წარმოადგენს კრეატიულობას, უნარს და უნარს, იდეები რეალობად გარდაქმნას ორიენტირებული განზრახვისა და მოქმედების გზით."
        }
        
        return cardDescription
    }
}

struct TarotReading {
    var Past: TarotCard
    var Present: TarotCard
    var Future: TarotCard
    

    init() {
        self.Past = TarotCard.pickRandomCard()
        self.Present = TarotCard.pickRandomCard()
        self.Future = TarotCard.pickRandomCard()
    }
    
    func getMyTarotReading() {
        print("🔮 წარსული: \(Past) -> \"\(Past.getCardDescription(Past))\"")
        print("🔮 აწმყო: \(Present) -> \"\(Present.getCardDescription(Present))\"")
        print("🔮 მომავალი: \(Future) -> \"\(Future.getCardDescription(Future))\"")
    }
}

let getAnswers = TarotReading()
getAnswers.getMyTarotReading() // კოდის პრობლემა ისაა რომ შესაძლებელია ერთზე მეტ დროის ქეისზე მივიღოთ ერთი და იგივე კარტი. ამიტომ რენდომის მაგივრად .shuffled()-ის გამოყენება და დასტის ზევით მდებარე ანუ ქეისებიდან პირველივე კარტის მიესაინებაა ოფცია და მერე ამ ქეისის მოშორება დარჩენილი არჩევნებიდან.
