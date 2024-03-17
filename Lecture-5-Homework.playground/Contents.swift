import Foundation
//: # Main Tasks
//: ### ✅ 1. დაწერეთ ფუნქცია რომელიც პარამეტრად მიიღებს String-ს და დააბრუნებს ბულიანს. ფუნქციამ უნდა შეამოწმოს მიღებული სტრინგი სარკისებურია თუ არა (სიტყვა ან წინადადება რომელიც იკითხება ერთნაირად როგორც თავიდან, ისე ბოლოდან მაგ: “ანა”, “აირევი ივერია”, “მადამ”)

func checkStringMirroring(_ str: String) -> Bool {
    var reversedStr = ""
    
    for char in str {
        reversedStr = "\(char)" + reversedStr
    }
    
    if str == reversedStr {
        print("სტრინგი \(str) სარკისებურია.")
        return true
    } else {
        print("სტრინგი \(str) არ არის სარკისებური.")
        return false
    }
}

checkStringMirroring("ანა")
checkStringMirroring("ბარბარე")



//: ### ✅ 2. დაწერეთ ფუნქცია რომელიც გადაცემულ რიცხვების array-ს ააკვარდატებს, დაპრინტავს და დააბრუნებს მნიშვნელობას.

func squareNums(_ arr: [Int]) -> [Int] {
    var squaredArr: [Int] = []
    var squaredNum = 1
    
    for num in arr {
        squaredNum = num * num
        squaredArr.append(squaredNum)
    }
    
    print("მასივი \(arr)-ის ელემენტების კვადრატში აყვანისას მიიღება მასივი --> \(squaredArr)")
    return squaredArr
}

squareNums([1, 2, 3, 4, 5])



//: ### ✅ 3. დაწერეთ Closure რომელიც გაფილტრავს ლუწ რიცხვებს Int-ების Array-დან.

let filterEvenNum = { (_ arr: [Int]) -> [Int] in
    return arr.filter { $0 % 2 == 0 } // აბრუნებს ლუწ რიცხვებს თუ გაფილტრეთ და ეგენი დააბრუნეთო იგულისხმებოდა
    // return arr.filter { $0 % 2 == 1 } // აბრუნებს კენტ რიცხვებს თუ ლუწებისგან გაფილტრეთ მასივიო იგულისხმებოდა
}

print(filterEvenNum([1, 2, 3, 4, 5, 6]))



//: ### ✅ 4. დაწერეთ ფუნქცია, რომელიც პარამეტრად იღებს Int-ების მასივს. Escaping closure-ის მეშვეობით დაბეჭდეთ მიწოდებული მასივის ჯამი 5 წამის შემდეგ. დარწმუნდით რომ closure არის escaping და გამოიძახეთ ის მას შემდეგ რაც ფუნქცია დაბრუნდება.

let sumOfIntArr = { (sum: Int) in
    print("მასივის რიცხვების ჯამია: \(sum)")
}

func findSum(arr: [Int], closure: @escaping (Int) -> ()) {
    var sum = 0
    
    for num in arr {
        sum += num
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        closure(sum)
    }
}

var intArr = [1, 2, 3, 4, 10]
findSum(arr: intArr, closure: sumOfIntArr)



//: ### ✅ 5. შექმენით  კონტაქტების Dict სადაც key არის სახელი და value ტელეფონის ნომერი, დაამატეთ, დაბეჭდეთ/მოძებნეთ და წაშალეთ კონტაქტი

var contacts: [String: Int] = [
    "პირველი ბარბარე": 596336699,
    "მეორე ბარბარე": 596663399,
    "მესამე ბარბარე": 596993366
]

    // დამატება
func addContact(_ name: String, _ phoneNumber: Int) {
    contacts[name] = phoneNumber
}

    // დაბეჭდვა
func findContact(_ name: String) {
    if let phoneNum = contacts[name] {
        print("\(name) : \(phoneNum)")
    } else {
        print("\(name) ვერ მოიძებნა.")
    }
}

    //წაშლა
func deleteContact(_ name: String) {
    if let phoneNum = contacts[name] {
        contacts.removeValue(forKey: name)
    } else {
        print("\(name) ვერ მოიძებნა.")
    }
}

addContact("მეოთხე ბარბარე", 599199999)
findContact("მეოთხე ბარბარე")
deleteContact("მეოთხე ბარბარე")
    


