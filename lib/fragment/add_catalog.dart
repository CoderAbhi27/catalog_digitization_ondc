import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';


class AddCatalog extends StatefulWidget {
  const AddCatalog({super.key});

  @override
  State<AddCatalog> createState() => _AddCatalogState();
}

class _AddCatalogState extends State<AddCatalog> {
  bool isCameraInitialized = false;
  late CameraDescription firstCamera;
  Future<void> getData() async
  {
    // Ensure that plugin services are initialized so that availableCameras()
    // can be called before runApp()
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    setState(() {
      firstCamera = cameras.first;
      isCameraInitialized = true;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return isCameraInitialized
        ? TakePictureScreen(
      // Pass the appropriate camera to the TakePictureScreen widget.
      camera: firstCamera,
    )
        : Scaffold(
      body: Center(
        child: Text(''),
      ),
    );
  }
}
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late File _image;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(child: const Text('Scan your product',
          // style: TextStyle(color: Colors.white),
        )),
        // backgroundColor: Colors.grey[850],
      ),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              icon: Icon(
                  Icons.image,
              ),
              label: Text('Gallery'),
              onPressed: () {
                openGallery();
              },
              heroTag: null,
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton.extended(
              icon: Icon(
                  Icons.camera
              ),
              label: Text('Capture'),
              onPressed: (){
                captureImage();
              },
              heroTag: null,
            )
          ]
      ),
    );
  }

  Future<void> captureImage() async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and get the file image
      // where it was saved.
      final image = await _controller.takePicture();

      if (!mounted) return;

      // If the picture was taken, display it on a new screen.
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(
            // Pass the automatically generated path to
            // the DisplayPictureScreen widget.
            imagePath: image.path,
          ),
        ),
      );
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  Future<void> openGallery() async {
    await getImage();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DisplayPictureScreen(
          // Pass the automatically generated path to
          // the DisplayPictureScreen widget.
          imagePath: _image.path,
        ),
      ),
    );

  }

  Future<void> getImage() async{
    final imagePick = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imagePick==null) return;
    _image = File(imagePick.path);
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify the image')),
      // The image is stored as a file on the device. Use the Image.file
      // constructor with the given path to display the image.
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),

          // margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Image.file(File(imagePath)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 90,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: ElevatedButton(
          // isExtended: true,
          onPressed: (){
            Navigator.pushReplacementNamed(context, '/category_catalog', arguments: {
            'imagePath' : imagePath,
            });
          },
          child: Text(' CONFIRM ',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   // onPressed: ,
      // ),
      /*body: Center(
        child: Column(children:
        [
          Expanded(
              flex:6,
              child: Image.file(File(imagePath))),
          Expanded(
            flex: 1,
            child: Container(
                // height: 50,
                padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 40),
                child: ElevatedButton(
                  child: const Text('CONFIRM', style: TextStyle(fontSize: 20.0)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/category_catalog', arguments: {
                      'imagePath' : imagePath,
                    }
                    );
                  },
                )
            ),
          ),] ),
      ),*/
    );
  }
}