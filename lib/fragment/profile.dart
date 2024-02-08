import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(onPressed: (){
          logout();

        },
          icon: Icon(Icons.logout),
          label: Text('Logout'),
        ),
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
