import Foundation
//: # Main Tasks
//: ### ✅ 1. while ციკლის გამოყენებით, 1-დან 20-მდე დაბეჭდეთ ყველა კენტი რიცხვის ნამრავლი.
var num = 1
var oddNumProduct = 1

while num < 20 {
    if num % 2 == 1 { // ან num % 2 != 0
        oddNumProduct *= num
    }
    num += 1
}
print("1-დან 20-მდე ყველა კენტი რიცხვის ნამრავლია: \(oddNumProduct)")

//: ### ✅ 2. შექმენით String ტიპის ცვლადი და ციკლის გამოყენებით შემოაბრუნეთ ის, მაგ: თუ გვაქვს “Test” უნდა მივიღოთ “tseT”
var str = "Test"
var reversedStr = ""

for char in str {
    reversedStr = "\(char)" + reversedStr
}
print("სტრინგი \"\(str)\"-ის შებრუნებული ვერსიაა: \"\(reversedStr)\"")

//: ### ✅ 3. while loop-ისა და switch statement-ის გამოყენებით შექმენით უსასრულო შუქნიშანი, რომელიც ბეჭდავს შემდეგნაირად. "🔴->🌕->🟢->🔴->🌕..."
//var trafficLight = "🔴"
//
//while true {
//    switch trafficLight {
//    case "🔴":
//        print(trafficLight)
//        trafficLight = "🟡"
//    case "🟡":
//        print(trafficLight)
//        trafficLight = "🟢"
//    case "🟢":
//        print(trafficLight)
//        trafficLight = "🔴"
//    default:
//        break
//    }
//}
//: ### ✅ 4. Taylor Swift-ის კონცერტის ბილეთები იყიდება, თუმცა რაოდენობა ძალიან შეზღუდულია. While loop-ის მეშვეობით შექმენით ბილეთების გაყიდვის სიმულაცია და ყოველ გაყიდულ ბილეთზე დაბეჭდეთ “ბილეთი გაყიდულია, დარჩენილია მხოლოდ X რაოდენობა”, მანამ სანამ ბილეთების რაოდენობა მიაღწევს 0-ს, რის შემდეგაც ბეჭდავთ - “ყველა ბილეთი გაყიდულია გელოდებით კონცერტზე”
var availableTickets = 33
print("🆘 იყიდება Taylor Swift-ის კონცერტის \(availableTickets) ბილეთი! 🆘")

while availableTickets > 1 {
    availableTickets -= 1
    print("ბილეთი გაყიდულია, დარჩენილია მხოლოდ \(availableTickets) რაოდენობა")
}
print("ყველა ბილეთი გაყიდულია, გელოდებით კონცერტზე")
//: ### ✅ 5. შექმენით array, შეავსეთ ისინი ელემენტებით. შეამოწმეთ და დაბეჭდეთ: "array-ში ყველა ელემენტი განსხვავებულია" ან "array შეიცავს მსგავს ელემენტებს"  (array-ს ტიპს არაქვს მნიშვნელობა.)
// თუ ვიგულისხმებთ რომ მასივი ჰომოგენურია, მარტივი მეთოდი მნიშვნელობების შესადარებლად -->
var arr = [1, 2, 3, 4]
let firstEl = arr.first

var isSimilar = true;

for el in arr {
    if el != firstEl {
        isSimilar = false
        break
    }
}

if isSimilar {
    print("array შეიცავს მსგავს ელემენტებს.")
} else {
    print("array-ში ყველა ელემენტი განსხვავებულია.")
}



// კიდევ უფრო ბეისიქ მეთოდი nested ლუპების გამოყენებით
for i in 0..<arr.count {
    for j in (i + 1)..<arr.count {
        if arr[i] != arr[j] {
            isSimilar = false
            break
        }
    }
}
if isSimilar {
    print("array შეიცავს მსგავს ელემენტებს.")
} else {
    print("array-ში ყველა ელემენტი განსხვავებულია.")
}


