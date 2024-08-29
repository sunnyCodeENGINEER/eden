import 'dart:developer' as devtools;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key});

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  File? filePath;

  double confidence = 0.0;
  String label = '';
  Future<void> _tfliteInit() async {
    String? _ = await Tflite.loadModel(
        model: "assets/efficientnet-model.tflite",
        labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
  }

  pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    if (recognitions == null) {
      devtools.log('Recognitions is null.');
      return;
    }

    devtools.log(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
    });
  }

  pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    if (recognitions == null) {
      devtools.log('Recognitions is null.');
      return;
    }

    devtools.log(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
    });
  }

  @override
  void initState() {
    super.initState();

    _tfliteInit();
  }

  @override
  void dispose() {
    super.dispose();

    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 30,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Image.asset('assets/logo.png'),
                    ),
                    const Text(
                      "Eden Detect",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 88, 48)),
                    ),
                    const Spacer()
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                elevation: 20,
                color: const Color.fromARGB(255, 85, 117, 87),
                clipBehavior: Clip.hardEdge,
                shadowColor: const Color.fromARGB(255, 45, 88, 48),
                child: SizedBox(
                  width: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          height: 280,
                          width: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 45, 88, 48),
                            image: const DecorationImage(
                              image: AssetImage('assets/image.png'),
                            ),
                          ),
                          child: filePath == null
                              ? const Text('')
                              : Image.file(
                                  filePath!,
                                  fit: BoxFit.fill,
                                ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                label,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                label == ''
                                    ? ''
                                    : 'Accuracy is ${confidence.toStringAsFixed(2)}%',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 176, 237, 157),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  pickImageFromCamera();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white),
                child: const Text('Take a Photo'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  pickImageFromGallery();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white),
                child: const Text('Pick from Gallery'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
