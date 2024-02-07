import 'package:catalog_digitization_ondc/pages/get_started.dart';
import 'package:catalog_digitization_ondc/pages/home.dart';
import 'package:catalog_digitization_ondc/pages/sign_in.dart';
import 'package:catalog_digitization_ondc/pages/sign_up.dart';
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
    initialRoute: '/get_started',
    routes: {
      '/home' : (context) => Home(),
      '/get_started' : (context) => GetStarted(),
      '/sign_in' : (context) => SignIn(),
      '/sign_up' : (context) => SignUp(),
    },
    debugShowCheckedModeBanner: false,
  ));
}