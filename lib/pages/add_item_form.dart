import 'dart:io';

import 'package:catalog_digitization_ondc/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AddItemForm extends StatefulWidget {
  const AddItemForm({super.key});

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {

  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  Map data={};
      // SKU id,
      // Brand,
      // Category,
      // Name,
      // Price,
      // Color,
      // Weight,
      //
      // Count,
      // Description,

  var skuIdController = TextEditingController();
  var brandController = TextEditingController();
  var categoryController = TextEditingController();
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var colorController = TextEditingController();
  var weightController = TextEditingController();
  var countController = TextEditingController();
  var descController = TextEditingController();



  // String imgUrl='https://th.bing.com/th/id/OIP.nZ0mlqfGSlnx4w5Nr6Aw_QHaHa?rs=1&pid=ImgDetMain';

  @override
  Widget build(BuildContext context) {
    data = (ModalRoute.of(context)?.settings.arguments as Map);
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      body:  Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[

              Container(
                  margin: EdgeInsets.only(top: fem*30, bottom: fem*20),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Register your item',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  )),
              Image(
                image: FileImage(File(data['imagePath']), scale: 0.3),

                alignment: Alignment.center,
                fit: BoxFit.scaleDown,
              ),
              myTextField('SKU ID', skuIdController, data['skuId']),
              myTextField('Category', categoryController, data['category']),
              myTextField('Product name', nameController, data['productName']),
              myTextField('Brand', brandController, data['brand']),
              myTextField('Price', priceController, data['price']),
              myTextField('Color', colorController, data['color']),
              myTextField('Weight', weightController, data['weight']),
              myTextField('Inventory count', countController, data['cost']),
              myTextField('Description', descController, data['description']),


              Container(
                  height: 80,
                  padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('REGISTER', style: TextStyle(fontSize: 20.0)),
                    onPressed: () {
                      Map newData = {
                        'skuId' : skuIdController,
                        'productName': nameController.text,
                        'brand': brandController.text,
                        'price': priceController.text,
                        'category': categoryController.text,
                        'color': colorController.text,
                        'weight': weightController.text,
                        'inventory count': countController.text,
                        'description': descController.text,
                        'imgPath' : data['imagePath'],
                      };
                      // final data = ProfileDataClass(merchantName: nameController.text, shopName: shopNameController.text, merchantID: merchantIDController.text, shopAddress: shopAddressController.text, profilePicUrl: imgUrl);
                      uploadItem(newData);
                      // String pass = passwordController.text;
                      // signIn(name, pass);
                    },
                  )
              ),
            ],
          )
      ),
      backgroundColor: Colors.grey[800],
    );
  }




  void uploadItem(Map data) {
    // print(data.shopName);
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid==null){
      print("null uid");
      return;
    }
    final dbref = FirebaseDatabase.instance.ref('inventory');
    try{
      dbref.child(uid).set(data);
      displaySnackBar('Registered successfully!');
      Navigator.pushReplacementNamed(context, '/home');
    } catch(e){
      displaySnackBar('Failed to register!');
    }
  }


  void displaySnackBar(String s) {
    var snackdemo = SnackBar(
      content: Text(s),
      backgroundColor: Colors.green,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  }

  myTextField(String label, TextEditingController controller, String? text) {
    if(text!=null) controller.text = text;
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          // icon: Icon(Icons.person),
          iconColor: Colors.white,
          labelStyle: TextStyle(color: Colors.white),
          suffixIcon: IconButton(icon: Icon(Icons.mic), onPressed: () {
            showDialog(context: context, builder: (context){
              _initSpeech();
              return AlertDialog(
                title: Text('Speak...'),
                content:  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            'Tap the microphone for listening...',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            // If listening is active show the recognized words
                            _speechToText.isListening
                                ? '$_lastWords'
                            // If listening isn't active but could be tell the user
                            // how to start it, otherwise indicate that speech
                            // recognition is not yet ready or not supported on
                            // the target device
                                : _speechEnabled
                                ? '$_lastWords'
                                : 'Speech not available',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  // TextButton(
                  //   onPressed: () => Navigator.pop(context, 'Cancel'),
                  //   child: const Text('Cancel'),
                  // ),
                  IconButton(
                    onPressed:
                    // If not yet listening for speech start, otherwise stop
                    _speechToText.isNotListening ? _startListening : _stopListening,
                    tooltip: 'Listen',
                    icon: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
                  ),

                  TextButton(
                    onPressed: () => Navigator.pop(context,{'title':'$_lastWords'}),
                    child: const Text('OK'),
                  ),
                ],

              );
            });
          },),
          suffixIconColor: Colors.white

        ),
      ),
    );
  }


  void _initSpeech() async {
    //_speechToText.toString();
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {

    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }
}
