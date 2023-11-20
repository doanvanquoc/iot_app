import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_app/views/home/living_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IoT App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffFF7B54)),
        useMaterial3: true,
        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      ),
      home: const living_Screen(),
    );
  }
}
