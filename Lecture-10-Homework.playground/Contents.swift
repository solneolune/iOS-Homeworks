import Foundation

//: # დავალება
//: 1. შექმენით ციკლური რეფერენცები და გაწყვიტეთ ✅
//: 2. აუცილებელია ქლოჟერების გამოყენება ✅
//: 3. აუცილებელია value და რეფერენს ტიპების გამოყენება
//:     - კლასები ✅
//:     - სტრუქტურები ⛔️ (დავითმა აუცილებელი არაა ყველას გამოყენებაო და თან რეფერენსს ისედაც არ წარმოქმნის რადგან ველიუ თაიფია)
//:     - ენამები ✅
//:     - პროტოკოლები ✅
//: 4. აუცილებელია გამოიყენოთ strong, weak & unowned რეფერენსები ერთხელ მაინც ✅
//: 5. დაიჭირეთ self ქლოჟერებში ✅
//: 6. გატესტეთ მიღებული შედეგები ინსტანსების შექმნით და დაპრინტვით ✅



//: ## სტანდარტული მაგალითები ქლოჟერის გარეშე (ქლოჟერის გამოყენება იხილეთ მე-4 მაგალითში)
//: ### 📝 მაგალითი 1 - Strong Reference (აქ გამოვიყენე ენამები და პროტოკოლები, რადგან დავითმა თქვა უფასოაო. კონკრეტული მაგალითი უკეთ იმუშავებდა unowned რეფერენსში, მაგრამ უკვე აქ მიწერია და დავუშვათ ხალხური წიგნის არსებობა.)
enum Genre {
    case fantasy, thriller, horror, romance, biography
}

enum Gender {
    case female, male, other
}

enum CreationAreas {
    case writing, art, scuplting, songwriting, filmmaking
}

protocol Creator {
    var name: String { get }
    var gender: Gender { get }
    var nationality: String { get }
    var education: String { get }
    var area: CreationAreas { get }
}

protocol Publication {
    var title: String { get }
    var year: Int { get }
    var genre: Genre { get }
}

class Writer: Creator {
    let name: String
    let gender: Gender
    let nationality: String
    let education: String
    let area: CreationAreas
    var book: Book?
    
    init(name: String, gender: Gender, nationality: String, education: String, area: CreationAreas) {
        self.name = name
        self.gender = gender
        self.nationality = nationality
        self.education = education
        self.area = area
        print("\(name) ინიციალიზებულია.")
    }
    
    deinit {
        print("\(name) დეინიციალიზებულია.")
    }
}

class Book: Publication {
    let title: String
    let year: Int
    let genre: Genre
    var writer: Writer?
    
    init(title: String, year: Int, genre: Genre) {
        self.title = title
        self.year = year
        self.genre = genre
        print("\(title) ინიციალიზებულია.")
    }
    
    deinit {
        print("\(title) დეინიციალიზებულია.")
    }
}


var janeDoe: Writer? = Writer(name: "Xia Xie", gender: Gender.female, nationality: "Chinese", education: "Tsinghua University", area: CreationAreas.writing)
var randomBook: Book? = Book(title: "Silk and Seduction: An Intimate Affair in the Ming Dynasty", year: 1989, genre: Genre.fantasy)

janeDoe!.book = randomBook
randomBook!.writer = janeDoe

janeDoe = nil   // არ ბეჭდავს რომ დეინიციალიზებულია
randomBook = nil   // არ ბეჭდავს რომ დეინიციალიზებულია



//: ### 📝 მაგალითი 2 - Weak Reference
class Owner {
    let name: String
    var shoes: LouboutinShoes?
    
    init(name: String) {
        self.name = name
        print("\(name) ინიციალიზებულია.")
    }
    
    deinit {
        print("\(name) დეინიციალიზებულია.")
    }
}

class LouboutinShoes {
    let name: String
    let price: Decimal
    weak var owner: Owner?
    
    init(name: String, price: Decimal) {
        self.name = name
        self.price = price
        print("\(name) ინიციალიზებულია.")
    }
    
    deinit {
        print("\(name) დეინიციალიზებულია.")
    }
}

var barbare: Owner? = Owner(name: "Barbare")
var shoes: LouboutinShoes? = LouboutinShoes(name: "So Kate 120 patent leather pumps", price: 795.00)

barbare = nil // Barbare დეინიციალიზებულია.
shoes = nil // So Kate 120 patent leather pumps დეინიციალიზებულია.



//: ### 📝 მაგალითი 3 - Unowned Reference
class Client {
    let name: String
    let idNumber: UInt64
    let birthdate: String
    var card: TBCStudentCard?
    
    init(name: String, idNumber: UInt64, birthdate: String) {
        self.name = name
        self.idNumber = idNumber
        self.birthdate = birthdate
        print("\(name) ინიციალიზებულია.")
    }
    
    deinit {
        print("\(name) დეინიციალიზებულია.")
    }
}

class TBCStudentCard {
    let number: UInt64
    let expirationDate: String
    let cvv: Int
    unowned let owner: Client
    
    init(number: UInt64, expirationDate: String, cvv: Int, owner: Client) {
        self.number = number
        self.expirationDate = expirationDate
        self.cvv = cvv
        self.owner = owner
        print("\(number) ინიციალიზებულია.")
    }
    
    deinit {
        print("\(number) დეინიციალიზებულია.")
    }
}

var johnDoe: Client? = Client(name: "John Doe", idNumber: 01013366990, birthdate: "01/01/2001")
johnDoe!.card = TBCStudentCard(number: 4556789312648597, expirationDate: "10/26", cvv: 141, owner: johnDoe!)

johnDoe = nil // John Doe დეინიციალიზებულია. , 4556789312648597 დეინიციალიზებულია.


//: ## ქლოჟერის გამოყენება და self-ის დაჭერა
//: ### 📝 მაგალითი 4 - Weak Reference
class PoorStudent {
    let challenge: String

    lazy var traumaDump: () -> Void = { [weak self] in
        guard let challenge = self?.challenge else {
            return
        }
        print("\(challenge)ა თიბისიში და იმედია დილის 6-ზე მოვასწრებ დავალების დასრულებას 🥹")
        print(CFGetRetainCount(self))
    }
    
    init(challenge: String) {
        self.challenge = challenge
    }
    
    deinit {
           print("სტუდენტი დეინიციალიზებულია.")
       }
}

var barbarika = PoorStudent(challenge: "კვარტლის ბოლო")
barbarika.traumaDump() // 2


/*
 var barbarika: PoorStudent? = PoorStudent(challenge: "კვარტლის ბოლო")
 barbarika!.traumaDump()
 barbarika = nil    // სტუდენტი დეინიციალიზებულია.
 */
