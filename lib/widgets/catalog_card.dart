import 'package:flutter/material.dart';

class CatalogCard extends StatefulWidget {
  Map data = {};

  CatalogCard(this.data);

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
                  backgroundImage: NetworkImage(widget.data['imgUrl']),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        row("SKU ID    ", widget.data['skuId'].toString()),
                        row("Name      ", widget.data['productName'].toString()),
                        row("Brand      ", widget.data['price'].toString()),
                        row("Price       ", widget.data['brand'].toString()),
                        row("Category", widget.data['category'].toString()),
                        row("Color       ", widget.data['color'].toString()),
                        row("Weight    ", widget.data['weight'].toString()),
                        row("Count      ", widget.data['inventory_count'].toString()),
                      ]))
            ],
          ),
        ));
  }

  Widget row(String a, String b) {
    return Row(
      children: [
        Text(
          '$a',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.all(5)),
        Text(':'),
        Padding(padding: EdgeInsets.all(5)),
        Text('$b'),
      ],
    );
  }
}
