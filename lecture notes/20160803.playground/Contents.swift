//: Playground - noun: a place where people can play

import UIKit

class Person {
    let name: String
    weak var apartment: Apartment?
    
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    weak var tenant: Person?
    
    init(unit: String) {
        self.unit = unit
        self.tenant = tenant
    }
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var p1: Person?
var unit1: Apartment?

p1 = Person(name: "John")
unit1 = Apartment(unit: "12B")

p1?.apartment
unit1?.tenant

p1!.apartment = unit1
unit1!.tenant = p1

p1?.apartment
unit1?.tenant

p1 = nil
unit1 = nil

extension String {
    func split() -> [String] {
        let y = self.characters
    }
}