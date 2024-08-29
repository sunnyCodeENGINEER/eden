import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import './yolo.dart';
// import 'package:plant_dc/server_inference.dart';
import '../models/leaf_dd.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    _contWidth = 0.95 * screenWidth;
    _contHeight = 0.65 * screenHeight;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plant Doctor',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4D8C57),
      ),
      backgroundColor: Colors.green.shade50,
      body: isLoading ? buildLoadingScreen() : buildHomepage(),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF4D8C57),
        height: 0.12 * screenHeight,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.camera_alt_outlined),
              color: Colors.white,
              iconSize: 40,
              tooltip: "Select image from camera",
              onPressed: _getImageFromCamera,
            ),
            const SizedBox(width: 50),
            IconButton(
              icon: const Icon(Icons.photo_library_outlined),
              color: Colors.white,
              iconSize: 40,
              tooltip: "Select image from gallery",
              onPressed: _getImageFromGallery,
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onLongPress: _showFlushBar,
        child: FloatingActionButton.large(
            shape: const CircleBorder(),
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            onPressed: () => setState(() {
                  if (_imageFile != null) {
                    isLoading = true;
                    _detectObjects();
                  }
                }),
            child: const Icon(
              Icons.search,
              color: Color(0xFF4D8C57),
              size: 40,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildLoadingImage() {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.greenAccent,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text("Loading image, please wait..."),
          ),
        ],
      ),
    );
  }

  Widget buildLoadingScreen() {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(
              radius: 50.0, color: CupertinoColors.activeGreen),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text("Detecting, please wait..."),
          ),
        ],
      ),
    );
  }

  // Widget buildHomepage() {
  //   return Center(
  //     child: Column(
  //       children: [
  //         Container(
  //           margin: const EdgeInsets.only(top: 8.0),
  //           height: _contHeight,
  //           width: _contWidth,
  //           alignment: Alignment.center,
  //           child: _imageFile == null
  //               ? ClipRRect(
  //                   child: Image.asset(
  //                     './assets/no_photo3.png',
  //                     fit: BoxFit.cover,
  //                   ),
  //                 )
  //               : loadingImage 
  //                   ? buildLoadingImage()
  //                   : SizedBox(
  //                       child: Stack(
  //                         children: [
  //                           ClipRRect(
  //                             borderRadius: BorderRadius.circular(10.0),
  //                             child: Image.file(
  //                               _imageFile!,
  //                               fit: BoxFit.cover,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

Widget buildHomepage() {
  return Center(
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          height: _contHeight,
          width: _contWidth,
          alignment: Alignment.center,
          child: _imageFile == null
              ? ClipRRect(
                  child: Image.asset(
                    'assets/no_photo3.png', // Make sure the path is correct
                    fit: BoxFit.cover,
                  ),
                )
              : loadingImage
                  ? buildLoadingImage()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
        ),
      ],
    ),
  );
}


  File? _imageFile;
  late double _contWidth;
  late double _contHeight;
  bool isLoading = false;
  bool loadingImage = false;
  bool sFlush = false;
  late List results;
  String _imagePath = "";

  Future<void> _detectObjects() async {
    setState(() {
      isLoading = true;
      sFlush = true;
    });

    // detection = await testYolov5(_imagePath);
    // detection = await getInference(_imagePath);
    results = await performInference(_imagePath);

    setState(() {
      isLoading = false;
      _showFlushBar();
    });
  }

  Future<void> _getImageFromCamera() async {
  setState(() {
    sFlush = false;
    loadingImage = true;
  });

  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    setState(() {
      _imageFile = File(pickedFile.path);
      _imagePath = pickedFile.path;
      loadingImage = false;
    });
  } else {
    setState(() {
      loadingImage = false;
    });
  }
}

Future<void> _getImageFromGallery() async {
  setState(() {
    sFlush = false;
    loadingImage = true;
  });

  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _imageFile = File(pickedFile.path);
      _imagePath = pickedFile.path;
      loadingImage = false;
    });
  } else {
    setState(() {
      loadingImage = false; // Ensure the loading state is reset
    });
  }
}


  Future<void> _showFlushBar() async {
    if (sFlush) {
      Flushbar(
        message: results.isEmpty ? "None" : results[0] + "-" + results[1],
        messageSize: 16,
        duration: const Duration(seconds: 5),
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(25),
        borderRadius: BorderRadius.circular(8),
        reverseAnimationCurve: Curves.decelerate,
        forwardAnimationCurve: Curves.elasticOut,
        backgroundColor: const Color(0xFF4D8C57),
        boxShadows: const [
          BoxShadow(
              color: Colors.white, offset: Offset(0.0, 2.0), blurRadius: 3.0)
        ],
        backgroundGradient:
            const LinearGradient(colors: [Colors.green, Colors.greenAccent]),
        isDismissible: true,
        icon: const Icon(
          Icons.info_outline,
          color: Colors.white,
          size: 40,
        ),
      ).show(context);
    }
  }
}
