import 'package:catalog_digitization_ondc/widgets/catalog_card.dart';
import 'package:flutter/material.dart';

class MyCatalog extends StatefulWidget {
  const MyCatalog({super.key});

  @override
  State<MyCatalog> createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  String category='';
  @override
  Widget build(BuildContext context) {
    category = (ModalRoute.of(context)?.settings.arguments as Map)['data'];
    return Scaffold(
      appBar: AppBar(
    title: Text('$category'),
        centerTitle: true,
      ),

      body: ListView(children: [
        CatalogCard(),
        CatalogCard()
      ]),
    );
  }
}
