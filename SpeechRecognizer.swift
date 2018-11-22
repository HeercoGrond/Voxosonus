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
                print("user didn't give permissions");
            case .restricted:
                voiceAuthorized = false;
                print("not allowed to use speech");
                
            case .notDetermined:
                voiceAuthorized = false;
                print("not yet said if it's allowed or not");
            }
            
            OperationQueue.main.addOperation {
                self._voiceReady = voiceAuthorized
            }
        }
    }
    
    /** Verify whether or not the voice authorization is true and signifies that the Speech framework is ready.*/
    func isVoiceReady() -> Bool {
        return self._voiceReady
    }
    
    /** Change the deadline time for stopping the listening operation.*/
    func setListenTime(time: Int) {
        self._deadline = time
    }
    
    /** Records the speech and sends it over to the LanguageAnalyzer to be recognized and analyzed.*/
    func recordAndRecognizeSpeech() {
        print("Starting recording");
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
            print("Something went wrong with the starting of the audio engine:")
            return print(error)
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
                stringToAnalyze = beststring
                
            } else if let error = error {
                print("Found an error in the attempt to do a recognition task:")
                print(error)
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self._deadline)) {
            self._audioEngine.stop()
            node.removeTap(onBus: 0)
            LanguageAnalyzer.sharedInstance().analyze(stringToAnalyze)
        }
    }
}
