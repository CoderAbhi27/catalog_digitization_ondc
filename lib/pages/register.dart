// import 'dart:html';

import 'dart:io';

// import 'package:catalog_digitization_ondc/data_class/profile_data_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/my_text_field.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  var nameController = TextEditingController();
  var shopNameController = TextEditingController();
  var merchantIDController = TextEditingController();
  var shopAddressController = TextEditingController();

  final storageReference = FirebaseStorage.instance.ref();
  late File _image;

  String imgUrl='https://th.bing.com/th/id/OIP.nZ0mlqfGSlnx4w5Nr6Aw_QHaHa?rs=1&pid=ImgDetMain';

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    // double ffem = fem * 0.97;

    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'ONDC',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            )),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      backgroundColor: Colors.grey[800],
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[

              Container(
                  margin: EdgeInsets.only(top: fem*30, bottom: fem*20),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Register your shop',
                    style: TextStyle(
                      fontSize: 32*fem,
                      color: Colors.white,
                    ),
                  )),
              InkWell(
                onTap: () async{
                  await getImage();
                  await addImageToFirebase();
                  setState(() {

                  });
                },
                child: CircleAvatar(
                  radius: fem*80,
                  backgroundImage: NetworkImage(imgUrl),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.fill,
                  ),

                ),
              ),
              MyTextField('Merchant name', nameController),
              MyTextField('Shop name', shopNameController),
              MyTextField('Merchant ID', merchantIDController),
              MyTextField('Shop address', shopAddressController),

              Container(
                  height: 80,
                  padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('REGISTER', style: TextStyle(fontSize: 20.0)),
                    onPressed: () {
                      Map data = {
                        'merchantName' : nameController.text,
                        'shopName' : shopNameController.text,
                        'merchantID' : merchantIDController.text,
                        'shopAddress' : shopAddressController.text,
                        'imgUrl' : imgUrl
                      };
                      // final data = ProfileDataClass(merchantName: nameController.text, shopName: shopNameController.text, merchantID: merchantIDController.text, shopAddress: shopAddressController.text, profilePicUrl: imgUrl);
                      uploadProfile(data);
                      // String pass = passwordController.text;
                      // signIn(name, pass);
                    },
                  )
              ),
            ],
          )
      ),
    );
  }


  Future<void> getImage() async{
    final imagePick = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imagePick==null) return;
    _image = File(imagePick.path);
  }

  Future<void> addImageToFirebase() async{

    String fileName = DateTime.now().microsecondsSinceEpoch.toString();

    //CreateRefernce to path.
    final ref = storageReference.child("profile/$fileName");

    try{
      print(ref);
      final storageTaskSnapshot = await ref.putFile(_image);
      imgUrl = await ref.getDownloadURL();
      print(ref);
    } catch (e){
      displaySnackBar('Failed to upload image!');
    }

  }



  void uploadProfile(Map data) {
    // print(data.shopName);
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid==null){
      print("null uid");
      return;
    }
    final dbref = FirebaseDatabase.instance.ref('profile');
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
}


