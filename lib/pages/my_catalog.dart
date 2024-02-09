import 'package:catalog_digitization_ondc/widgets/catalog_card.dart';
import 'package:catalog_digitization_ondc/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyCatalog extends StatefulWidget {
  const MyCatalog({super.key});

  @override
  State<MyCatalog> createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  String category = '';
  bool isFetched = false;
  List<Map> dataList=[];
  void getData() async
  {
    var userId = FirebaseAuth.instance.currentUser?.uid.toString();
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('inventory/$userId/$category').get();
    if (snapshot.exists) {
      // print(snapshot.value.toString());
      final dataMap = snapshot.value as Map;
      dataList=[];
      dataMap.forEach((key, value) {
        dataList.add(value);
      });
      setState(() {
        isFetched = true;
      });
    } else {
      setState(() {
        isFetched = true;
      });
      print('No data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    category = (ModalRoute.of(context)?.settings.arguments as Map)['data'];
    if(!isFetched){
      getData();
      return const LoadingWidget();
    }
    else {
      return Scaffold(
          backgroundColor: Colors.grey[850],
          appBar: AppBar(
            title: Text(
              '$category',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.grey[850],
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index){
              return CatalogCard(dataList[index]);
            },
          )
      );
    }
  }
}
