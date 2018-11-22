//
//  LanguageAnalyzer.swift//
//  Created by Heerco Grond on 22-05-18.
//  Copyright © 2018 Heerco Grond. All rights reserved.
//

import Foundation
import CoreML

class LanguageAnalyzer: NSObject {
    
    /** Delegate for the LanguageAnalyzerDelegate protocol*/
    weak var delegate: LanguageAnalyzerDelegate!
    
    /** Setting up a singleton of the LanguageAnalyzer to prevent multiple calls to the MLModel.*/
    private static var sharedLanguageAnalyzer: LanguageAnalyzer = {
        let languageAnalyzer = LanguageAnalyzer();
        
        return languageAnalyzer
    }()
    
    /** Share the singleton instance of the LanguageAnalyzer */
    class func sharedInstance() -> LanguageAnalyzer {
        return sharedLanguageAnalyzer
    }
    
    // Variables
    var model = VoxosonusMLModel()
    var _tagDictionary: [String] = []
    
    override init (){
        super.init()
    }
    
    /** Adds a tag to the dictionary of tags to scan for from the model.*/
    func addTag(_ tag: String){
        if(!_tagDictionary.contains(tag)){
            _tagDictionary.append(tag);
        }
    }
    
    /** Adds each tag from the collection seperately. */
    func addTags(_ tags: [String]){
        for tag in tags {
            addTag(tag)
        }
    }
    
    /** Removes a tag from the dictionary of tags to scan for from the model.*/
    func removeTag(_ tag: String){
        _tagDictionary = _tagDictionary.filter { $0 != tag }
    }
    
    /** Removes each tag from the collection seperately from the dictionary. */
    func removeTags(_ tags: [String]){
        for tag in tags {
            removeTag(tag)
        }
    }
    
    /** Analyzes the input sentence through the Model. If a label is returned that is recognized within the tags subscribed, will call the labelfound function on the delegate.*/
    func analyze(_ sentence: String) {
        print("Starting analysis of " + sentence)
        let input = VoxosonusMLModelInput(text: sentence)

        do {
            print("Starting prediction")
            let modelPrediction = try model.prediction(input: input)
            let predictedLabel = modelPrediction.label
            
            print("Prediction label is " + predictedLabel)
            if(_tagDictionary.contains(predictedLabel)){
                print("Casting to the delegate")
                delegate.labelFound(predictedLabel)
            }
        } catch {
            print("Encountered an error")
            print(error)
        }
    }
    
    /** Debug function. Remove later */
    func debug() {
        analyze("the quick brown fox jumped over the lazy dog")
    }
}

/** Protocol implementing the labelFound function when the LanguageAnalyzer has completed analyzation of the input sentence. This should be kept internally. If you want the public protocol, view the VoxosonusDelegate protocol. */
protocol LanguageAnalyzerDelegate: class {
    func labelFound(_ label: String)
}
