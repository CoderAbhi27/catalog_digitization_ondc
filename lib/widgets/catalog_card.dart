import 'package:flutter/material.dart';
class CatalogCard extends StatefulWidget {
  const CatalogCard({super.key});

  @override
  State<CatalogCard> createState() => _CatalogCardState();
}

class _CatalogCardState extends State<CatalogCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.amber,
      elevation: 10,

     shape: RoundedRectangleBorder
       (
       borderRadius: BorderRadius.circular(15)
     ),
     child: Container(
       decoration: BoxDecoration(
         gradient: LinearGradient(
           colors: [Colors.indigo,Colors.black12],
               begin: Alignment.topLeft,
           end: Alignment.bottomRight,
         )
       ),
       padding: EdgeInsets.all(12.0),
       child: SizedBox(height: 100,),

     )
    );
  }
}
