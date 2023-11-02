import 'package:flutter/material.dart';
import 'package:flutter_miniproject/screens/start_tour.dart';
import 'package:flutter_miniproject/screens/travel_now.dart';
import 'package:flutter_miniproject/screens/welcome.dart';
import 'package:flutter_miniproject/utils/routes.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title :"Travel App",
      theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
      initialRoute: "/",
      routes: {
        "/": (context) => WelcomeScreen(),
        MyRoutes.welcomeRoute: (context) => WelcomeScreen(),
        MyRoutes.startTourRoute: (context) => StartTourScreen(),
        MyRoutes.tourNowRoute: (context) => TravelNowScreen(),
      },
    );
  }
}
