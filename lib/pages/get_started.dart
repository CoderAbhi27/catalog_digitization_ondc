import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

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
        // started6CD (4:882)
        padding:  EdgeInsets.fromLTRB(34*fem, 125*fem, 34*fem, 83*fem),
        width:  double.infinity,
        decoration:  BoxDecoration (
          color:  Color(0xff272727),
        ),
        child:
        Column(
          crossAxisAlignment:  CrossAxisAlignment.center,
          children:  [
            Container(
              // aninitiativebyondcxkD (87:1861)
              margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 19*fem),
              child:
              Text(
                'An initiative by ONDC ',
                textAlign:  TextAlign.center,
                style:  TextStyle (
                  fontSize:  14*ffem,
                  fontWeight:  FontWeight.w600,
                  height:  1.175*ffem/fem,
                  color:  Colors.white,
                ),
              ),
            ),
            Container(
              // image143Fs (87:1860)
              margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 25*fem),
              width:  252*fem,
              height:  99*fem,
              child:
              Image.asset(
                'assets/ondc_get_started.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              // supportedbygovernmentofindiaMX (87:1862)
              margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 66*fem),
              child:
              Text(
                'Supported by Government of India',
                textAlign:  TextAlign.center,
                style:  TextStyle(
                  fontSize:  14*ffem,
                  fontWeight:  FontWeight.w400,
                  height:  1.3571428571*ffem/fem,
                  letterSpacing:  0.28*fem,
                  decoration:  TextDecoration.underline,
                  color:  Color(0xefffffff),
                  decorationColor:  Color(0xefffffff),
                ),
              ),
            ),
            Container(
              // frame11039P (88:2409)
              margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 18*fem),
              width:  322*fem,
              height:  241.5*fem,
              child:
              Image.asset(
                'assets/frame_get_started.png',
                width:  322*fem,
                height:  241.5*fem,
              ),
            ),
            Container(
              // wemaintainthesimplicityforsell (88:2410)
              margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 69.5*fem),
              child:
              Text(
                'We maintain the simplicity for sellers.',
                textAlign:  TextAlign.center,
                style:  TextStyle (
                  // 'Sofia Pro',
                  fontSize:  16*ffem,
                  fontWeight:  FontWeight.w400,
                  height:  1.1875*ffem/fem,
                  letterSpacing:  0.32*fem,
                  color:  Color(0xefffffff),
                ),
              ),
            ),
            Container(
              // getchewingdtH (4:883)
              margin:  EdgeInsets.fromLTRB(92*fem, 0*fem, 93*fem, 0*fem),
              width:  double.infinity,
              height:  43*fem,
              decoration:  BoxDecoration (
                color:  Color(0xff7e2ece),
                borderRadius:  BorderRadius.circular(8*fem),
              ),
              child:
              Center(
                child:
                InkWell(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/sign_in');
                  },
                  child: Text(
                    'Get Started !',
                    textAlign:  TextAlign.center,
                    style:  TextStyle (
                      // 'Raleway',
                      fontSize:  16*ffem,
                      fontWeight:  FontWeight.w700,
                      height:  1.175*ffem/fem,
                      color:  Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      /*body: Container(
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
      ),*/
    );
  }
}
