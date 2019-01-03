//
//  Voxosonus.swift
//  Voxosonus
//
//  Created by Heerco Grond on 21-08-18.
//

import Foundation
import CoreML

/**
 The Voxosonus class is the accesable part of the Voxosonus Framework through which the functionality can be used. In order to use the framework properly, a class with the VoxosonusDelegate protocol implemented must be defined and assigned.
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
     Subscribes a Tag to the LanguageAnalyzer and activates speech recognition.
     */
    public func listenFor(tag: Tag) {
        _languageAnalyzer.addTag(tag)
        listen()
    }
    
    /**
     Subscribes multiple Tags to the LanguageAnalyzer and activates speech recognition.
     */
    public func listenFor(tags: [Tag]) {
        _languageAnalyzer.addTags(tags)
        listen()
    }
    
    /**
     Subscribes a Tag to the LanguageAnalyzer
     */
    public func subscribeTag(tag: Tag){
        _languageAnalyzer.addTag(tag)
    }
    
    /**
     Subscribes multiple Tags to the LanguageAnalyzer
     */
    public func subscribeTags(tags: [Tag]){
        _languageAnalyzer.addTags(tags)
    }
    
    /**
     Removes a Tag from the subscribed Tags in the LanguageAnalyzer
     */
    public func removeTag(tag: Tag){
        _languageAnalyzer.removeTag(tag)
    }
    
    /**
     Removes multiple Tags from the subscribed Tags in the LanguageAnalyzer
     */
    public func removeTags(tags: [Tag]){
        _languageAnalyzer.removeTags(tags)
    }
    
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
    
    public func startListening() {
        listen();
    }
    
    /**
     Clean all subscribed Tags in the LanguageAnalyzer.
     */
    public func cleanTags(){
        _languageAnalyzer.cleanTags()
    }
    
    // Private functions
    func listen() {
        _speechRecognizer.recordAndRecognizeSpeech()
    }
    
    func labelFound(_ label: Tag){
        delegate?.labelFound(label: label)
    }
}

/** Protocol impementing the labelFound function for use in your application once the loop has been completed. Returns a Tag based label.*/
public protocol VoxosonusDelegate: class {
    func labelFound(label: Tag)
}
