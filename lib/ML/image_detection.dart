import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:image/image.dart' as img;

class ImageDetection {
  File image;
  List<List> dataSet = [];
  List<String> nameList = [];
  Map<String, Map> features = {};

  ImageDetection(this.image);


  Future<void> fetchDataSet() async {
    final String response = await rootBundle.loadString('assets/jsonfile.json');
    final data = await json.decode(response);
    dataSet = [];
    nameList = [];
    data.forEach((k, v) {
      dataSet.add(v);
      nameList.add(k);
    });

  }

  Future<void> fetchFeatures() async {
    final String response = await rootBundle.loadString('assets/features.json');
    final data = await json.decode(response);
    features = {};
    data.forEach((item) {
      print('features item - $item');
      features[item['image']] = item;
    });
  }

  Future<List<Map>> predictionList() async {
    final interpreter = await tfl.Interpreter.fromAsset(
        'assets/resnet50.tflite');
    // final interpreter = await Interpreter.fromAsset('resnet50.tflite');
    //  File imageFile = File('path/to/your/image.jpg');
    List<List<List<List<double>>>> imageArray = await getImageArray(image);

    // Use the image array as needed
    // print(imageArray);
    // For ex: if input tensor shape [1,5] and type is float32
    var input = imageArray;

// if output tensor shape [1,2048] and type is float32
    var output = List.filled(1 * 2048, 0).reshape([1, 2048]);

// inference
    interpreter.run(input, output);

    final lst = await getActualData(output[0]);
    // print(lst);
    return lst;
    print("loda");

    //  final isolateInterpreter = await tfl.IsolateInterpreter.create(address: interpreter.address);

    // setState(() {
    //
    // });

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

  Future<List<Map>> getActualData(List output) async {
    // print('output - ${output}');
    // print('dataset shape ${dataSet.shape}');
    List<Pair> skus = [];

    for (int i = 0; i < dataSet.length; i++) {
      double d = 0;
      for (int j = 0; j < output.length; j++) {
        d += (dataSet[i][j] - output[j]) * (dataSet[i][j] - output[j]);
      }
      skus.add(Pair(d, i));
    }

    skus.sort((a, b) => a.dist.compareTo(b.dist));

    List<Map> dataList=[];
    for (int i = 0; i < 5; i++) {
      int ind = skus[i].index;
      var mp = features[nameList[ind]];
      if(mp!=null) dataList.add(mp);
      else{
        // print(ind);
      }
      // print(ind);
      // dataList.add();
    }

    return dataList;
  }



}

class Pair {
  final double dist;
  final int index;
  Pair(this.dist, this.index);
}