import 'package:tflite_flutter/tflite_flutter.dart'; // importing of package
import 'package:image/image.dart' as img;
import 'dart:io';

late Interpreter interpreter; // initializing interpreter for inference

Future<void> loadModel() async {
  int optimalThreadCount = (Platform.numberOfProcessors / 2).ceil();
  interpreter = await Interpreter.fromAsset('assets/efficientnet-model.lite',
      options: InterpreterOptions()
        ..threads = optimalThreadCount); // loading tflite model
}

Future<List> performInference(String imagePath) async {
  // main function to call
  img.Image? image = await _loadImage(imagePath);
  final input = _preProcess(image!);

  final output = List<num>.filled(1 * 24, 0).reshape([1, 24]);
  int predictionTimeStart = DateTime.now().millisecondsSinceEpoch;

  interpreter.run([input], output); // running inference on pre-processed image
  // interpreter.close();

  int predictionTime =
      DateTime.now().millisecondsSinceEpoch - predictionTimeStart;
  print('Prediction time: $predictionTime ms');

  return formatRecognitions(output);
  // print(output);
}

// how to figure out the structure of the output after running inference
Future<img.Image?> _loadImage(String imagePath) async {
  final file = File(imagePath);
  final imageData = await file.readAsBytes();
  return img.decodeImage(imageData.buffer.asUint8List());
}

List<List<List<num>>> _preProcess(img.Image image) {
  final imgResized =
      img.copyResize(image, width: 96, height: 96); // resizing of image

  return convertImageToMatrix(imgResized);
}

// inferencing requires input normalized between 0 and 1
List<List<List<num>>> convertImageToMatrix(img.Image image) {
  return List.generate(
    image.height,
    (y) => List.generate(
      image.width,
      (x) {
        final pixel = image.getPixel(x, y);
        // return [pixel.rNormalized, pixel.gNormalized, pixel.bNormalized];
        return [];
      },
    ),
  );
}

List<String> formatRecognitions(List recognitions) {
  double maxClsConf = recognitions[0]
      .reduce((double max, double current) => current > max ? current : max);

  String confidence = (maxClsConf * 100).ceil().toString();

  if (maxClsConf < 0.8) {
    // adjust confidence threshold
    return ["No Detections", confidence];
  }

  int classIndex = recognitions[0].indexOf(maxClsConf);

  List<String> classList = [
    "Cassava Bacterial Blight",
    "Cassava Healthy",
    "Cassava Mosaic Disease",
    "Corn Cercospora Leaf Spot",
    "Corn Common Rust",
    "Corn Healthy",
    "Corn Northern Leaf Blight",
    "Mango Anthracnose",
    "Mango Gall Midge",
    "Mango Healthy",
    "Mango Powdery Mildew",
    "Orange Citrus Greening",
    "Pepper Bacterial Spot",
    "Pepper Healthy",
    "Potato Early Blight",
    "Potato Healthy",
    "Potato Late Blight",
    "Rice BrownSpot",
    "Rice Healthy",
    "Tomato Bacterial Spot",
    "Tomato Early Blight",
    "Tomato Healthy",
    "Tomato Late Blight",
    "Tomato Yellow Leaf Curl Virus"
  ];

  return [
    classList[classIndex],
    confidence
  ]; // return index 0:disease name, 1:confidence
}

// DART PACKAGE
// tflite_flutter: ^0.10.4

// ADD THIS SECTION TO HOMEPAGE OR PAGE WHERE INFERENCE WILL BE DONE
// @override
// void initState() {
//   super.initState();
//   // loadModel();
// }