//: ### ✅ 6. დაწერეთ ფუნქცია რომელიც პარამეტრად იღებს [String: Int] ტიპის Dictionary-ს და დააბრუნებს ანბანურად დალაგებულ dictionary-ს key ელემენტების მასივს.
func sortKeys (_ dict: [String: Int]) -> [String] {
    var sortedKeysArr: [String] = []
    
    for key in dict.keys {
        sortedKeysArr.append(key)
    }
    sortedKeysArr.sort()
    
    return sortedKeysArr
}

print(sortKeys(contacts))



//: ### ✅ 7. შექმენით Double-ების მასივი, შეავსეთ ის თქვენთვის სასურველი რიცხვებით.  loop-ის გამოყენებით იპოვეთ ყველაზე დიდი რიცხვი ამ მასივში და დაბეჭდეთ.
var doublesArr: [Double] = [1.1, 63.9, 90.36, 99.99, 100.01]
var largestNum: Double = doublesArr.first ?? 0

for num in doublesArr {
    if num > largestNum {
        largestNum = num
    }
}

print("მასივში \(doublesArr) ყველაზე დიდი რიცხვია \(largestNum)")



//: # Optional Tasks
//: ### მოცემულია Dictionary სადაც წარმოდგენილია ლელა წურწუმიას სიმღერებისა და მათი ხანგრძლივობა(წმ) მონაცემები:
let lelaWhatMovementIsThis: [String: Int] = [
    "ღამის სიჩუმე გაფანტე": 235,
    "ვიხსენებ ყველაფერს თავიდან": 219,
    "სულელი წვიმა": 231,
    "ალალ მე": 231,
    "იდუმალი ღამე": 221,
    "ჩუმად ნათქვამი": 199,
    "თეთრი ქარავანი": 221,
    "ძველი ვერხვები": 193
]

let songDurationsArr = Array(lelaWhatMovementIsThis.values)
//: ✅ 1. დაწერეთ ფუნქცია რომელიც გამოითვლის და დაბეჭდავს სიღერების ჯამურ ხანგრძლივობას წუთებში და წამებში
func findToTalTime(_ songDurations: [Int]) -> Int {
    var totalTime = 0
    
    for time in songDurations {
        totalTime += time
    }
    
    let minutes = totalTime / 60
    let seconds = totalTime % 60
    
    print("მოცემულ CD-ზე ლელა წურწუმიას სიმღერების მთლიანი ხანგრძლივობაა \(minutes) წუთი და \(seconds) წამი.")
    return totalTime // მესამე თასქში მჭირდება
}

findToTalTime(songDurationsArr)
//: ✅ 2. დაწერეთ ფუნქცია რომელიც იპოვის და დაბეჭდავს ყველაზე ხანგრძლივი და ხანმოკლე სიმღერის სახელს.
func findShortestAndLongest(_ album: [String: Int]) {
    guard let firstSong = album.first else {
        return
    }
    
    var longestSong = firstSong
    var shortestSong = firstSong
    
    for (title, time) in album {
        if time > longestSong.value {
            longestSong = (title, time)
        } else if time < shortestSong.value {
            shortestSong = (title, time)
        }
    }
    
    print("ალბომში ყველაზე გრძელი სიმღერაა - \(longestSong.key), ხოლო ყველაზე მოკლე - \(shortestSong.key).")
}

findShortestAndLongest(lelaWhatMovementIsThis)
//: ✅ 3. დაწერეთ ფუნქცია რომელიც გამოითვლის სიმღერების საშუალო ხანგრძლივობას
func findAverageSongLength(_ songDurations: [Int]) {
    let totalDuration = findToTalTime(songDurations)
    let averageDuration = Double(totalDuration) / Double(songDurations.count)
    
    let minutes = Int(averageDuration) / 60
    let seconds = Int(averageDuration) % 60
    
    print("სიმღერების საშუალო ხანგრძლივობაა -> \(averageDuration) წამი, ანუ მიახლოებით \(minutes) წუთი და \(seconds) წამი.")
}

findAverageSongLength(songDurationsArr)
//: ✅ 4. დაწერეთ ფუნქცია რომელიც შემთხვევითად ამოარჩევს სიმღერას და დაბეჭდავს მის სახელს
func printRandSongName(_ album: [String: Int]) {
    let songNames = Array(album.keys)
    
    let randI = Int.random(in: 0..<songNames.count)
    
    let randomSongName = songNames[randI]
    
    print("რენდომითობის პრინციპით ამორჩეული სიმღერა --> \(randomSongName)")
}

printRandSongName(lelaWhatMovementIsThis)
