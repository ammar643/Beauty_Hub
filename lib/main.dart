import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/controllers/favorite_controller.dart';
import 'package:project_user/controllers/home/HomeController.dart';
import 'package:project_user/routes/pages.dart';
import 'package:project_user/routes/routes.dart';
import 'package:project_user/screens/splash_screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteController());
Get.put(HomeController());
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      //  locale: controller.language,
      // theme: ThemeData(
      //   primarySwatch: Colors.green,
      // ),

     initialRoute: AppRoutes.SplashScreen,
      // initialRoute: AppRoutes.HomeScreen,
      getPages: pages,
    );
  }
}





