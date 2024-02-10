import 'dart:io';

import 'package:catalog_digitization_ondc/ML/image_detection.dart';

//import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/material.dart';

import '../widgets/loading_widget.dart';

class CategoryCatalog extends StatefulWidget {
  const CategoryCatalog({super.key});

  @override
  State<CategoryCatalog> createState() => _CategoryCatalogState();
}

class _CategoryCatalogState extends State<CategoryCatalog> {
  String imagePath = '';
  List<Map> dataList = [];

  @override
  Widget build(BuildContext context) {
    if (dataList.isEmpty) {
      imagePath =
          (ModalRoute.of(context)?.settings.arguments as Map)['imagePath'];
      getData(File(imagePath));
      return LoadingWidget();
    } else {
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
            itemBuilder: (context, index) {
              return myCard(dataList[index]);
            },
          ),
        ),
      );
    }
  }

  Widget myCard(Map data) {
    return InkWell(
      onTap: () {
        data['imagePath'] = imagePath;
        Navigator.pushNamed(context, '/add_item_form', arguments: data);
      },
      child: Card(
          margin: EdgeInsets.all(15),
          clipBehavior: Clip.antiAlias,
          shadowColor: Colors.amber,
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.indigo, Colors.black12],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            padding: EdgeInsets.all(12.0),

                  child: Row(
                    children: [

                      Expanded(
                        flex: 2,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('dataset_images/${data['image']}'),
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5,0,0,0),
                            child: Column(

                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(child: Text(data['name'],

                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  //fontSize: 20,
                                  color: Colors.amberAccent),

                                      //overflow: TextOverflow.ellipsis,
                                   )
                                ),
                                  row("SKU ID    ", data['id'].toString()),
                                  // row("Name      ", data['name']),
                                  // row("Brand      ","Kellogs"),
                                  row("Price       ", data['price'].toString()),
                                  row("Category", data['Category']),
                                  // row("Color       ","Red"),
                                  // row("Weight    ","10 g"),
                                  // row("Count      ","8")
                                ]
                            ),
                          ),
                      ),
                    ],
                  ),


          ),
      ),
    );
  }

  Widget row(String a, String b) {
    return Row(
      children: [
        Text(
          '$a',

        ),
        Padding(padding: EdgeInsets.all(2)),
        Text(':'),
        Padding(padding: EdgeInsets.all(2)),
        Expanded(
          flex: 1,
          child: Text('$b',
            style: TextStyle(fontWeight: FontWeight.bold),
                 overflow: TextOverflow.ellipsis,
               //   maxLines: 2,
                ),
        ),
      ],
    );
  }

  Future<void> getData(File file) async {
    final ob = ImageDetection(file);
    await ob.fetchDataSet();
    await ob.fetchFeatures();
    print(ob.features.length);
    dataList = await ob.predictionList();
    print(dataList);
    setState(() {});
  }

/*Future<void> getData(File image) async {
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


    await getActualData(output[0]);
    print("loda");

  //  final isolateInterpreter = await tfl.IsolateInterpreter.create(address: interpreter.address);
    await Future.delayed(Duration(seconds: 2), (){
    });
    dataList = [
      {'brand' : 'loda'},
      {},
      {},
    ];

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

  }*/
}

/*class Pair {
  final double dist;
  final int index;
  Pair(this.dist, this.index);
}*/
