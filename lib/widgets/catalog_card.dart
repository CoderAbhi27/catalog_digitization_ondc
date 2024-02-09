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
      margin: EdgeInsets.all(15),
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
       child: Row(
         children: [
           Expanded(flex: 2,
             child: CircleAvatar(
               radius: 50,
               backgroundImage: NetworkImage('https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
             ),
           ),
           Expanded(flex: 4,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   row("SKU ID    ","4743657476"),
                   row("Name      ","Kinder Joy"),
                   row("Brand      ","Kellogs"),
                   row("Price       ","40"),
                   row("Category","Grocery"),
                   row("Color       ","Red"),
                   row("Weight    ","10 g"),
                   row("Count      ","8")]
               ))
         ],
       ),

     )
    );
  }
  Widget row(String a, String b)
  {
    return Row(
      children: [
        Text('$a',style: TextStyle(fontWeight: FontWeight.bold),),
        Padding(padding: EdgeInsets.all(5)),
        Text(':'),
        Padding(padding: EdgeInsets.all(5)),
        Text('$b'),
      ],
    );
  }
}
