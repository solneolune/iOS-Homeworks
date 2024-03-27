import Foundation

//: # 🙇🏻‍♀️ Main
//: ### ✅ 1. შექმენით ენამი Gender სადაც იქნება 2 გენდერი (გენდერზე არ გამომეკიდოთ, თუ გინდათ მეტი ჩაამატეთ)
enum Gender {
    case Female
    case Male
    case Other // მომავლის ინვესტიცია
}

//: ### ✅ 2. შექმენით Protocol სახელად SuperBeing. გაუწერეთ მას ფროფერთები - name: String, strength: Int, speed: Int, weakness: String, gender: Gender
protocol SuperBeing {
    var name: String { get }
    var strength: Int { get }
    var speed: Int { get }
    var weakness: String { get }
    var gender: Gender { get }
}

//: ### ✅ 3. SuperBeing-ის strength-სა და speed-ს მიეცით default მნიშვნელობა
extension SuperBeing {
    
    var strength: Int {
        return 80
    }
    
    var speed: Int {
        return 90
    }
    
}

//: ### ✅ 4. შექმენით კლასები Superhero და SuperVillain, დაუქონფორმეთ SuperBeing-ს.
class SuperHero: SuperBeing {
    var name: String
    var strength: Int
    var speed: Int
    var weakness: String
    var gender: Gender
    
    init(name: String, strength: Int, speed: Int, weakness: String, gender: Gender) {
        self.name = name
        self.strength = strength
        self.speed = speed
        self.weakness = weakness
        self.gender = gender
    }
}

class SuperVillain: SuperBeing {
    var name: String
    var strength: Int
    var speed: Int
    var weakness: String
    var gender: Gender
    
    init(name: String, strength: Int, speed: Int, weakness: String, gender: Gender) {
        self.name = name
        self.strength = strength
        self.speed = speed
        self.weakness = weakness
        self.gender = gender
    }
}

//: > შემდეგ 3 თასქს ერთ იქსთენშენში გავაერთიანებ, რადგან ვასოს გადმოცემით ბევრის გამოყენება ცუდი იდეაა
//: ### ✅ 5. გაუწერეთ Superhero კლასს დამატებითი პარამეტრები outfitColor: String, equipment: String, vehicle: String
//: ### ✅ 6. გაუწერეთ Superhero კლასს მეთოდი - rescue, რომელიც პარამეტრად მიიღებს დაზარალებულის სახელს და დაბეჭდავს - “‘სუპერგმირის სახელი’ არ შეუშინდა სახიფათო სიტუაციას და ‘დაზარალებულის სახელი’ გადაარჩინა სიკვდილს” (მაგ: “ბეტმენი” არ შეუშინდა სახიფათო სიტუაციას და “გელა” გადაარჩინა სიკვდილს).
//: ### ✅ 7. გაუწერეთ Superhero კლასს მეთოდი - combat, რომელიც პარამეტრად მიიღებს Supervillain-ს და დაბეჭდავს - “‘სუპერგმირის სახელი’ შეერკინა და დაამარცხა ‘ბოროტმოქმედის სახელი’” (მაგ: “ბეტმენი” შეერკინა და დაამარცხა “ჯოკერი”)
extension SuperHero {
    
    var outfitColor: String {
        return "Tsigrovi"
    }
    var equipment: String {
        return "Changali"
    }
    var vehicle: String {
        return "Faetoni"
    }
    
    func rescue(_ victim: String) {
        print("\(name) არ შეუშინდა სახიფათო სიტუაციას და \(victim) გადაარჩინა სიკვდილს.")
    }
    func combat(_ villain: SuperVillain) {
        print("\(name) შეერკინა და დაამარცხა \(villain.name)")
    }
    
}

