import Foundation

// 💬 იმ პირობებში სადაც დაკონკრეტებული იყო ცვლადის ტიპები, მეც დავუკონკრეტე ყოველი შემთხვევისთვის.



// ✅ 1. შექმენით სამი Int ტიპის ცვლადი, მიანიჭეთ მათ მნიშვნელობა და დაბეჭდეთ მათი ნამრავლი.

var num1: Int = 1
var num2: Int = 2
var num3: Int = 3

print(num1 * num2 * num3)



// ✅ 2. შექმენით int ტიპის ცვლადი, მიანიჭეთ მას მნიშვნელობა და შეამოწმეთ ეს რიცხვი ლუწია თუ კენტი ტერნარი ოპერატორით.

var num4: Int = 36

print(num4 % 2 == 0 ? "ლუწი" : "კენტი")



// ✅ 3. შექმენით optional String-ის ტიპის და მიანიჭეთ თქვენი სახელის მნიშვნელობა. If let-ის მეშვეობით გაუკეთეთ unwrap და მნიშვნელობა დაპრინტეთ

var myName: String? = "Barbare"

if let myName {
    print(myName)
}



// ✅ 4. შექმენით ცვლადი სახელად isRaining ბულეანის ტიპის და მიანიჭეთ თქვენთვის სასურველი მნიშვნელობა. If-else-ის მეშვეობით შეამოწმეთ თუ მნიშვნელობა მიიღებს true მნიშვნელობას დაბეჭდეთ “ქოლგის წაღება არ დამავიწყდეს”, სხვა შემთხვევაში “დღეს ქოლგა არ დამჭირდება”.

var isRaining: Bool = true

if isRaining {
    print("ქოლგის წაღება არ დამავიწყდეს.")
}
else {
    print("დღეს ქოლგა არ დამჭირდება.")
}



// ✅ 5. შექმენით ორი int ტიპის ცვლადი a & b და მიანიჭეთ სასურველი რიცხვები. If-else-ით შეამოწმეთ თუ a მეტია b-ზე დაბეჭდეთ “a მეტია”,  სხვა შემთხვევაში “b მეტია”

var a: Int = 12
var b: Int = 24

if a > b {
    print("a მეტია.")
}
else {
    print("b მეტია.")
}



// ✅ 6. შექმენით მუდმივა Character ტიპის და მიანიჭეთ თქვენი სახელის პირველი ასოს მნიშვნელობა.

let myNameFirstLetter: Character = "B"



// ✅ 7. მოცემულია ორნიშნა რიცხვი, გაიგეთ არის თუ არა ერთიდაიმავე რიცხვებისაგან შემდგარი

var num5 = 66

    // მეთოდი 1️⃣ --> სტრინგის დახმარებით
var num5ToString = String(num5)
let num5FirstNum = num5ToString.first
let bothNumbersSame = num5ToString.dropFirst().allSatisfy { $0 == num5FirstNum}
print(bothNumbersSame ? "მოცემული რიცხვი შედგება ერთიდაიმავე ციფრებისგან." : "მოცემული რიცხვი არ შედგება ერთიდაიმავე ციფრებისგან.")

    // მეთოდი 2️⃣ --> მასივის დახმარებით
var num5ToArr: [Int] = num5ToString.compactMap{ $0.wholeNumberValue }
for n in num5ToArr.dropFirst() {
    if n != num5ToArr.first {
        print("მოცემული რიცხვი არ შედგება ერთიდაიმავე ციფრებისგან.")
        break
    }
    print("მოცემული რიცხვი შედგება ერთიდაიმავე ციფრებისგან.")
}

    // მეთოდი 3️⃣ --> თემურის მოწოდებული იდეა
var firstDigit = num5 / 10
var secondDigit = num5 % 10
print(firstDigit == secondDigit ? "მოცემული რიცხვი შედგება ერთიდაიმავე ციფრებისგან." : "მოცემული რიცხვი არ შედგება ერთიდაიმავე ციფრებისგან.")



// ✅ 8.აიღეთ ცვლადი numberOfMonths მიანიჭეთ მნიშვნელობა და იმის მიხედვით თუ მერამდენე თვეა დაბეჭდეთ ის (გაზაფხული, ზაფხული, შემოდგომა, ზამთარი) შესაბამისად.

var numberOfMonths = 9

if numberOfMonths >= 3 && numberOfMonths <= 5 {
    print("გაზაფხული")
}
else if numberOfMonths >= 6 && numberOfMonths <= 8 {
    print("ზაფხული")
}
else if numberOfMonths >= 9 && numberOfMonths <= 11 {
    print("შემოდგომა")
}
else {
    print("ზამთარი")
}



// ✅ 9.შექმენით მთელი რიცხვის მქონე ცვლადი. თუ ეს ცვლადი იყოფა 3-ზე, დაბეჭდეთ “იყოფა 3-ზე”, თუ ეს ცვლადი იყოფა 4-ზე დაბეჭდეთ “იყოფა 4-ზე”, თუ იყოფა ორივეზე დაბეჭდეთ “იყოფა 3-ზე და 4-ზე”

    // 1️⃣ მეთოდი
var wholeNum: Int = 369

if wholeNum % 3 == 0 && wholeNum % 4 == 0 {
    print("იყოფა 3-სა და 4-ზე.")
}
else if wholeNum % 3 == 0 {
    print("იყოფა 3-ზე.")
}
else if wholeNum % 4 == 0 {
    print("იყოფა 4-ზე.")
}
/*
else {
    print("არ იყოფა არც 3-სა და არც 4-ზე.")
}
 */

    // 2️⃣ მეთოდი
/*
თუ გვსურს სთეითმენთების ორდერის დაცვა, ანუ რომ დავიწყოთ მხოლოდ 3-ზე გაყოფით, მერე 4-ზე და მერე ორივეზე -> საჭიროებს ქონდიშენალ სთეითმენთების ნესთინგს, თორემ ისე პირველივე სთეითმენთის დაკმაყოფილებისას პრინტავს და არ ამოწმებს ორივეზე გაყოფას
 (ყველას თუ if-ზე დავწერთ ეგეც არის ვარიანტი, თუმცა მაგ შემთხვევაში ცალკეულსაც ამობეჭდავს და ორივეზე გაყოფასაც, მაგალითად 60-ის შემთხვევაში) --->
 
 if wholeNum % 3 == 0 {
     if wholeNum % 4 == 0 {
         print("იყოფა 3-სა და 4-ზე.")
     }
     else {
         print("იყოფა 3-ზე.")
     }
 }
 else if wholeNum % 4 == 0 {
     print("იყოფა 4-ზე.")
 }

 */



// ✅ 10.შექმენით ორი რიცხვითი ცვლადი num1, num2 და რაიმე String ტიპის ცვლადი რომელსაც ტერნარული ოპერატორის საშუალებით მიანიჭებთ “თანაბრად დაშორებულია ნულიდან” / “არ არის თანაბრად დაშორებული ნულიდან” შესაბამის მნიშვნელობას რომელსაც აკმაყოფილებს მოცემული ორი ცვლადი

    // 💬 პირველ დავალებაში უკვე მაქვს num1 და num2 გამოყენებული, ამიტომ number1, number2-ით ჩავანაცვლებ

var number1 = 3
var number2 = -3
var str = (abs(number1) == abs(number2)) ? "თანაბრად დაშორებულია ნულიდან." : "არ არის თანაბრად დაშორებული ნულიდან."
print(str)
