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
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  // final stt.SpeechToText _speechToText = stt.SpeechToText();

  Map data = {};

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

  List<String> list = <String>[

    "Beverages",
    "Snacks",
    "Desserts",
    "Groceries",
    "Dairy",
    "Household",
    "Fragrance",
    "Confectionery",
    "Stationery",
    "Personal Care",
    "Dental Care",
    "Handwash",
    "Baby Care",
    "Health",
    "Home Fragrance",
    "Meat",
    // "N/A",
    // "Personal_Care",
    "Pooja",
    "Other",
  ];

  final storageReference = FirebaseStorage.instance.ref();
  String imgUrl = '';

  String category = '(blank)';

  @override
  Widget build(BuildContext context) {
    data = (ModalRoute.of(context)?.settings.arguments as Map);
    addImageToFirebase();
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 5,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: fem * 0, bottom: fem * 20),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Register your item',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  )),
              Container(
                // width: 10*fem,
                height: 300 * fem,
                padding: EdgeInsets.fromLTRB(40, 0, 40, 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image(
                    image: FileImage(File(data['imagePath'])),
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              myTextField('SKU ID', skuIdController, 'id'),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: DropdownMenu<String>(
                  controller: categoryController,
                  menuHeight: 400 * fem,
                  width: 346 * fem,
                  label: Text(
                    'Category',
                    style: TextStyle(color: Colors.grey[350]),
                  ),
                  // width: ,
                  // initialSelection: 'loda',
                  initialSelection: data['Category'],
                  trailingIcon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  ),
                  textStyle: TextStyle(color: Colors.white),
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      category = value!;
                    });
                  },
                  dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
              ),
              // myTextField('Category', categoryController, data['category']),
              // myTextField('SKU ID', skuIdController, data['id'].toString()),
              // myTextField('Category', categoryController, data['Category']),
              myTextField('Product name', nameController, 'name'),
              myTextField('Brand', brandController, 'Brand Name'),
              myTextField('Price (₹)', priceController, 'price', onlyNum: true),
              myTextField('Color', colorController, 'Color'),
              myTextField('Weight (gm)', weightController, 'weight',
                  onlyNum: true),
              myTextField('Inventory count', countController, null,
                  onlyNum: true),
              myTextField('Description', descController, 'description'),

              Container(
                  height: 110,
                  padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 30),
                  child: ElevatedButton(
                    child: const Text('REGISTER',
                        style: TextStyle(fontSize: 20.0)),
                    onPressed: () {
                      Map newData = {
                        'skuId': skuIdController.text,
                        'productName': nameController.text,
                        'brand': brandController.text,
                        'price': priceController.text,
                        'category': categoryController.text,
                        'color': colorController.text,
                        'weight': weightController.text,
                        'inventory_count': countController.text,
                        'description': descController.text,
                        'imgUrl': imgUrl,
                      };
                      print('data - $newData');
                      // final data = ProfileDataClass(merchantName: nameController.text, shopName: shopNameController.text, merchantID: merchantIDController.text, shopAddress: shopAddressController.text, profilePicUrl: imgUrl);
                      uploadItem(newData);
                      // String pass = passwordController.text;
                      // signIn(name, pass);
                    },
                  )),
            ],
          )),
      backgroundColor: Colors.grey[850],
    );
  }

  Future<void> addImageToFirebase() async {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();

    //CreateRefernce to path.
    final ref = storageReference.child("catalog/$fileName");

    try {
      final storageTaskSnapshot = await ref.putFile(File(data['imagePath']));
      imgUrl = await ref.getDownloadURL();
    } catch (e) {
      print('Failed to upload image!');
    }
  }

  Future<void> uploadItem(Map data) async {
    if (data['category'] == '' ||
            data['skuId'] == '' ||
            data['productName'] == '' ||
            data['brand'] == '' ||
            data['price'] == '' ||
            data['category'] == '' ||
            data['color'] == '' ||
            data['weight'] == '' ||
            data['inventory_count'] == '' ||
            data['description'] == ''
        // data['imgUrl'] == '')
        ) {
      displaySnackBar('Please fill in all the mandatory fields!');
      return;
    }
    // print(data.shopName);
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      print("null uid");
      return;
    }
    showLoaderDialog(context);
    final dbref = FirebaseDatabase.instance
        .ref('inventory')
        .child(uid)
        .child(data['category']);
    try {
      dbref.push().set(data);
      // print(dbref.toString());
      await updateCount();
      Navigator.pop(context);
      displaySnackBar('Registered successfully!');
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      Navigator.pop(context);
      displaySnackBar('Failed to register!');
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.right,
              )),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> updateCount() async {
    var cnt = 0;
    var time = '';
    print('no error');
    final snapshot = await ref.child("digitization").get();
    if (snapshot.exists) {
      final data = snapshot.value as Map;
      cnt = data['count'];
      time = data['time'];
    } else {
      cnt = 0;
      time = '2024-01-08';
      print('No data available.');
    }
    print(cnt);

    DateTime previousDate = DateTime.parse(time);

    DateTime currentDate = DateTime.now();

    bool dateChanged = currentDate.day != previousDate.day ||
        currentDate.month != previousDate.month ||
        currentDate.year != previousDate.year;

    if (dateChanged) {
      await ref.child('digitization').update({
        "count": 1,
        "time": currentDate.toString(),
      });
    } else {
      await ref.child('digitization').update({
        "count": cnt + 1,
        "time": currentDate.toString(),
      });
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

  myTextField(String label, TextEditingController controller, String? text,
      {bool onlyNum = false}) {
    if (text != null && data[text] != null) {
      controller.text = data[text].toString();
      data[text] = null;
    }
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        keyboardType: onlyNum ? TextInputType.number : TextInputType.text,
        style: TextStyle(
          color: Colors.white,
        ),
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
            // icon: Icon(Icons.person),
            iconColor: Colors.white,
            labelStyle: TextStyle(color: Colors.grey[350]),
            suffixIcon: IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
                Navigator.pushNamed(context, '/speech').then((value) {
                  controller.text = (value as Map)['text'];
                });
              },
            ),
            suffixIconColor: Colors.white),
      ),
    );
  }
}