// მასივის ელემენტების ტიპებისა და მნიშვნელობების შედარება + შერეულ მასივებში -->
func checkArrHomogeneity(_ arr: [Any]) -> Void {
    let hasSameElementTypes = arr.allSatisfy({ type(of: arr[0]) == type(of: $0) })
    
    let hasSameElementValues = arr.dropFirst().allSatisfy({ element in
        guard let firstElement = arr.first else {
            return false
        }
        let firstElementToString = String(describing: firstElement)
        let arrElementToString = String(describing: element)
        return firstElementToString == arrElementToString
    })
    
    //    if hasSameElementTypes && hasSameElementValues {
    //        print("array: \(arr) --> შეიცავს მსგავსი ტიპის მსგავს ელემენტებს.")
    //    } else if hasSameElementValues {
    //        print("array: \(arr) --> შეიცავს სხვადასხვა ტიპის მსგავს ელემენტებს.")
    //    } else if hasSameElementTypes {
    //        print("array: \(arr) --> შეიცავს მსგავსი ტიპის სხვადასხვა ელემენტებს.")
    //    } else {
    //        print("array: \(arr) --> შეიცავს სხვადასხვა ტიპის სხვადასხვა ელემენტებს.")
    //    }
    
    switch (hasSameElementTypes, hasSameElementValues) {
    case (true, true):
        print("array: \(arr) --> შეიცავს მსგავსი ტიპის მსგავს ელემენტებს.")
    case (false, true):
        print("array: \(arr) --> შეიცავს სხვადასხვა ტიპის მსგავს ელემენტებს.")
    case (true, false):
        print("array: \(arr) --> შეიცავს მსგავსი ტიპის სხვადასხვა ელემენტებს.")
    default:
        print("array: \(arr) --> შეიცავს სხვადასხვა ტიპის სხვადასხვა ელემენტებს.")
        
    }
    
}

var arr1: [Any] = [3, 6, 9, "Barbare", true, "S"]
var arr2 = [1, 2, 3, 4]
var arr3: [Any] = [2, 2, 2, "2"]
var arr4 = [3, 3, 3]

checkArrHomogeneity(arr1)
checkArrHomogeneity(arr2)
checkArrHomogeneity(arr3)
checkArrHomogeneity(arr4)
//: ### ✅ 6. დაწერეთ ქლოჟერი რომელიც გამოითვლის ორი რიცხვის სხვაობას და დააბრუნებს მიღებულ მნიშვნელობას
// 🙂 Int ტიპის ინფუთ-აუთფუთი -->
let intNumDifference: (Int, Int) -> Int = { (x, y) in
    let difference = x - y
    print("რიცხვების \(x) და \(y)-ის სხვაობაა - \(difference).")
    return difference
}
intNumDifference(99, 36)

// 😀 Decimal ტიპის ინფუთ-აუთფუთი არითმეტიკული სიზუსტვისთვის -->
let numDifference: (Decimal, Decimal) -> Decimal = { (x, y) in
    let difference = x - y
    print("რიცხვების \(x) და \(y)-ის სხვაობაა - \(difference).")
    return difference
}
numDifference(99, 36)
numDifference(99.9, 36.6)
numDifference(99.9, 36)
//: ### ✅ 7. დაწერეთ ფუნქცია, რომელსაც გადააწვდით String ტიპის პარამეტრს. დაითვალეთ ამ პარამეტრში თანხმოვნების რაოდენობა და დაბეჭდეთ ის.
// მარტივი მეთოდი
let consonants = "ბგდვზთკლმნპჟრსტფქღყშჩცძწჭხჯჰ"
var consonantCount = 0


func countConsonants(_ str: String) {
    for char in str {
        if consonants.contains(char) {
            consonantCount += 1
        }
    }
    print("ტექსტში \"\(str)\" არის \(consonantCount) თანხმოვანი.")
}
countConsonants("გზაზე მირბის კურდღელი.")



// "მარტივი" მეთოდი ჩანს მხოლოდ ხმოვნების ჩამოწერა სიმცირის გამო და მათთან შედარება, თუმცა არ ითვალისწინებს ისეთ შემთხვევებს, როცა ტექსტი მოიცავს სფეისებსა და პუნქტუაციას. სწორი პასუხისთვის ბევრად გართულებული კოდი გახდა საჭირო და მაინც არ მოიცავს სრულად იმ ქეისებს სადაც შესაძლოა სხვა ენის სიმბოლოები იყოს გამოყენებული.

let vowels = "აეიოუ"
var consonantCount1 = 0
let extraCharacters = CharacterSet.whitespacesAndNewlines.union(CharacterSet.punctuationCharacters)

