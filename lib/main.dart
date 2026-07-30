import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/routes/pages.dart';
import 'package:project_user/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Localcontrolar controller  =  Get.put(Localcontrolar());

    return GetMaterialApp(
//translations:Mytranslition() ,

      debugShowCheckedModeBanner: false,
      //  locale: controller.language,
      // theme: ThemeData(
      //   primarySwatch: Colors.green,
      // ),

     initialRoute: AppRoutes.homeScreen,
      // initialRoute: AppRoutes.HomeScreen,
      getPages: pages,
    );
  }
}





