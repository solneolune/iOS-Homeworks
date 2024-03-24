import Foundation
//: ### ✅ 1. შევქმნათ Class Book.
//: - Properties: bookID(უნიკალური იდენტიფიკატორი Int), String title, String author, Bool isBorrowed.
//: - Designated Init.
//: - Method რომელიც ნიშნავს წიგნს როგორც borrowed-ს.
//: - Method რომელიც ნიშნავს წიგნს როგორც დაბრუნებულს.
class Book {
    static var i = 0 // უნიკალური იდენტიფიკატორისთვის, UUID მესიჯი რომ ვნახე უკვე დასრულებული მქონდა ოთხივე თასქი და ამიტომ დავტოვებ ასე
    
    var bookID: Int
    var title: String
    var author: String
    var isBorrowed: Bool
    
    init(title: String, author: String, isBorrowed: Bool = false) { // bookID მოვაშორე ინიციალიზაციიდან რადგან მე ვაესაინებ უნიკალურ მნიშვნელობას
        self.bookID = Book.i
        Book.i += 1
        self.title = title
        self.author = author
        self.isBorrowed = isBorrowed
    }
    
    func borrowBook() {
        isBorrowed = true
    }
    
    func returnBook() {
        isBorrowed = false
    }
}

 // ტესტები
let book1 = Book(title: "Murder on the Orient Express", author: "Agatha Christie")
let book2 = Book(title: "Totem and Taboo", author: "Sigmund Freud", isBorrowed: true)
let book3 = Book(title: "Kafka on the Shore", author: "Haruki Murakami")

print("Book 1 -> ID \(book1.bookID), Title: \(book1.title), Author: \(book1.author), Available: \(book1.isBorrowed)")
print("Book 2 -> ID \(book2.bookID), Title: \(book2.title), Author: \(book2.author), Available: \(book2.isBorrowed)")
print("Book 3 -> ID \(book3.bookID), Title: \(book3.title), Author: \(book3.author), Available: \(book3.isBorrowed)")

print("""
📌
--------------------------------------
Available Books - 23/03/2024 ->
1. \(book1.title): \(book1.isBorrowed ? "🚫" : "✅")
2. \(book2.title): \(book2.isBorrowed ? "🚫" : "✅")
3. \(book3.title): \(book3.isBorrowed ? "🚫" : "✅")
--------------------------------------
""")

book3.borrowBook()
book2.returnBook()

print("""
📌
--------------------------------------
Borrowed Books - 24/03/2024 ->
1. \(book1.title): \(book1.isBorrowed ? "🚫" : "✅")
2. \(book2.title): \(book2.isBorrowed ? "🚫" : "✅")
3. \(book3.title): \(book3.isBorrowed ? "🚫" : "✅")
--------------------------------------
""")

//: ### ✅ 2. შევქმნათ Class Owner
//: - Properties: ownerId(უნიკალური იდენტიფიკატორი Int), String name, Books Array სახელით borrowedBooks.
//: - Designated Init.
//: - Method რომელიც აძლევს უფლებას რომ აიღოს წიგნი ბიბლიოთეკიდან.
//: - Method რომელიც აძლევს უფლებას რომ დააბრუნოს წაღებული წიგნი.
class Owner {
    static var i = 0
    
    var ownerId: Int
    var name: String
    var borrowedBooks: [Book]
    
    init(name: String, borrowedBooks: [Book] = []) {
        self.ownerId = Owner.i
        Owner.i += 1
        self.name = name
        self.borrowedBooks = borrowedBooks
    }
    
    func allowBorrowing(_ book: Book) {
        if !book.isBorrowed {
            book.borrowBook()
            borrowedBooks.append(book)
            print("\(book.title) დაემატა თქვენს მიერ გატანილი წიგნების სიაში. გთხოვთ დააბრუნოთ წიგნი არაუგვიანეს 2 კვირაში.")
            print("იხილეთ თქვენი წიგნების სია: \(self.name): \(self.borrowedBooks.map { $0.title })")
        } else {
            print("\(book.title) ამჟამად არ არის ხელმისაწვდომი, სცადეთ მოგვიანებით.")
        }
    }
    
    func allowReturning(_ book: Book) {
        if borrowedBooks.contains(where: { $0 === book }) {
            book.returnBook()
            borrowedBooks.removeAll {$0 === book}
            print("\(book.title) დაბრუნებულია.")
            print("იხილეთ თქვენი წიგნების სია: \(self.name): \(self.borrowedBooks.map { $0.title })")
        } else {
            print("\(book.title) ვერ მოიძებნა თქვენს მიერ გატანილ წიგნებში.")
        }
    }
}

    // ტესტები
let owner1 = Owner(name: "გაიოზ ღლონტი")
let owner2 = Owner(name: "ენძელა ჩოლოყალშვილი")
let owner3 = Owner(name: "ტერენტი ამირანაშვილი")

