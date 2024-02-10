// import 'dart:html';

import 'dart:io';

// import 'package:catalog_digitization_ondc/data_class/profile_data_class.dart';
import 'package:be_widgets/be_widgets.dart';
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
        // title: Container(
        //     alignment: Alignment.center,
        //     padding: const EdgeInsets.all(10),
        //     child: const Text(
        //       'ONDC',
        //       style: TextStyle(
        //           color: Colors.blue,
        //           fontWeight: FontWeight.w500,
        //           fontSize: 30),
        //     )),
        title: Image.asset('assets/ondc_icon.png'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      backgroundColor: Colors.grey[850],
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
                      fontWeight: FontWeight.bold
                    ),
                  )),
              // InkWell(
              //   onTap: () async{
              //     await getImage();
              //     await addImageToFirebase();
              //     setState(() {
              //
              //     });
              //   },
              Container(
                margin: EdgeInsets.fromLTRB(0,0,0,30.0),
                child: BeLabel(
                  child : ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(100), // Image radius
                      child: Image.network(imgUrl, fit: BoxFit.contain),
                    ),
                  ),
                  label: ElevatedButton(onPressed: () async {
                    await getImage();
                    await addImageToFirebase();
                    setState(() {

                    });
                  }
                      , child: Icon(Icons.add), ),
                  position: BeLabelPosition.bottomCenter,
                  offset: Offset(0.0,-20.0) ,
                  childSized: false,
                  innerLabel: false,
                ),
              ),
             // ),
              MyTextField('Merchant name', nameController),
              MyTextField('Shop name', shopNameController),
              MyTextField('Merchant ID', merchantIDController),
              MyTextField('Shop address', shopAddressController),

              Container(
                  height: 130,
                  padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 50),
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


  void updateCount(){

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
    if(data['merchantName']== '' ||
    data['shopName']=='' ||
    data['merchantID']=='' ||
    data['shopAddress']==''
    )
      {
        displaySnackBar('Please fill in all the mandatory fields!');
        return;
      }
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid==null){
      print("null uid");
      return;
    }
    showLoaderDialog(context);
    final dbref = FirebaseDatabase.instance.ref('profile');
    try{
      dbref.child(uid).set(data);
      Navigator.pop(context);
      displaySnackBar('Registered successfully!');
      updateCount();
      Navigator.pushReplacementNamed(context, '/home');
    } catch(e){
      Navigator.pop(context);
      displaySnackBar('Failed to register!');
    }
  }


  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [

          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 20),child:Text("Loading...",
            style: TextStyle(fontSize: 16,),
            textAlign: TextAlign.right,

          )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
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


