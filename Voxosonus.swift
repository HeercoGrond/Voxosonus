//
//  Voxosonus.swift
//  Voxosonus
//
//  Created by Heerco Grond on 21-08-18.
//

import Foundation

@available(iOS 11.0, *)
class Voxosonus: NSObject {
    
    private var _speechRecognizer: SpeechRecognizer!
    
    override init(){
        super.init()
        
        _speechRecognizer = SpeechRecognizer()
    }
    
    func speechRecognizer() -> SpeechRecognizer {
        return self._speechRecognizer
    }
    
    func listenFor() {
        
    }
    
}
