import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double screen_height = MediaQuery.of(context).size.height;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: Colors.grey[800],
      // backgroundColor: Color(0xff272727),
      body: Container(
        // getchewingMBj (2:368)
        // padding: EdgeInsets.fromLTRB(34.5*fem, 14.33*fem, 34.5*fem, 8*fem),

        margin: EdgeInsets.fromLTRB(87.5*fem, screen_height*0.85, 87.5*fem, 0),
        width: double.infinity,
        height: 43*fem,
        // decoration: BoxDecoration (
        //   color: Color(0xff7e2ece),
        //   borderRadius: BorderRadius.circular(8*fem),
        // ),
        child: ElevatedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(BorderSide(
              color: Colors.black
            )),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 8*fem)),
            backgroundColor: MaterialStateProperty.all(Color(0xff7e2ece)),
          ),
          onPressed: (){
            Navigator.pushReplacementNamed(context, '/sign_in');
          },
          child: Center(
            child: Text(
              'Get Started !',
              textAlign: TextAlign.center,
              style:  GoogleFonts.aBeeZee(
                // 'Raleway',
                fontSize: 16*ffem,
                fontWeight: FontWeight.w700,
                height: 1.175*ffem/fem,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
