import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_app/firebase_options.dart';
import 'package:iot_app/repository/authentication_repository.dart';
import 'package:iot_app/view_models/authentication_view_model.dart';
import 'package:iot_app/view_models/edit_user_view_model.dart';
import 'package:iot_app/view_models/navigation_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(AuthenticationRepository());
  Get.put(GlobalModel());
  Get.put(AuthenticationViewModel());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      initialBinding: BindingsBuilder(() {
        Get.put(EditUserViewModel());
      }),
      home: FutureBuilder(
          future: Get.find<AuthenticationRepository>().setInitialScreen(),
          builder: (context, snapshot) {
            return const Scaffold();
          }),
    );
  }
}
