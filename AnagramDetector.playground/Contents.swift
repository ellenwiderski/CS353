func anagramDetector1(s1: String, s2: String) -> Bool {
    var s1arr = Array(s1.characters)
    var s2arr = Array(s2.characters)
    
    var pos1 = 0
    var stillOK = true
    
    if s1arr.count != s2arr.count {
        return false
    }
    
    while pos1 < s1.characters.count && stillOK {
        var pos2 = 0
        var found = false
        
        while pos2 < s2arr.count && !found {
            if s1arr[pos1] == s2arr[pos2] {
                found = true
            }
            else {
                pos2 += 1
            }
        }
        
        if found {
            s2arr[pos2] = "\0"
        }
        else {
            stillOK = false
        }
        
        pos1 += 1
    }
    return stillOK
}

func anagramDetector2(s1: String, s2: String) -> Bool {
    var s1arr = Array(s1.characters)
    var s2arr = Array(s2.characters)
    
    s1arr = s1arr.sort(<)
    s2arr = s2arr.sort(<)
    
    var pos = 0
    var matches = true
    
    while pos < s1arr.count && matches {
        if s1arr[pos] == s2arr[pos] {
            pos += 1
        }
        else {
            matches = false
        }
    }
    
    return matches
}

print("Detector 1:")

print(anagramDetector1("abcd", s2: "dcba"))

print(anagramDetector1("abcd", s2: "dcbawieafjo"))

print("Detector 2:")

print(anagramDetector2("abcd", s2: "dcba"))
// better
print(anagramDetector2("abcd", s2: "dcbawieafjo"))

