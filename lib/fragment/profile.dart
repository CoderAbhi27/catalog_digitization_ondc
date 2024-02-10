import 'package:catalog_digitization_ondc/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isFetched = false;
  Map data={};
  void getData() async
  {
    var userId = FirebaseAuth.instance.currentUser?.uid.toString();
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('profile/$userId').get();
    if (snapshot.exists) {
     // print(snapshot.value.toString());
      data = snapshot.value as Map;
      print(data['imgUrl']);
      setState(() {
        isFetched = true;
      });
    } else {
      print('No data available.');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    String? s= FirebaseAuth.instance.currentUser?.email.toString();
   // s= s?.substring(0,s.indexOf('@'));
    // return Scaffold(
    //   body: Center(
    //     child: ElevatedButton.icon(onPressed: (){
    //       logout();
    //
    //     },
    //       icon: Icon(Icons.logout),
    //       label: Text('Logout'),
    //     ),
    //   ),
    // );
    return !isFetched ? LoadingWidget() :
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Center(
          child: const Text('Profile',
          style: TextStyle(
            color: Colors.white,
            // fontSize: 30,
          ),),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey, Colors.grey.shade700],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.5, 0.9],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // CircleAvatar(
                    //   backgroundColor: Colors.red.shade300,
                    //   minRadius: 35.0,
                    //   child: Icon(
                    //     Icons.call,
                    //     size: 30.0,
                    //   ),
                    // ),
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      minRadius: 60.0,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                          NetworkImage('${data['imgUrl']}')
                       // NetworkImage('https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                      ),
                    ),
                //     CircleAvatar(
                //       backgroundColor: Colors.red.shade300,
                //       minRadius: 35.0,
                //       child: Icon(
                //         Icons.message,
                //         size: 30.0,
                //       ),
                //     ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  // 'Bablu Gannu',
                  data['merchantName'],
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent,
                  ),
                ),
                Text(

                  '${s}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent,
                  ),
                ),
                Text(
                  'Ondc Merchant',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //         child: Container(
          //           color: Colors.deepOrange.shade300,
          //           child: ListTile(
          //             title: Text(
          //               '5000',
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 30,
          //                 color: Colors.white,
          //               ),
          //             ),
          //             subtitle: Text(
          //               'Followers',
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 fontSize: 20,
          //                 color: Colors.white70,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         child: Container(
          //           color: Colors.red,
          //           child: ListTile(
          //             title: Text(
          //               '5000',
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 30,
          //                 color: Colors.white,
          //               ),
          //             ),
          //             subtitle: Text(
          //               'Following',
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 fontSize: 20,
          //                 color: Colors.white70,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'MerchantID',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    data['merchantID'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(indent: 15,endIndent: 15,),
                ListTile(
                  title: Text(
                    'Shop Name',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    data['shopName'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(indent: 15,endIndent: 15,),
                ListTile(
                  title: Text(
                    'Shop Address',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    data['shopAddress'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),

                ),
      Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0,80.0,0,0),
              child: TextButton.icon(onPressed: (){
                logout();
              //getData();
              },
                icon: Icon(Icons.logout),
                label: Text('Logout'),
              ),
            ),
          ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void displaySnackBar(String s) {
    var snackdemo = SnackBar(
      content: Text(s),
      backgroundColor: Colors.green,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  }

  void logout() {

    FirebaseAuth.instance.signOut();
    displaySnackBar('Logged out!');
    Navigator.pushReplacementNamed(context, '/sign_in');
  }
}
