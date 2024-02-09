import 'package:catalog_digitization_ondc/widgets/catalog_card.dart';
import 'package:flutter/material.dart';

class MyCatalog extends StatefulWidget {
  const MyCatalog({super.key});

  @override
  State<MyCatalog> createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),

      body: ListView(children: [
        CatalogCard(),
        CatalogCard()
      ]),
    );
  }
}
