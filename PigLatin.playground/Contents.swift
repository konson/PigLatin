// Alecs Konson
//
// String Extenstion to translate strings into Pig Latin.
//
// Transforms each word by adding first letter to the end of the word and then adding "ay".
// Numbers and punctuation are accounted for.
// If a word starts with a vowel or is a single letter word, only the "ay" is added to end.
// Punctuation within the word is ignored (i.e. "didn't")
// Only the first letter of the word is moved. Sounds like "th", "ch" and "sh" are not accommodated.

import UIKit

extension NSRegularExpression {
    func matches(string: String) -> Bool {
        let range = NSRange(location: 0, length: string.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

extension String {
    
    func pigLatinize() -> String {
        
        if self == "" {return self}
        
        var words = self.components(separatedBy: " ")
        words = words.map({self.pigLatinizeWord($0)})
        
        return words.joined(separator: " ")
    }
    
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.dropFirst()
    }
    
    private func pigLatinizeWord(_ word: String) -> String {
        let containsNumberRegex = try! NSRegularExpression(pattern: "\\d")
        let containsPunctuationRegex = try! NSRegularExpression(pattern: "[.,?!\\/]")
        let startsWithVowelRegex = try! NSRegularExpression(pattern: "^[aeiouAEIOU]")
        let containsCapitalRegex = try! NSRegularExpression(pattern: "[A-Z]")
        
        var pigLatinWord = word
        var punctuation = ""
        
        if containsNumberRegex.matches(string: word){
            return word
        }
        
        if containsPunctuationRegex.matches(string: word) {
            punctuation = String(word.suffix(1))
            pigLatinWord = String(word.dropLast())
        }
        
        if startsWithVowelRegex.matches(string: word) {
            return pigLatinWord + "ay" + punctuation
        }
        
        let firstChar = String(pigLatinWord.prefix(1))
        pigLatinWord = String(pigLatinWord.dropFirst())
        
        if containsCapitalRegex.matches(string: firstChar) {
            pigLatinWord = pigLatinWord.capitalizeFirstLetter()
        }
        
        pigLatinWord = pigLatinWord + firstChar.lowercased() + "ay" + punctuation
        
        return pigLatinWord
    }
}

//
//
//
// Test output
var testArray = ["Alice, is your grade point average above a 3.0? Mine isn't.",
                 "I am Bob.",
                 "No, I am Bob!",
                 "500",
                 "500!",
                 ""]

for index in (0..<testArray.count) {
    print("Input:  " + testArray[index] + "\nOutput: " + testArray[index].pigLatinize() +
          "\n-----------------------------")
}

