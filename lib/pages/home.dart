import 'package:catalog_digitization_ondc/fragment/add_catalog.dart';
import 'package:catalog_digitization_ondc/fragment/my_shop.dart';
import 'package:catalog_digitization_ondc/fragment/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var myIndex =0;
  List<Widget> widgetList = [
    MyShop(),
    AddCatalog() ,
    Profile() ,

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Center(
          child : Text('ONDC',
          style: TextStyle(
            color: Colors.white60
          ),),
        ),
        actions: [
          // Container(
          //   margin: EdgeInsets.all(10.0),
          //   child: Text('ouhd'),
          // ),
          // Text('UYADS'),
          Container(
               margin: EdgeInsets.all(10.0),
            child: GestureDetector(
              // style: ButtonStyle(
              //   backgroundColor: MaterialStateProperty.all(Colors.grey[850]),
              // ),
              // onPressed: (){},
              onTap: (){},
              child: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
        backgroundColor: Colors.grey[850],

      ),*/
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            myIndex=index;
          });
        },
        currentIndex: myIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'My Shop',
            backgroundColor: Colors.grey[700],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Catalog',
            backgroundColor: Colors.grey[700],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.grey[700],
          ),
        ],
        showUnselectedLabels: false,
        backgroundColor: Colors.grey[850],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
      ),
      body: IndexedStack(
        children: widgetList,
        index: myIndex,
      ),
      backgroundColor: Colors.grey[800],
    );
  }
}
