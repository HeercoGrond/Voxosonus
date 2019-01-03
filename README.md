# ![Voxosonus Logo](./WikiImages/Voxosonus_Full.png)
Swift Text-based Machine Learning for humans.

![Travis CI](https://travis-ci.org/HeercoGrond/Voxosonus.svg?branch=master)

## Requirements
* iOS 12.0+
* Xcode 10+
* Swift 4.2+

It is usable for iOS 11.0+, however the pod and the supplied files have only been tested on the above.

## Author

HeercoGrond, heercogrond@live.nl

## License

Voxosonus is available under the MIT license. See the LICENSE file for more info.

## Installing

### CocoaPods 

[CocoaPods]("https://cocoapods.org/") is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Voxosonus into your Xcode project using CocoaPods, specify it in your `Podfile:`

```ruby
pod 'Voxosonus', '~> 0.2'
``` 

or, if using a self-built version of the Cocoa Pod, add the following instead to use the local pod:

```ruby
pod `Voxosonus', :path => '../path/to/Voxosonus'
```

## Why Voxosonus? 

Machine Learning is becoming more commonplace in development, heavy handed tasks that can be offset through a certain trained model or a convolutional neural network that will calculate based on the data it is set to analyze to produce predictions based on what the user has said. However I noticed a distinct lack in applications using the technology while it could offer an interesting solution, mostly because the complexity of the subject is very high.

Voxosonus is meant to lower the bar of entry and make Machine Learning for Swift understandable and implementable through a basic framework that offers users to transfer speech to text and text to a model, even using their own data. It is meant to be flexible and adaptable to a developer's needs, so it is easy for beginners to understand and for advanced developers to extend. As such, all the code is fully open source and can be adapted at will. 

## Creating your own model

The tools are provided to create your own model in the `./MachineLearningTools` folder. There are two playgrounds there to help you create a dataset that will work with the Voxosonus Framework: 
* CreateVoxosonusModel.playground
* FilterLabeledData.playground

The FilterLabeledData playground is setup to change the json of a IBM Watson workspace to a readable format for the CreateVoxosonusModel playground. Input either file into the resources of the playground and change the variables to load in the specified dataset to either adapt or change. In both cases the results will be saved to your documents. 

If you have created a new model, you can simply replace the existing VoxosonusMLModel file in the project and build a new version of the framework for your intended use or directly link the cocoa pod as described above. It is strongly suggested to do the latter, since behaviour can be unpredictable when 

## Implementation of Framework

The below code is a simple Swift 4.2 implementation on an iOS 12.0 device as shown in the VoxosonusExampleApp added to this project.

```swift
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
        model.subscribeTag(tag: Tag(tagname: "decision_replies"))
    }
    
    // An example of the listening of the framework bound to a button.
    @IBAction func startTest(_ sender: Any) {
        model.startListening()
    }
    
    // This function is inherited from the VoxosonusDelegate protocol and will fire once the framework has been done processing and analyzing the spoken sentence. 
    func labelFound(label: Tag) {
        print(label.value)
    }
}
```

## Troubleshooting

### The dataset I've used seems incompatible.

In the comments of the CreateVoxosonusModel playground is a short description of expected data. Generally if you keep to a structure of a json file with a label and a text field, it will work. An example would be such:

```json
[
    {
        "label": "A label",
        "text": " some text"
    },
    {
        "label": "Another label",
        "text": "some other more relevant text"
    }
]
```

### I've loaded in the pod or framework, however it doesn't seem to work.

Make sure you have done the proper importing, using `import Voxosonus`, then verify the following:

* The framework is properly added as described in the Usage part of this readme.

* You have implemented the `VoxosonusDelegate` and set the `Voxosonus` class' delegate to the file with it.

* You have subscribed a 'Tag' through the model. 

If you have done the following and are still encountering problems, please make an issue in the repository. 
