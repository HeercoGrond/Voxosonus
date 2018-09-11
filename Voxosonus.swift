//
//  Voxosonus.swift
//  Voxosonus
//
//  Created by Heerco Grond on 21-08-18.
//

import Foundation
import CoreML

@available(iOS 11.0, *)
class Voxosonus: NSObject {
    
    private var _speechRecognizer: SpeechRecognizer = SpeechRecognizer.sharedInstance()
    
    
    override init(){
        super.init()
    }
    
    func speechRecognizer() -> SpeechRecognizer {
        return self._speechRecognizer
    }
    
    func listenFor(_ tag: String) {
        
    }
    
}
