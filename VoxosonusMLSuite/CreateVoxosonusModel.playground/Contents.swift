import Foundation
import CreateML


// Input the name of the file you have imported into the resources of the playground.
let datasetName = ""

// The model's author name for the metadata.
let author = "Voxosonus"
// The short description for the model's metadata.
let description = "A MLModel Generated using the tools of the Voxosonus Framework"
// The version of the input model. This is for your own data record. Default is 1.0;
let version = "1.0"




// Get the current path to the document directory.
let dirs = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                               .userDomainMask, true)
// And createa folder to save the model to.
let currentDir = dirs[0] + "/VoxosonusModels/"
let path = URL(fileURLWithPath: currentDir)

let data = try MLDataTable(contentsOf: Bundle.main.url(forResource: "dataset", withExtension: "json")!)
let (trainingData, testingData) = data.randomSplit(by: 0.7, seed: 5)
let classifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "label")

let trainingAccuracy = (1.0 - classifier.trainingMetrics.classificationError) * 100;
let validationAccuracy = (1.0 - classifier.validationMetrics.classificationError) * 100;

let evaluationMetrics = classifier.evaluation(on: testingData)
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: author, shortDescription: description, version: "1.0")

try classifier.write(to: path)

