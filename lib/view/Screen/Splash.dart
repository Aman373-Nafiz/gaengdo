import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gaengdo/resources/color.dart';
import 'package:gaengdo/view/Screen/Home.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home())));
  }
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;
    return Scaffold(body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: h/2.75,
                width: h/2.75,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color:gold),
                child: Center(
                  child: Text("Guaendo",style: GoogleFonts.indieFlower(color: BgColor,fontSize: 21,fontWeight: FontWeight.w600),)
                ),
              ),
            ),
            
          ],
        ));
  }
}