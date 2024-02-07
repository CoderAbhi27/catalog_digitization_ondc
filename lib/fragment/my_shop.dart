import 'package:flutter/material.dart';

class MyShop extends StatefulWidget {
  const MyShop({super.key});

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          padding: EdgeInsets.all(10.0),
          crossAxisCount: 3,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(10, (index) {
            
            return Container(
              margin: EdgeInsets.all(10.0),
              color: Colors.white60,
              child: Center(
                child: Text(
                  'Item $index',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
