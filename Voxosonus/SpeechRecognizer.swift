//
//  SpeechRecognizer.swift//
//  Created by Heerco Grond on 22-05-18.
//  Copyright © 2018 Heerco Grond. All rights reserved.
//

import Foundation
import Speech

class SpeechRecognizer: NSObject, SFSpeechRecognizerDelegate {
    
    /** Setting up a singleton of the SpeechRecognizer to prevent multiple calls to the Speech framework.*/
    private static var sharedSonusSpeechRecognizer: SpeechRecognizer = {
        let sonusSpeechRecognizer = SpeechRecognizer()
        
        return sonusSpeechRecognizer
    }()
    
    /** Share the singleton instance of the SpeechRecognizer */
    class func sharedInstance() -> SpeechRecognizer {
        return sharedSonusSpeechRecognizer
    }
    
    // Variables.
    private var _speechRecognizer: SFSpeechRecognizer!
    private var _recognitionRequest : SFSpeechAudioBufferRecognitionRequest?
    private var _recognitionTask: SFSpeechRecognitionTask?
    private let _audioEngine = AVAudioEngine()
    private var _voiceReady: Bool = false
    private let _defaultIdentifier = "en-US"
    
    private var _deadline: Int = 4; // Deadline timer in seconds.
    
    override init() {
        super.init()
        
        changeIdentifier(_defaultIdentifier)
    }
    
    func changeIdentifier(_ identifier: String) {
        _speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: identifier))
        
        _speechRecognizer?.delegate = self;
        
        SFSpeechRecognizer.requestAuthorization { (authstatus) in
            var voiceAuthorized = false;
            
            switch(authstatus) {
            case .authorized:
                voiceAuthorized = true;
                
            case .denied:
                voiceAuthorized = false;
                #if DEBUG
                print("user didn't give permissions");
                #endif
            case .restricted:
                voiceAuthorized = false;
                #if DEBUG
                print("not allowed to use speech");
                #endif
                
            case .notDetermined:
                voiceAuthorized = false;
                #if DEBUG
                print("not yet said if it's allowed or not");
                #endif
            }
            
            OperationQueue.main.addOperation {
                self._voiceReady = voiceAuthorized
            }
        }
    }
    
    func isVoiceReady() -> Bool {
        return self._voiceReady
    }
    
    func setListenTime(time: Int) {
        self._deadline = time
    }
    
    func recordAndRecognizeSpeech() {
        _recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        var stringToAnalyze = "";
        let node = _audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self._recognitionRequest?.append(buffer)
        }
        
        _audioEngine.prepare()
        do {
            try _audioEngine.start()
        } catch {
            #if DEBUG
            print("Something went wrong with the starting of the audio engine:")
            return print(error)
            #endif
        }
        
        guard let myRecognizer = SFSpeechRecognizer() else {
            return
        }
        
        if(!myRecognizer.isAvailable){
            return
        }
        
        _recognitionTask = _speechRecognizer?.recognitionTask(with: _recognitionRequest!, resultHandler: {result, error in
            if let result = result {
                let beststring = result.bestTranscription.formattedString
                stringToAnalyze = beststring.lowercased()
                
            } else if let error = error {
                #if DEBUG
                print("Found an error in the attempt to do a recognition task:")
                print(error)
                #endif
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self._deadline)) {
            self._audioEngine.stop()
            node.removeTap(onBus: 0)
            LanguageAnalyzer.sharedInstance().analyze(stringToAnalyze)
        }
    }
}
