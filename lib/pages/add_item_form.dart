import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddItemForm extends StatefulWidget {
  const AddItemForm({super.key});

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
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


/*  Future<void> addImageToFirebase() async{

    String fileName = DateTime.now().microsecondsSinceEpoch.toString();

    //CreateRefernce to path.
    final ref = storageReference.child("profile/$fileName");

    try{
      print(ref);
      //   final storageTaskSnapshot = await ref.putFile(_image);
      imgUrl = await ref.getDownloadURL();
      print(ref);
    } catch (e){
      displaySnackBar('Failed to upload image!');
    }

  }*/



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

        ),
      ),
    );
  }
}