owner1.allowBorrowing(book1)
owner1.allowBorrowing(book2)
owner2.allowBorrowing(book1)
owner3.allowBorrowing(book3)
owner1.allowReturning(book1)
owner3.allowReturning(book2)

 
//: ### ✅ 3. შევქმნათ Class Library
//: - Properties: Books Array, Owners Array.
//: - Designated Init.
//: - Method წიგნის დამატება, რათა ჩვენი ბიბლიოთეკა შევავსოთ წიგნებით.
//: - Method რომელიც ბიბლიოთეკაში ამატებს Owner-ს.
//: - Method რომელიც პოულობს და აბრუნებს ყველა ხელმისაწვდომ წიგნს.
//: - Method რომელიც პოულობს და აბრუნებს ყველა წაღებულ წიგნს.
//: - Method რომელიც ეძებს Owner-ს თავისი აიდით თუ ეგეთი არსებობს.
//: - Method რომელიც ეძებს წაღებულ წიგნებს კონკრეტული Owner-ის მიერ.
//: - Method რომელიც აძლევს უფლებას Owner-ს წააღებინოს წიგნი თუ ის თავისუფალია.
class Library {
    var booksArr: [Book]
    var ownersArr: [Owner]
    
    init(booksArr: [Book] = [], ownersArr: [Owner] = []) {
        self.booksArr = booksArr
        self.ownersArr = ownersArr
    }
    
    func addBook(_ book: Book) {
        booksArr.append(book)
        print("ბიბლიოთეკაში დაემატა ახალი წიგნი: \(book.title)")
    }
    
    func addOwner(_ owner: Owner) {
        ownersArr.append(owner)
        print("მკითხველთა ბაზაში დაემატა ახალი პირი: \(owner.name)")
    }
    
    func findAvailableBooks() -> [Book] {
        var availableBooks = [Book]()
        
        for book in booksArr {
            if !book.isBorrowed {
                availableBooks.append(book)
            }
        }
        
        if availableBooks.isEmpty {
            print("ამჟამად ბიბლიოთეკაში არც ერთი წიგნი არ არის ხელმისაწვდომი.")
        } else {
            print("ამჟამად ბიბლიოთეკაში ხელმისაწვდომი წიგნებია: \(availableBooks.map { $0.title })")
        }
        return availableBooks
    }
    
    func findAllBorrowedBooks() -> [Book] {
        var borrowedBooks = [Book]()
        
        for book in booksArr {
            if book.isBorrowed {
                borrowedBooks.append(book)
            }
        }
        
        if borrowedBooks.isEmpty {
            print("ამჟამად ბიბლიოთეკიდან არც ერთი წიგნი არ არის გატანილი.")
        } else {
            print("ამჟამად ბიბლიოთეკიდან გატანილი წიგნებია: \(borrowedBooks.map { $0.title })")
        }
        return borrowedBooks
    }
    
    func findOwnerByID(_ id: Int) -> Owner? {
        if ownersArr.indices.contains(id) {
            print("აიდით \"\(id)\" ნაპოვნია მომხმარებელი: \(ownersArr[id].name)")
            return ownersArr[id]
        } else {
            print("აიდით \"\(id)\" მომხმარებელი ვერ მოიძებნა.")
            return nil
        }
    }
    
    func findBooksBorrowedByOwner(_ id: Int) -> [Book]? {
        var owner: Owner
        
        if ownersArr.indices.contains(id) {
            owner = ownersArr[id]
            print("მომხმარებლის აიდით \(id)-ის მიერ გატანილი წიგნებია: \(owner.borrowedBooks.map { $0.title }) ")
            return owner.borrowedBooks
        } else {
            print("აიდით \"\(id)\" მომხმარებელი ვერ მოიძებნა.")
            return nil
        }
    }
    
    func allowOwnerBorrow(_ owner: Owner, _ book: Book) { // დუპლიკატი ლოგიკის გაწერა რომ არ გამოვიდეს, პირდაპირ ოუნერის კლასის მეთოდს გამოვიძახებ და ის ამოწმებს წიგნის ხელმისაწვდომობას
        owner.allowBorrowing(book)
    }
}

//: ### გავაკეთოთ ბიბლიოთეკის სიმულაცია.
//: - შევქმნათ რამოდენიმე წიგნი და რამოდენიმე Owner-ი, შევქმნათ ბიბლიოთეკა.
//: - დავამატოთ წიგნები და Owner-ები ბიბლიოთეკაში
//: - წავაღებინოთ Owner-ებს წიგნები და დავაბრუნებინოთ რაღაც ნაწილი.
//: - დავბეჭდოთ ინფორმაცია ბიბლიოთეკიდან წაღებულ წიგნებზე, ხელმისაწვდომ წიგნებზე და გამოვიტანოთ წაღებული წიგნები კონკრეტულად ერთი Owner-ის მიერ.
    // 💬 პირველ ორ თასქში უკვე მაქვს გატესტილი რამდენიმე ინსტანსის შექმნა და მეთოდები, ამიტომ გამოვიყენებ იგივე ინსტანსებს + დავამატებ
