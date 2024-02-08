import 'package:catalog_digitization_ondc/pages/category_catalog.dart';
import 'package:catalog_digitization_ondc/pages/get_started.dart';
import 'package:catalog_digitization_ondc/pages/home.dart';
import 'package:catalog_digitization_ondc/pages/register.dart';
import 'package:catalog_digitization_ondc/pages/sign_in.dart';
import 'package:catalog_digitization_ondc/pages/sign_up.dart';
import 'package:catalog_digitization_ondc/widgets/speechToText.dart';
import 'package:flutter/material.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    // home: Home(),
    // initialRoute: '/get_started',
    initialRoute: '/speech',

    routes: {
      '/home' : (context) => Home(),
      '/get_started' : (context) => GetStarted(),
      '/sign_in' : (context) => SignIn(),
      '/sign_up' : (context) => SignUp(),
      '/categortyCataloge':(context) => CategoryCatalog(),
      '/register':(context) => Register(),
      '/speech':(context) => SpeechToText(),
    },
    debugShowCheckedModeBanner: false,
  ));
}