//
//  Voxosonus.swift
//  Voxosonus
//
//  Created by Heerco Grond on 21-08-18.
//

import Foundation
import CoreML


public class Voxosonus {
    
    private var _speechRecognizer: SpeechRecognizer = SpeechRecognizer.sharedInstance()
    private var _languageAnalyzer: LanguageAnalyzer = LanguageAnalyzer.sharedInstance()
    private var _debug: Bool = false;
    
    init(){
        print("Voxosonus Loaded and initialized.")
        
        _languageAnalyzer.debug()
    }
    
    // Public facing functionality.
    public func listenFor(tag: String) {
        _languageAnalyzer.addTag(tag)
        listen()
    }
    
    public func listenFor(tags: [String]) {
        _languageAnalyzer.addTags(tags)
        listen()
    }
    
    public func subscribeTag(tag: String){
        _languageAnalyzer.addTag(tag)
    }
    
    public func subscribeTags(tags: [String]){
        _languageAnalyzer.addTags(tags)
    }
    
    public func removeTag(tag: String){
        _languageAnalyzer.removeTag(tag)
    }
    
    public func removeTags(tags: [String]){
        _languageAnalyzer.removeTags(tags)
    }
    
    public func isReady() -> Bool {
        return _speechRecognizer.isVoiceReady()
    }
    
    public func changeIdentifier(identifier: String){
        _speechRecognizer.changeIdentifier(identifier)
    }
    
    public func setListenTime(deadlineTimer: Int) {
        _speechRecognizer.setListenTime(time: deadlineTimer)
    }
    
    
    // Private functions
    func speechRecognizer() -> SpeechRecognizer {
        return self._speechRecognizer
    }
    
    func listen() {
        _speechRecognizer.recordAndRecognizeSpeech()
    }
    
}
