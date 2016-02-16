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



var 💩 = "Lucas"
print(💩)

var lucas =  "💩"
print(lucas)