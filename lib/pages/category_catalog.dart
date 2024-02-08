import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
//import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter_platform_interface.dart';
import "package:simple_knn/simple_knn.dart";
// import 'data.dart';

import 'package:image/image.dart' as img;


import '../widgets/loading_widget.dart';

class CategoryCatalog extends StatefulWidget {
  const CategoryCatalog({super.key});

  @override
  State<CategoryCatalog> createState() => _CategoryCatalogState();
}

class _CategoryCatalogState extends State<CategoryCatalog> {

  String imagePath='';
  List<Map> dataList=[];
  
  @override
  Widget build(BuildContext context) {

    if(dataList.isEmpty){
      imagePath = (ModalRoute.of(context)?.settings.arguments as Map)['imagePath'];
      getData(File(imagePath));
      return LoadingWidget();
    }
    else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Select your Product'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index){
              return myCard(dataList[index]);
            },
          ),
        ),
        
      );
    }
  }

  Future<void> getData(File image) async {
    //get data from ML model using image File
   final interpreter = await tfl.Interpreter.fromAsset('assets/resnet50.tflite');
   // final interpreter = await Interpreter.fromAsset('resnet50.tflite');
 //  File imageFile = File('path/to/your/image.jpg');
   List<List<List<List<double>>>> imageArray = await getImageArray(image);

   // Use the image array as needed
   // print(imageArray);
    // For ex: if input tensor shape [1,5] and type is float32
    var input = imageArray;

// if output tensor shape [1,2048] and type is float32
    var output = List.filled(1*2048, 0).reshape([1,2048]);

// inference
    interpreter.run(input, output);

// print the output
    print(output.shape);


    await getActualData(output[0] as List<double>);
    print("loda");

  //  final isolateInterpreter = await tfl.IsolateInterpreter.create(address: interpreter.address);
    // await Future.delayed(Duration(seconds: 2), (){
    // });
    // dataList = [
    //   {'brand' : 'loda'},
    //   {},
    //   {},
    // ];
    
    setState(() {

    });

  }

  Future<List<List<List<List<double>>>>> getImageArray(File imageFile) async {
    // Read the image file
    img.Image? image = img.decodeImage(await imageFile.readAsBytes());

    // Resize the image to 224x224
    image = img.copyResize(image!, width: 224, height: 224);

    // Convert pixel values to floating point and normalize to range [0, 1]
    List<List<List<List<double>>>> imageArray = [];
    List<List<List<double>>> batch = [];
    for (int y = 0; y < image.height; y++) {
      List<List<double>> row = [];
      for (int x = 0; x < image.width; x++) {
        int pixel = image.getPixel(x, y);
        double red = (img.getRed(pixel)).toDouble();
        double green = (img.getGreen(pixel)).toDouble();
        double blue = (img.getBlue(pixel)).toDouble();
        row.add([red, green, blue]);
      }
      batch.add(row);
    }
    imageArray.add(batch);

    return imageArray;
  }

  Widget myCard(Map data) {
    return InkWell(
      onTap: (){
        data['imagePath'] = imagePath;
        Navigator.pushNamed(context, '/add_item_form', arguments: data);
      },
      child: Card(
        child: SizedBox(
          height: 100.0,
          width: double.infinity,
        ),
        color: Colors.grey[900],
      ),

    );
  }

  Future<List<List>> readJson() async {

    final String response = await rootBundle.loadString('assets/jsonfile.json');
    final data = await json.decode(response);
    List<List> lst=[];
    data.forEach((k, v) => lst.add(v));
    return lst;

    // _items = data["items"];
  }

  Future<void> getActualData(List output) async {
    var dataSet = await readJson();

    print('output - ${output}');
    print('dataset shape ${dataSet.shape}');

    List<Pair> skus=[];

    for(int i=0;i<dataSet.length;i++){
      double d=0;
      for(int j=0;j<output.length;j++){
        d+=(dataSet[i][j]-output[j])*(dataSet[i][j]-output[j]);
      }
      skus.add(Pair(d, i));
    }

    skus.sort((a, b) => a.dist.compareTo(b.dist));
    
    for(int i=0;i<5;i++){
      int ind = skus[i].index;
      print(ind);
      // dataList.add();
    }

  }



}

class Pair {
  final double dist;
  final int index;
  Pair(this.dist, this.index);
}
