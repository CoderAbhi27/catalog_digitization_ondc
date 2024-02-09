import 'package:catalog_digitization_ondc/pages/add_item_form.dart';
import 'package:catalog_digitization_ondc/pages/category_catalog.dart';
import 'package:catalog_digitization_ondc/pages/get_started.dart';
import 'package:catalog_digitization_ondc/pages/home.dart';
import 'package:catalog_digitization_ondc/pages/my_catalog.dart';
import 'package:catalog_digitization_ondc/pages/register.dart';
import 'package:catalog_digitization_ondc/pages/sign_in.dart';
import 'package:catalog_digitization_ondc/pages/sign_up.dart';
import 'package:catalog_digitization_ondc/widgets/speechToText.dart';
import 'package:flutter/material.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool loggedIn = FirebaseAuth.instance.currentUser!=null;

  runApp(MaterialApp(
    // home: Home(),
   initialRoute: loggedIn ? '/home' : '/get_started',
     //initialRoute: '/add_item_form',

    routes: {
      '/home' : (context) => Home(),
      '/get_started' : (context) => GetStarted(),
      '/sign_in' : (context) => SignIn(),
      '/sign_up' : (context) => SignUp(),
      '/category_catalog':(context) => CategoryCatalog(),
      '/register':(context) => Register(),
      '/speech':(context) => SpeechToText(),
      '/add_item_form' :(context) => AddItemForm(),
      '/my_catalog' :(context) => MyCatalog(),
    },
    debugShowCheckedModeBanner: false,
  ));
}