//: > შემდეგ 3 თასქს ერთ იქსთენშენში გავაერთიანებ, რადგან ვასოს გადმოცემით ბევრის გამოყენება ცუდი იდეაა
//: ### ✅ 8. გაუწერეთ SuperVillain კლასს დამატებითი პარამეტრები evilScheme: String, obsession: String, rivalry: String
//: ### ✅ 9. გაუწერეთ SuperVillain კლასს მეთოდი - attack - რომელიც პარამეტრად მიიღებს Superhero-ს და დაბეჭდავს - “ბოროტმ. სახელი” გეგმავს თავდასხმას და მთელი ქალაქის მიწასთან გასწორებას, საეჭვოა “სუპერგმირის სახელი” მის შეჩერებას თუ შეძლებს” (მაგ: “ჯოკერი” გეგმავს თავდასხმას და მთელი ქალაქის მიწასთან გასწორებას, საეჭვოა “ბეტმენი” მის შეჩერებას თუ შეძლებს)
//: ### ✅ 10. გაუწერეთ SuperVillain კლასს მეთოდი experimentation - რომელიც პარამეტრად მიიღებს სტრინგს (subject) და დაბეჭდავს - “‘ბოროტმოქმედის სახელი’ ექსპერიმენტებს ატარებს დაუცველ მოქალაქებზე, მისი მსხვერპლი ამჟამად ‘მსხვერპლის სახელი’ აღმოჩნდა” (მაგ: “ჯოკერი” ექსპერიმენტებს ატარებს დაუცველ მოქალაქებზე, მისი მსხვერპლი ამჟამად “გელა” აღმოჩნდა)
extension SuperVillain {
    
    var evilScheme: String {
        return "ზედა სართულის მეზობლის მანქანის ბორბლების ჩაფუშვა"
    }
    var obsession: String {
        return "ზედა სართულის მეზობლის ტანჯვით სულის ამოხდის მირაჟები"
    }
    var rivalry: String {
        return "ზედა სართულის მეზობელი"
    }
    
    func attack(_ hero: SuperHero) {
        print("\(name) გეგმავს თავდასხმას და მთელი ქალაქის მიწასთან გასწორებას, საეჭვოა \(hero.name) მის შეჩერებას თუ შეძლებს.")
    }
    func experimentation(_ subject: String) {
        print("\(name) ექსპერიმენტებს ატარებს დაუცველ მოქალაქებზე, მისი მსხვერპლი ამჟამად \(subject) აღმოჩნდა.")
    }
    
}

//: ### ✅ 11. შექმენით მინიმუმ 5-5 ობიექტი თითოეული SuperBeing-ის დაქონფირმებული კლასებიდან
    // ორიგინალი
let jvarosnuliBarbare = SuperVillain(name: "ჯვაროსნული ბარბარე", strength: 99, speed: 11, weakness: "ობობა", gender: Gender.Female)
let buddhistBarbare = SuperHero(name: "ბუდისტი ბარბარე", strength: 0, speed: 0, weakness: "ისევ ობობა", gender: Gender.Female)

jvarosnuliBarbare.attack(buddhistBarbare)
jvarosnuliBarbare.experimentation("ზედა სართულის მეზობელი")
print(buddhistBarbare.outfitColor)
print(buddhistBarbare.vehicle)



    // დანარჩენები
let skywalker = SuperHero(name: "Luke Skywalker", strength: 80, speed: 80, weakness: "ტემპერამენტი", gender: Gender.Male)
let vader = SuperVillain(name: "Darth Vader", strength: 95, speed: 77, weakness: "ემო", gender: Gender.Male)

skywalker.combat(vader)
skywalker.rescue("ყველა გარდა ბარბარეს ზედა სართულის მეზობლისა")
vader.attack(skywalker)
vader.experimentation("ბარბარეს ზედა სართულის მეზობელი")



let holmes = SuperHero(name: "Sherlock Holmes", strength: 100, speed: 100, weakness: "Jim Moriarty", gender: Gender.Male)
let moriarty = SuperVillain(name: "Jim Moriarty", strength: 100, speed: 100, weakness: "Sherlock Holmes", gender: Gender.Male)

holmes.combat(moriarty)
holmes.rescue("ყველა გარდა ბარბარეს ზედა სართულის მეზობლისა")
moriarty.attack(holmes)
moriarty.experimentation("ბარბარეს ზედა სართულის მეზობელი")



