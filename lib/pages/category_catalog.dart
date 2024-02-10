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
      return const LoadingWidget();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Select your Product'),
          centerTitle: true,
        ),
        body: Container(
          // padding: EdgeInsets.only(bottom: 30),
          // margin: EdgeInsets.all(10.0),
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return myCard(dataList[index]);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(onPressed: (){
          Map data={
            'name' : '',
            'imagePath' : imagePath,
            'Brand Name' : '',
            'price' : '',
            'Color' : '',
            'weight' : '',
            'description' : '',
            'id' : '',
            'Category' : '',
          };
          Navigator.pushNamed(context, '/add_item_form', arguments: data);
        }, label: const Center(child: Text('Enter manually'),),
        icon: Icon(Icons.add),),
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
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  AssetImage('dataset_images/${data['image']}'),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                              data['name'],

                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 20,
                                  color: Colors.amberAccent),

                              //overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(height: 5,),
                        row("SKU ID    ", data['id'].toString()),
                        // row("Name      ", data['name']),
                        // row("Brand      ","Kellogs"),
                        row("Price       ", data['price'].toString()),
                        row("Category", data['Category']),
                        // row("Color       ","Red"),
                        // row("Weight    ","10 g"),
                        // row("Count      ","8")
                      ]),
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
          child: Text(
            '$b',
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
    for(var data in dataList) data['name'] = data['description'];
    print(dataList);
    setState(() {});
  }

}
