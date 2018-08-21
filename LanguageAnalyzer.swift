//
//  LanguageAnalyzer.swift//
//  Created by Heerco Grond on 22-05-18.
//  Copyright © 2018 Heerco Grond. All rights reserved.
//

import Foundation
import CoreML

@available(iOS 11.0, *)
class LanguageAnalyzer: NSObject {
    
    // Creation of shared instance for use.
    private static var sharedLanguageAnalyzer: LanguageAnalyzer = {
        let languageAnalyzer = LanguageAnalyzer();
        
        return languageAnalyzer
    }()
    
    // Return sharedInstance of LanguageAnalyzer to adhere to singleton pattern
    class func sharedInstance() -> LanguageAnalyzer {
        return sharedLanguageAnalyzer
    }
    
    // Variables
    private let _tagger: NSLinguisticTagger = NSLinguisticTagger(tagSchemes: [.lexicalClass, .lemma], options: 0)
    
    private var _wordDictionary : [String : String] = [:]
    
    override init (){
        super.init()
    }
    
    func analyze(_ sentence: String) {
        print(sentence)
        _wordDictionary = [:]
        _tagger.string = sentence
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace];
        let range = NSRange(location: 0, length: sentence.utf16.count)
        
        var lemmaArray: [String] = [];
        _tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: options) { tag, tokenRange, stop in
            if let lemma = tag?.rawValue {
                lemmaArray.append(lemma)
            }
        }
        
        _tagger.string = sentence
        var lexicalArray: [String] = []
        _tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options) {tag, tokenRange, stop in
            if let lexical = tag?.rawValue {
                lexicalArray.append(lexical)
            }
        }
        
        for index in 0..<lemmaArray.count {
            _wordDictionary.updateValue(lexicalArray[index], forKey: lemmaArray[index])
        }
        
        print(_wordDictionary)
    }
    
    func debug() {
        analyze("the quick brown fox jumped over the lazy dog")
    }
}

