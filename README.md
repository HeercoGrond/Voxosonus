# Voxosonus

## Requirements

This framework will only run on iOS 11.x devices because of the usage of the CoreML model. Beware before you use this framework.

Also for the usage of the Playgrounds in the VoxosonusMLSuite folder you will need MacOS Mojave (10.14) because of the usage of the CreateML library.

## Author

HeercoGrond, heercogrond@live.nl

## License

Voxosonus is available under the MIT license. See the LICENSE file for more info.

## Usage

To implement the Voxosonus Framework some steps need to be undertaken:

The base of the framework is built for iOS 11.x devices. This means that in order to effectively run the framework and it's code, you should beware that your app is only available on iOS 11.x or higher.

In order to utilize the framework as is with the dataset provided within the framework (as detailed in the `dataset.json,` which is a filtered version of the `WatsonConversationCarWorkspace.json` ) you will need to copy the built version of the framework into your folder and add it to your project alongside defining it as one of the embedded libraries as shown below. 

If you are only interested in the provided version of the framework, see the `Framework` folder. This will for now only be the built version for x64 iPhones.

```
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
```