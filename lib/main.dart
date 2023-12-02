import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/firebase_options.dart';
import 'package:iot_app/repository/authentication_repository.dart';
import 'package:iot_app/view_models/authentication_view_model.dart';
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
      home: FutureBuilder(
        future: Get.find<AuthenticationRepository>().setInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 2,
                  color: AppColor.primaryColor,
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
