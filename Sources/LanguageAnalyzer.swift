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
    var _tagDictionary: [Tag] = []
    
    override init (){
        super.init()
    }
    
    /** Adds a tag to the dictionary of tags to scan for from the model.*/
    func addTag(_ tag: Tag){
        
        if(!_tagDictionary.contains(where: { $0.value == tag.value } )){
            _tagDictionary.append(tag);
        }
    }
    
    /** Adds each tag from the collection seperately. */
    func addTags(_ tags: [Tag]){
        for tag in tags {
            addTag(tag)
        }
    }
    
    func removeTag(_ tag: Tag){
        if let index = _tagDictionary.lastIndex(where: { $0.value == tag.value }){
            _tagDictionary.remove(at: index)
        }
    }
    func removeTags(_ tags: [Tag]){
        for tag in tags {
            removeTag(tag)
        }
    }
    
    func cleanTags(){
        _tagDictionary = []
    }
    
    /** Analyzes the input sentence through the Model. If a label is returned that is recognized within the tags subscribed, will call the labelfound function on the delegate.*/
    func analyze(_ sentence: String) {
        #if DEBUG
        print("Starting analysis of " + sentence)
        #endif
        let input = VoxosonusMLModelInput(text: sentence)

        do {
            let modelPrediction = try model.prediction(input: input)
            let predictedLabel = Tag(tagname: modelPrediction.label)
            
            #if DEBUG
            print("Prediction label is " + predictedLabel.value)
            #endif
            if(_tagDictionary.contains(where: { $0.value == predictedLabel.value })){
                delegate.labelFound(predictedLabel)
            } else {
                #if DEBUG
                print("The label found was not subscribed")
                #endif
                delegate.labelFound(Tag(tagname: "undefined")) //Return undefined. There is an argument to be made that perhaps this should return either nothing or should trigger something else in the delegate. This seems to be the simpler solution.
            }
        } catch {
            #if DEBUG
            print("Encountered an error")
            print(error)
            #endif
        }
    }
}

/** Protocol implementing the labelFound function when the LanguageAnalyzer has completed analyzation of the input sentence. This should be kept internally. If you want the public protocol, view the VoxosonusDelegate protocol. */
protocol LanguageAnalyzerDelegate: class {
    func labelFound(_ label: Tag)
}