let book4 = Book(title: "Crime and Punishment", author: "Fyodor Dostoevsky")
let book5 = Book(title: "Anna Karenina", author: "Leo Tolstoy")

let owner4 = Owner(name: "სპარტაკ გარსევანიშვილი")
let owner5 = Owner(name: "მზექალა მუხრანელი")

let library = Library()

let booksToAdd = [book1, book2, book3, book4, book5]
let ownersToAdd = [owner1, owner2, owner3, owner4, owner5]

for book in booksToAdd {
    library.addBook(book)
}
for owner in ownersToAdd {
    library.addOwner(owner)
}

    // წიგნის გატანის მეთოდები -> 1. ბიბლიოთეკის მეთოდი 2. ოუნერის მეთოდი
library.allowOwnerBorrow(owner4, book4)
owner5.allowBorrowing(book1)

owner1.allowReturning(book2)


    // გავატანოთ გაიოზს ყველა ხელმისაწვდომი წიგნი
var findAvailBooks = library.findAvailableBooks()
for book in findAvailBooks {
    library.allowOwnerBorrow(owner1, book)
}
library.findBooksBorrowedByOwner(0) // გაიოზის მიერ წაღებული წიგნები


    // ბოლოჯერ გავტესტოთ ყველა ხელმისაწვდომი და გატანილი
library.findAvailableBooks()
library.findAllBorrowedBooks()


//: # Optional Tasks
//: შექმენით კლასი გამონათქვამების გენერატორი, სადაც განმარტავთ გამონათქვამს-ს რომელიც იქნება სტრინგებისგან შემდგარი კოლექცია. შექმენით მეთოდი სადაც დააბრუნებთ შერჩევითად სხვადასხვა ჯოუქს და დაბეჭდავთ მას, ასევე ჩაამატეთ მეთოდი, რომელიც ჩასვამს ან ამოაკლებს გამონათქვამს სიიდან. მოცემული გაქვთ “ქილერ” გამონათქვამების სია:
//: - დავინახე თუ არა მივხვდი, რომ – ” დევიღუპე. ”
//: - ისეთი აფერისტია, რომ ბანკომატებიც კი აძლევენ ფულს ვალად
//: - სულის ტკივილამდე ვტკივილობ….
//: - იმედის შუქი ჩამიქრა ვინმემ ასანთი მათხოვეთ
//: - არავინაა უნიკალური…მე არავინ ვარ…ე.ი უნიკალური ვარ
//: - ფულის წვიმა რომ მოდიოდეს ნისიების რვეული დამეცემა თავზე
//: - თქვენ მოჰკალით ძერა?
//: - ბებიააა... ბებია... ოლია მათხოვარი მევიდა...
//: - მზე აღარ ამოდის ჩაგვიჭრეს
class quoteGenerator {
    var quotes: [String]
    
    init(quotes: [String] = []) {
        self.quotes = quotes
    }
    
    func getRandomQuote() -> String? {
        guard let randQuote = quotes.randomElement() else {
            print("გამონათქვამები გაგვითავდა.")
            return nil
        }
        print(randQuote)
        return randQuote
    }
    
    func addQuote(_ quote: String) {
        quotes.append(quote)
    }
    
    func removeQuote(_ quote: String) {
        if let i = quotes.firstIndex(of: quote) {
            quotes.remove(at: i)
        } else {
            print("გამონათქვამი ვერ მოიძებნა.")
        }
    }
}

let quotes = quoteGenerator()

let quotesToAdd = ["დავინახე თუ არა მივხვდი, რომ – \" დევიღუპე \".", "ისეთი აფერისტია, რომ ბანკომატებიც კი აძლევენ ფულს ვალად", "სულის ტკივილამდე ვტკივილობ….", "იმედის შუქი ჩამიქრა ვინმემ ასანთი მათხოვეთ", "არავინაა უნიკალური…მე არავინ ვარ…ე.ი უნიკალური ვარ", "ფულის წვიმა რომ მოდიოდეს ნისიების რვეული დამეცემა თავზე", "თქვენ მოჰკალით ძერა?", "ბებიააა... ბებია... ოლია მათხოვარი მევიდა...", "მზე აღარ ამოდის ჩაგვიჭრეს"]

for quote in quotesToAdd {
    quotes.addQuote(quote)
}

quotes.getRandomQuote()

quotes.addQuote("100 რა ღორი კი არა ვარ")
quotes.addQuote("ისეთი კრიზისია ჩაის რომ ვსვამ მაგიდაზე ყველი და პურის სურათი მიდევს")
quotes.addQuote("შაქარი ისე გაძვირდა დიაბეტი \"სვეცკი\" დაავადება გახდა")
quotes.addQuote("სახლში ისე გვიჭირს, ისე გვიჭირს, მამაჩემი პურს ხაფანგიდან იპარავს")
quotes.addQuote("ძილის წინ ილოცე დეზდემონა???")

print(quotes.quotes.count)
quotes.removeQuote("მზე აღარ ამოდის ჩაგვიჭრეს")
print(quotes.quotes.count)
