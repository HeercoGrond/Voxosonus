import UIKit
import Voxosonus

// In order to be given an answer as to what data is given, you will need to have your class inherit the VoxosonusDelegate.
class ViewController: UIViewController, VoxosonusDelegate {
    
    // Initialize the Voxosonus public facing class. This houses all the public available functions for use in your application.
    let model = Voxosonus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate for the Voxosonus class.
        model.delegate = self;
        
        // You can subscribe tags that will be added and 'listened' to when the framework starts listening to speech.
        model.subscribeTag(tag: "decision_replies")
    }
    
    // An example of the listening of the framework bound to a button.
    @IBAction func startTest(_ sender: Any) {
        model.startListening()
    }
    
    // This function is inherited from the VoxosonusDelegate protocol and will fire once the framework has been done processing and analyzing the spoken sentence.
    func labelFound(label: String) {
        print(label)
    }
}