func countConsonants1(_ str: String) { // მომიტევეთ სახელებში 1 და 2-ებისთვის
    let cleanText = String(str.unicodeScalars.filter { !extraCharacters.contains($0) })
    for char in cleanText {
        if !vowels.contains(char) {
            consonantCount1 += 1
        }
    }
    print("ტექსტში \"\(str)\" არის \(consonantCount1) თანხმოვანი.")
}
countConsonants1("გზაზე მირბის კურდღელი.")


// თანხმოვნების რაოდენობა ქართულ და ინგლისურ ტექსტებში
func countConsonants2(_ str: String) {
    let georgianConsonants = Set("ბგდვზთკლმნპჟრსტფქღყშჩცძწჭხჯჰ")
    let englishConsonants = Set("bcdfghjklmnpqrstvwxyz")
    
    var georgianConsonantCount = 0
    var englishConsonantCount = 0
    
    for char in str.lowercased() {
        if georgianConsonants.contains(char) {
            georgianConsonantCount += 1
        } else if englishConsonants.contains(char) {
            englishConsonantCount += 1
        }
    }
    
    print("მოცემულ ტექსტში ნაპოვნია \(georgianConsonantCount) ქართული და \(englishConsonantCount) ინგლისური თანხმოვანი.")
}

countConsonants2("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
countConsonants2("""
                 საფუარი გავხსნათ 150 გრამ თბილ წყალში, გავაჩეროთ 10 წთ და მოვურიოთ.
                 ფქვილი ჩავყაროთ დიდ ჯამში, შევურიოთ ოთახის ტემპერატუაზე დარბილებული 30 გრ კარაქი და კარგად ავსრისოთ.
                ჩავამატოთ 1 კვერცხი, შაქარი, მარილი,საფუარი და მოვზილოთ ელასტიური ცომი 10-15 წთ.
                """)
countConsonants2("ყვითელი - yellow - 노란색 - 01111001 01100101 01101100 01101100 01101111 01110111")
//: # Optional Tasks
//: ### 1. შექმენით ორი Int-ების array, შეავსეთ პირველი array 8, 4, 9, 9, 0, 2, და მეორე array 1, 0, 9, 2, 3, 7, 0, 1 ამ რიცხვებით. გააერთიანეთ ეს ორი array ერთ დასორტილ array-ში, ანუ შედეგი უნდა მიიღოთ ასეთი: 0, 0, 0, 1, 1, 2, 2, 3, 4, 7, 8, 9, 9, არ გამოიყენოთ sorted() ან რაიმე სხვა უკვე არსებული მეთოდი swift-იდან. დაბეჭდეთ მიღებული დასორტილი array.
var intArr1 = [8, 4, 9, 9, 0, 2]
var intArr2 = [1, 0, 9, 2, 3, 7, 0, 1]

//: ### ✅ 2. დაწერეთ ფუნქცია, რომელსაც გადააწვდით int ტიპის პარამეტრს. გამოითვალეთ ამ პარამეტრის ფაქტორიალი და დაბეჭდეთ
func findFactorial(_ num: Int) -> Int {
    if num == 0 {
        return 1
    } else {
        return num * findFactorial(num - 1)
    }
}

var factorialTest = findFactorial(4)
print("4-ის ფაქტორიალია: \(factorialTest)")
//: ### ✅ 3. შექმენით Int-ების array, შეავსეთ ის 0-იდან 10-ის ჩათვლით რიცხვებით. loop-ის  გამოყენებით დაშალეთ ეს array 2 array-იდ. ერთში გადაიტანეთ კენტი რიცხვები, მეორეში კი ლუწი რიცხვები, დაბეჭდეთ ორივე მიღებული array.
var tempArr = Array(0...10)
var evenNumArr: [Int] = []
var oddNumArr: [Int] = []

for i in 0..<tempArr.count {
    if tempArr[i] % 2 == 0 {
        evenNumArr.append(i)
    } else {
        oddNumArr.append(i)
    }
}

    // .append-ის გარეშე
/*
for i in 0..<tempArr.count {
    if tempArr[i] % 2 == 0 {
        evenNumArr += [tempArr[i]]
    } else {
        oddNumArr += [tempArr[i]]
    }
}
 */

print("""
    მასივი \(tempArr) ლუწ და კენტ რიცხვებად დაყოფისას გვაძლევს ორ ახალ მასივს -->
       - ლუწი რიცხვების მასივი: \(evenNumArr)
       - კენტი რიცხვების მასივი: \(oddNumArr)
    """)