let batman = SuperHero(name: "Bruce Wayne", strength: 94, speed: 62, weakness: "საჭმლის მომზადება", gender: Gender.Male)
let joker = SuperVillain(name: "Jack Oswald White", strength: 54, speed: 100, weakness: "ცოტათი მენტალური დარღვევები", gender: Gender.Male)

joker.attack(batman)
joker.experimentation("ბარბარეს ზედა სართულის მეზობელი")
batman.combat(joker)
batman.rescue("ყველა გარდა ბარბარეს ზედა სართულის მეზობლისა")



let janedoe = SuperHero(name: "Jane Doe", strength: 100, speed: 100, weakness: "მენისკი", gender: Gender.Female)
let johndoe = SuperVillain(name: "John Doe", strength: 99, speed: 99, weakness: "მეოთხე და მეხუთე მალთაშუა თიაქრები", gender: Gender.Other)

johndoe.attack(janedoe)
johndoe.experimentation("ბარბარეს ზედა სართულის მეზობელი")
janedoe.combat(johndoe)
janedoe.rescue("ყველა გარდა ბარბარეს ზედა სართულის მეზობლისა")



//: # 🤷🏻‍♀️ Optional
//: წარმოიდგინეთ სცენა სადაც ორი სუპერგმირი - დრეიკი და ლექს-სენი ერთმანეთს ეჯიბრებიან თუ რომელი უფრო სწრაფია. დრეიკი ამბობს რომ ის ყველაზე სწრაფია მსოფლიოში და რიანაც უდასტურებს. -“ლექს-სენს არცერთი შეჯიბრი არ წაუგია ისტორიაში” აცხადებს მისი კოლაბორატორი თაკო და დასძენს, რომ დრეიკი შიშისაგან უნდა კანკალებდეს, რადგან არც კი იცის რა ელოდება. ამ სუპერგმირების ბედი თქვენზეა დამოკიდებული, თქვენ უნდა გადაწყვიტოთ ვინ არის მსოფლიოში ყველაზე სწრაფი და ვინ შეძლებს ბილბორდის ტოპ ჩარტების განადგურებას.
//: ### ✅ 1. დაწერეთ ჯენერიკ ფუნქცია compareSwiftness რომელიც იღებს მხოლოდ ორ პარამეტრს პირველ და მეორე სუპერგმირებს რომლებიც დაქვემდებარებულები იქნებიან SuperBeing პროტოკოლზე, ფუნქცია უნდა აბრუნებდეს სტრინგს
//: ### ✅ 2. ფუნქციის ბადიში შეამოწმეთ speed მნიშვნელობები ორივე სუპერგმირის
//: ### ✅ 3. დააბრუნეთ სტრინგი აღწერით თუ რომელი სუპერგმირია უფრო სწრაფი (გაითვალისწინეთ ისიც თუ სიჩქარეები ერთმანეთის ტოლია)
func compareSwiftness<T: SuperBeing>(_ firstSuperHero: T, _ secondSuperHero: T) -> String {
    if firstSuperHero.speed > secondSuperHero.speed {
        print("\(firstSuperHero.name) უფრო შუსტრია ვიდრე \(secondSuperHero.name).")
        return "\(firstSuperHero.name) უფრო შუსტრია ვიდრე \(secondSuperHero.name)."
    } else if firstSuperHero.speed < secondSuperHero.speed {
        print("\(firstSuperHero.name) უფრო შუსტრია ვიდრე \(secondSuperHero.name).")
        return "\(secondSuperHero.name) უფრო შუსტრია ვიდრე \(firstSuperHero.name)."
    } else {
        print("\(firstSuperHero.name) უფრო შუსტრია ვიდრე \(secondSuperHero.name).")
        return "\(firstSuperHero.name) და \(secondSuperHero.name), ორივე შუსტრები არიან."
    }
}

let lexseni = SuperHero(name: "ლექსსსსსენი", strength: 100, speed: 100, weakness: "არ აქვს", gender: Gender.Male)
let drake = SuperHero(name: "დრეიკი", strength: 0, speed: 0, weakness: "ჩვენ ლექსოს ვერ სჯობს", gender: Gender.Male)

compareSwiftness(lexseni, drake)
