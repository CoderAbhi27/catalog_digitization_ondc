import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';

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
}
