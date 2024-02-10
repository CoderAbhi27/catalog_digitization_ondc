import 'package:catalog_digitization_ondc/widgets/category_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

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
    "Dental Care",
    "Handwash",
    "Baby Care",
    "Health",
    "Home Fragrance",
    "Meat",
    // "N/A",
    // "Personal_Care",
    "Pooja",
    "Other",
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
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  var cnt = 0;
  var time = 'YYYY-MM-DD';

  Future<void> getData() async {
    final snapshot = await ref.child('digitization/count').get();
    if (snapshot.exists) {
      cnt = int.parse(snapshot.value.toString());
      print(cnt.toString());
    } else {
      print('No data available.');
    }
    final snap = await ref.child('digitization/time').get();
    if (snap.exists) {
      time = snap.value.toString();
      print('hi $time');
    } else {
      print('No data available.');
      time = '2024-01-08';
    }
    if(time.substring(0,10)!=DateTime.now().toString().substring(0,10)){
      cnt=0;
      time = DateTime.now().toString();
    }
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            MyCard(count: cnt, date: time),
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
            Center(
              child: Text(
                "My Catalog", // Display the count
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                // padding: EdgeInsets.all(10.0),
                // margin: EdgeInsets.all(10.0),
                child: GridView.count(
                  shrinkWrap: true,
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  padding: EdgeInsets.all(10.0),
                  crossAxisCount: 2,
                  // Generate 100 widgets that display their index in the List.
                  children: categories.map((item) {
                    return CategoryCard(
                        category: item,
                        icon: categoryImages['$item'],
                        onClick: () {
                          Navigator.pushNamed(context, '/my_catalog',
                              arguments: {
                                'data': item,
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
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final int count; // Count variable
  final String date; // Date variable

  MyCard({required this.count, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4, // Card elevation
      margin: EdgeInsets.all(16), // Card margin
      child: Padding(
        padding: EdgeInsets.all(16), // Padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8), // Spacer
            // Center(
            //   child:
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_month_sharp),
                SizedBox(
                  height: 4,
                ),
                Text(
                  date.substring(0,10), // Format the date
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            // ),
            SizedBox(height: 16), // Spacer
            Center(
              child: Text(
                "$count Catalogs Digitized Today", // Display the count
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
            ),
            Center(
              child: Text(
                "all over INDIA", // Display the count
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
