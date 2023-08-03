import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controller/Bindings/homepagebindings.dart';
import 'View/Authpages/signuppage.dart';
import 'View/Compenents/theme.dart';
import 'View/Authpages/onboarding.dart';
import 'View/HomePages/DriverPages/driverhome.dart';
import 'View/HomePages/UserPages/homepage.dart';
import 'View/HomePages/UserPages/ridespage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = new PostHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      //  home: Example(title: 'HOHO'),
      //home: MapScreen(),
      initialRoute: '/homepage',
      getPages: [
        GetPage(name: '/', page: () => const OneBoard()),
        GetPage(name: '/signup', page: () => const SignupPage()),
        GetPage(
            name: '/homepage', page: () => HomePage(), binding: Homebindings()),
        GetPage(
            name: '/ridespage',
            page: () => RidesPage(),
            binding: Homebindings()),
        GetPage(
            name: '/driverhome',
            page: () => DriverHomePage(),
            binding: Homebindings()),
      ],
    );
  }
}

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
