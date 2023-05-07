import SwiftUI

func information(_ p: Double) -> Double{
    return log2(1/p)
}

func probability(word: String, state: [Int], words: [String]) -> Double{
    let possible: [String] = reduceToPossible(word: word, state: state, words: words)
    return Double(possible.count) / Double(words.count)
}

func entropy(word: String, states: [[Int]], words: [String]) -> Double{
    var e: Double = 0
    for state in states{
        let px = probability(word: word, state: state, words: words)
        if px != 0{
            e += px * information(px)
        }
    }
    return e
}

func reduceToPossible(word: String, state: [Int], words: [String]) -> [String]{
    var valid_words: [String] = []
    
    for i in 0 ..< word.count{
        let char = word[word.index(word.startIndex, offsetBy: i)]
        let rule = state[i]
        let word_list = i == 0 ? words: valid_words
        var temp: [String] = []
        
        var notSafePos: Int = -1
        var safe: Bool = true
        for j in 0 ..< state.count{
            if state[j] == 1{
                if word[word.index(word.startIndex, offsetBy: j)] == char{
                    safe = false
                    notSafePos = j
                }
            }
        }
        
        
    
        for w in word_list{
            if rule == 0{
                if !(w.contains(char)) && safe{
                    temp.append(w)
                }
                if !safe{
                    if w[w.index(w.startIndex, offsetBy: i)] != char && w[w.index(w.startIndex, offsetBy: notSafePos)] != char && w.contains(char){
                        temp.append(w)
                    }
                }
            }
            if rule == 1{
                if w[w.index(w.startIndex, offsetBy: i)] != char && w.contains(char) && i != notSafePos{
                    temp.append(w)
                }
            }
            if rule == 2{
                if w[w.index(w.startIndex, offsetBy: i)] == char{
                    temp.append(w)
                }
            }
        }
        valid_words = []
        for k in 0..<temp.count{
            valid_words.append(temp[k])
        }
    }
    return valid_words
}

//func reduceToPossible(word: String, state: [Int], words: [String]) -> [String]{
//    var valid_words: [String] = []
//    for i in 0 ..< word.count{
//        let char = word[word.index(word.startIndex, offsetBy: i)]
//        let rule = state[i]
//        let word_list = i == 0 ? words: valid_words
//        var temp: [String] = []
//        for w in word_list{
//            if rule == 0{
//                var safe: Bool = true
//                var notSafePos = 0
//                for j in 0 ..< state.count{
//                    if state[j] == 1{
//                        if word[word.index(word.startIndex, offsetBy: j)] == char{
//                            safe = false
//                            notSafePos = j
//                        }
//                    }
//                }
//                if safe && !w.contains(char){
//                    temp.append(w)
//                }
////                    if !safe{
////                        if w[w.index(w.startIndex, offsetBy: notSafePos)] != char{
////                            temp.append(w)
////                        }
////                    }
//            }
//            if rule == 1{
////                    var notSafePos = 0
////                    for j in 0 ..< state.count{
////                        if state[j] == 0{
////                            if word[word.index(word.startIndex, offsetBy: j)] == char{
////                                notSafePos = j
////                            }
////                        }
////                    }
////                    if w[w.index(w.startIndex, offsetBy: i)] != char && w[w.index(w.startIndex, offsetBy: notSafePos)] != char && w.contains(char){
////                        temp.append(w)
////                    }
//                if w[w.index(w.startIndex, offsetBy: i)] != char {
//                    temp.append(w)
//                }
//            }
//            if rule == 2{
//                if w[w.index(w.startIndex, offsetBy: i)] == char{
//                    temp.append(w)
//                }
//            }
//        }
//        valid_words = []
//        for k in 0..<temp.count{
//            valid_words.append(temp[k])
//        }
//    }
//    return valid_words
//}

//var temp: [String: Double] = [:]
//for word in Global.wordleWords{
//    temp[word] = entropy(word: word, states: Global.states, words: Global.wordleWords)
//}

print(reduceToPossible(word: "goofy", state: [0,1,1,0,0], words: Global.wordleWords))
