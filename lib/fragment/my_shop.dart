import 'package:catalog_digitization_ondc/widgets/category_card.dart';
import 'package:flutter/material.dart';

class MyShop extends StatefulWidget {
  const MyShop({super.key});

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  List<String> categories = [
    "Other",
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
    "Dental Care",
    "Handwash",
    "Baby Care",
    "Health",
    "Home Fragrance",
    "Meat",
    // "N/A",
    // "Personal_Care",
    "Pooja",
  ];
  Map<String, String> categoryImages = {
    "Beverages": "Property 1=beverage.png",
    "Snacks": "Property 1=snacks.png",
    "Desserts": "Property 1=desserts.png",
    "Groceries": "Property 1=grocery.png",
    "Dairy": "Property 1=diary.png",
    "Household": "households.png",
    "Fragrance": "fragnence.png",
    "Confectionery": "Property 1=Confectionery.png",
    "Stationery": "Property 1=stationary.png",
    "Personal Care": "personal.png",
    "Dental Care": "toothpaste.png",
    "Handwash": "Property 1=handwash.png",
    "Baby Care": "baby.png",
    "Health": "health.png",
    "Home Fragrance": "Property 1=Home Fragrance.png",
    "Meat": "Property 1=meat.png",
    "Other": "other.png",
    // "Personal_Care": "background.png",
    "Pooja": "Property 1=pooja.png",
    // "(Blank)": "background.png",
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        body: Container(
          // padding: EdgeInsets.all(10.0),
          // margin: EdgeInsets.all(10.0),
          child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            padding: EdgeInsets.all(10.0),
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            children: categories.map((item){
              return CategoryCard(category: item, icon:categoryImages['$item'], onClick: (){
                Navigator.pushNamed(context, '/my_catalog', arguments: {
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
      ),
    );
  }
}
