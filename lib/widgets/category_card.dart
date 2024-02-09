import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  //const CategoryCard({super.key});
  String category='';
  String? icon;
  void Function() onClick;
  CategoryCard({required this.category,this.icon='background.png', required  this.onClick});
  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        height: 120.0,
        child: Card(
          elevation: 10.0,
          shadowColor: Colors.grey[800],
          child: ListTile(

            // leading: Container(
            //   padding: EdgeInsets.only(bottom: 10.0),
            //   child:  Icon(
            //       Icons.delete,
            //
            //     ),
            //
            // ),
            subtitle: Text('mera loda '),
            title: Center(
              child: Column(
                children: [
              
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      // margin: EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      child: Image.asset('assets/${widget.icon}'),
                    ),
                  ),
                  Expanded(
                    // flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(4.5),
                      // margin: EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      child: Text(widget.category,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),

                        textScaleFactor: 0.9, // Set your desired scale factor
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
          color: Colors.grey,
        ),
      ),
    );
  }
}
