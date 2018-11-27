//
//  Voxosonus.swift
//  Voxosonus
//
//  Created by Heerco Grond on 21-08-18.
//

import Foundation
import CoreML

/**
 The Voxosonus class is the accesable part of the Voxosonus Framework through which the functionality can be used. In order to use the framework properly, a class with the LanguageAnalyzerDelegate protocol implemented must be defined and assigned.
 */
public class Voxosonus: LanguageAnalyzerDelegate {
    
    /**
     The Delegate to which the labelFound call will be presented.
    */
    public weak var delegate: VoxosonusDelegate!
    
    private var _speechRecognizer: SpeechRecognizer = SpeechRecognizer.sharedInstance()
    private var _languageAnalyzer: LanguageAnalyzer = LanguageAnalyzer.sharedInstance()
    private var _debug: Bool = false;
    
    public init(){
        print("Voxosonus Loaded and initialized.")
        _languageAnalyzer.delegate = self
    }
    
    // Public facing functionality.
    
    /**
     Subscribes a tag to the LanguageAnalyzer and activates speech recognition.
    */
    public func listenFor(tag: String) {
        _languageAnalyzer.addTag(tag)
        listen()
    }
    
    /**
     Subscribes multiple tags to the LanguageAnalyzer and activates speech recognition.
     */
    public func listenFor(tags: [String]) {
        _languageAnalyzer.addTags(tags)
        listen()
    }
    
    /**
     Subscribes a tag to the LanguageAnalyzer
    */
    public func subscribeTag(tag: String){
        _languageAnalyzer.addTag(tag)
    }
    
    /**
     Subscribes multiple tags to the LanguageAnalyzer
     */
    public func subscribeTags(tags: [String]){
        _languageAnalyzer.addTags(tags)
    }
    
    /**
     Removes a tag from the subscribed tags in the LanguageAnalyzer
     */
    public func removeTag(tag: String){
        _languageAnalyzer.removeTag(tag)
    }
    
    /**
     Removes multiple tags from the subscribed tags in the LanguageAnalyzer
    */
    public func removeTags(tags: [String]){
        _languageAnalyzer.removeTags(tags)
    }
    
    /**
     Verify whether or not the SpeechRecognizer is ready to activate.
     */
    public func isReady() -> Bool {
        return _speechRecognizer.isVoiceReady()
    }
    
    /**
     Change the language identifier used for the SpeechRecognizer. The default is "en-US".
     */
    public func changeIdentifier(identifier: String){
        _speechRecognizer.changeIdentifier(identifier)
    }
    
    /**
     Change the length of time the SpeechRecognizer will listen for input from speech in seconds. The default is 4 seconds.
     */
    public func setListenTime(deadlineTimer: Int) {
        _speechRecognizer.setListenTime(time: deadlineTimer)
    }
    
    /**
     Analyze existing sentence, in case voice recognition is not needed. Make sure you have subscribed tags or this will simply not output anything since it'll have no tags to compare to.
    */
    public func analyze(sentence: String) {
        _languageAnalyzer.analyze(sentence)
    }
    
    /**
     Start speech recognition. This will not return anything if there are no subscribed tags.
     */
    public func startListening() {
        listen();
    }
    
    /**
     Clean all subscribed tags in the LanguageAnalyzer.
     */
    
    public func cleanTags(){
        _languageAnalyzer.cleanTags()
    }
    
    // Private functions
    func listen() {
        _speechRecognizer.recordAndRecognizeSpeech()
    }
    
    func labelFound(_ label: String){
        delegate?.labelFound(label: label)
    }
}

/** Protocol impementing the labelFound function for use in your application once the loop has been completed. Returns a string based label.*/
public protocol VoxosonusDelegate: class {
    func labelFound(label: String)
}
