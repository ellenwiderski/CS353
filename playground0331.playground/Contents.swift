//: Playground - noun: a place where people can play

import UIKit

func isPrime(num: Int) -> Bool {
    if num == 1 {
        return false
    }
    if num <= 3 {
        return true
    }
    
    for divisor in 2..<num/2 {
        if num % divisor == 0 {
            return false
        }
    }
    
    return true
}

var myPrimes = Array(count: 50000, repeatedValue: false)

var start = CACurrentMediaTime()
for i in 1 ..< myPrimes.count {
    myPrimes[i] = isPrime(i)
}
var end = CACurrentMediaTime()
print(end-start)

start = CACurrentMediaTime()
var group = dispatch_group_create()

for i in 1 ..< myPrimes.count {
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0)) {
        myPrimes[i] = isPrime(i)
    }
}

//dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0)) {
//    for i in 1 ..< myPrimes.count/2 {
//        myPrimes[i] = isPrime(i)
//    }
//}
//
//dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0)) {
//    for i in myPrimes.count/2 ..< myPrimes.count {
//        myPrimes[i] = isPrime(i)
//    }
//}

dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
    end = CACurrentMediaTime()
    print("done in \(end-start) seconds")
}

sleep(200)
myPrimes[11]
myPrimes[4001]