import UIKit

func testFunc(a: String?) {
    if let foo = a {
        print(foo)
    }
}

testFunc(nil)

func testFunc2(extern1 a: String, extern2 b: String) {
    print("\(a) and \(b)")
}

testFunc2(extern1: "foo", extern2: "bar")

func isAnagram1(first s1: String, second s2: String) -> Bool {
   return s1.characters.sort() == s2.characters.sort()
}

isAnagram1(first: "apple", second: "elppa")


class MSDie {
    var numSides: Int
    private var currentValue: Int
    
    init (numSides: Int) {
        self.numSides = numSides
        currentValue = random() % numSides + 1
    }
    
    func roll() -> Int {
        currentValue = random() % numSides + 1
        return currentValue
    }
    
    var value: Int {
        get {
            return currentValue
        }
        set {
            print("No Cheating")
        }
    }
}

let d = MSDie(numSides: 6)
d.value
d.value = 9
d.currentValue = 15
d.roll()
d.roll()


enum Year {
    case FirstYear(dorm: String, numCredits: Int)
    case Sophomore
    case Junior(dorm: String, numCredits: Int, internship: String)
    case Senior
}

func foo(x:Year) {
    switch x {
    case .FirstYear:
        print("new student")
    case .Sophomore:
        print("second")
    case .Junior(_,_,let intern):
        print(intern)
        print("hello world")
    case .Senior:
        print("more than 3 years")
    }
}

var y = Year.Junior(dorm:"Miller",numCredits:48,internship:"Hormel")
foo(y)
