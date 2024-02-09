import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool hidePassword = true;
  bool hideConfirmPassword = true;


  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    // double ffem = fem * 0.97;

    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),

            child: Image.asset('assets/ondc_icon.png'),
            // child: const Text(
            //   'ONDC',
            //   style: TextStyle(
            //       color: Colors.blue,
            //       fontWeight: FontWeight.w500,
            //       fontSize: 30),
            // ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      backgroundColor: Colors.grey[800],
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[

              Container(
                margin: EdgeInsets.only(top: fem*5),//, bottom: fem*10),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                // child: const Text(
                //   'Sign in',
                //   style: TextStyle(
                //     fontSize: 50,
                //     color: Colors.white,
                //   ),
                // )
                child: Image.asset('assets/sign_up.png'),

              ),

              Container(
                //alignment: Alignment.center,
                margin: EdgeInsets.only(top: fem*5),//, bottom: fem*20),
                child: const Text(
                  ' SIGN UP',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                //alignment: Alignment.center,
                margin: EdgeInsets.only( bottom: fem*10),
                child: const Text(
                  '  Please Sign up to continue',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(

                    color: Colors.white,
                  ),
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                    iconColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0.0),
                child: TextField(
                  obscureText: hidePassword,
                  controller: passwordController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      icon: Icon(Icons.password),
                      iconColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        icon: Icon(
                            hidePassword ? Icons.visibility_off : Icons.visibility
                        ),
                        color: Colors.white,
                        onPressed: (){
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      )
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0.0),
                child: TextField(
                  obscureText: hideConfirmPassword,
                  controller: confirmPasswordController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      icon: Icon(Icons.password),
                      iconColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        icon: Icon(
                            hideConfirmPassword ? Icons.visibility_off : Icons.visibility
                        ),
                        color: Colors.white,
                        onPressed: (){
                          setState(() {
                            hideConfirmPassword = !hideConfirmPassword;
                          });
                        },
                      )
                  ),
                ),
              ),
              Container(
                  height: 80,
                  padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('SIGN UP', style: TextStyle(fontSize: 20.0)),
                    onPressed: () {
                      String email = nameController.text;
                      String pass = passwordController.text;
                      String confirmPass = confirmPasswordController.text;
                      signUp(email, pass, confirmPass);
                    },
                  )
              ),
              Row(
                children: <Widget>[
                  Container(
                    // height: 40.0,
                    padding: EdgeInsets.only(top: 10.5),
                    child: const Text('Already have an account?',
                      style: TextStyle(color: Colors.white),),
                  ),
                  Container(
                    height:40.0,
                    // alignment: Alignment.topCenter,
                    child: TextButton(

                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.amber,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/sign_in');
                      },
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ],
          )),
    );
  }

  Future<void> signUp(String email, String pass, String confirmPass) async {
    if(email.isEmpty || pass.isEmpty || confirmPass.isEmpty){
      displaySnackBar('Please fill all the fields!');
      return;
    }
    if(pass!=confirmPass){
      displaySnackBar('Passwords does not match!');
      return;
    }
    showLoaderDialog(context);
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      Navigator.pop(context);
      displaySnackBar('Sign up successful');
      Navigator.pushReplacementNamed(context, '/register');


    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     displaySnackBar('The password provided is too weak.');
    //   } else if (e.code == 'email-already-in-use') {
    //     displaySnackBar('The account already exists for that email.');
    //   }
    } catch (e) {
      Navigator.pop(context);
      displaySnackBar(e.toString());
    }

  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [

          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 20),child:Text("Loading...",
            style: TextStyle(fontSize: 16,),
            textAlign: TextAlign.right,

          )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
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
}
