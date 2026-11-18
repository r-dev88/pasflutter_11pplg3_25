  import 'package:flutter/material.dart';
  import 'package:get/get_navigation/get_navigation.dart';
  // import 'package:tes/Calculator_ste.dart';
  // import 'package:tes/Pages/login_clone_fix.dart';
  import 'package:tes/Routes.dart';
  // import 'package:tes/claculator_page.dart';
  // import 'package:tes/Pages/login_clone_fix.dart';
  // import 'package:tes/login_clone.dart';
  // import 'package:tes/login_page.dart';

  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
    // return GetMaterialApp(home: KalkulatorPages());
    return GetMaterialApp(
        title: "Kuliner & Liga Inggris",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF087E47)),
          useMaterial3: true,
        ),
        initialRoute: Routes.Login,
        getPages: Routes.myPages,
      );
  
    }
  }