import 'package:catalog_digitization_ondc/widgets/category_card.dart';
import 'package:flutter/material.dart';

class MyShop extends StatefulWidget {
  const MyShop({super.key});

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  List<String> categories = [
    "Beverages",
    "Snacks",
    "Desserts",
    "Groceries",
    "Dairy",
    "Household",
    "Fragrance",
    "Confectionery",
    "Stationery",
    "Personal Care",
    "Cardamom & Tulsi Toothpaste",
    "Handwash",
    "Baby Care",
    "Health",
    "Home Fragrance",
    "Meat",
    "N/A",
    "Personal_Care",
    "Pooja",
    "(Blank)"
  ];
  Map<String, String> categoryImages = {
    "Beverages": "Property 1=beverage.png",
    "Snacks": "Property 1=snacks.png",
    "Desserts": "Property 1=desserts.png",
    "Groceries": "Property 1=grocery.png",
    "Dairy": "Property 1=dairy.png",
    "Household": "background.png",
    "Fragrance": "Property 1=baby care.png",
    "Confectionery": "Property 1=Confectionery.png",
    "Stationery": "Property 1=stationary.png",
    "Personal Care": "background.png",
    "Cardamom & Tulsi Toothpaste": "background.png",
    "Handwash": "Property 1=handwash.png",
    "Baby Care": "Property 1=baby care.png",
    "Health": "Property 1=baby care.png",
    "Home Fragrance": "Property 1=Home Fragrance.png",
    "Meat": "Property 1=meat.png",
    "N/A": "background.png",
    "Personal_Care": "background.png",
    "Pooja": "Property 1=pooja.png",
    "(Blank)": "background.png",
  };

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
          children: categories.map((item){
            return CategoryCard(category: item, icon:categoryImages['$item'], onClick: (){
              Navigator.pushNamed(context, '/categortyCataloge', arguments: {
                'data' :item,
              });
            });
          }).toList(),

    // return CategoryCard(category: 'abhi', icon: 'background.png', onClick: (){});
    // }
            // return Container(
            //   margin: EdgeInsets.all(10.0),
            //   color: Colors.white60,
            //   child: Center(
            //     child: Text(
            //       'Item $index',
            //       style: Theme.of(context).textTheme.headlineSmall,
            //     ),
            //   ),
            // );
          // ),
        ),
      ),
    );
  }
}
