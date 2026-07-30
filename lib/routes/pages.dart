
import 'package:get/get.dart';
import 'package:project_user/routes/routes.dart';
import 'package:project_user/screens/Auth/CheckEmail.dart';
import 'package:project_user/screens/Auth/Verification.dart';
import 'package:project_user/screens/Auth/forgotpassword.dart';
import 'package:project_user/screens/Auth/login.dart';
import 'package:project_user/screens/Auth/new_password%20.dart';
import 'package:project_user/screens/Auth/sinup.dart';
import 'package:project_user/screens/Auth/sucssfulsignup.dart';
import 'package:project_user/screens/Auth/test.dart';
import 'package:project_user/screens/home/homeScreen.dart';

import 'package:project_user/screens/onbordingscreen1.dart';


final pages = <GetPage>[
 


 GetPage(
    name: AppRoutes.OnbordingScreen1,
    page: () =>  Onbordingscreen1() ,
  ),


GetPage(
    name: AppRoutes.login,
    page: () =>  Login() ,
  ),


GetPage(
    name: AppRoutes.sinup,
    page: () =>  Sinup(),
  ),



GetPage(
    name: AppRoutes.forgotpassword,
    page: () =>  Forgotpassword(),
  ),


GetPage(
    name: AppRoutes.test,
    page: () =>  Test() ,
  ),



GetPage(
    name: AppRoutes.CheckEmail,
    page: () =>  Checkemail() ,
  ),


GetPage(
    name: AppRoutes.NewPassword,
    page: () =>  NewPassword() ,
  ),


GetPage(
    name: AppRoutes.Verification,
    page: () =>  Verification() ,
  ),


GetPage(
    name: AppRoutes.SuccessfulSignIn,
    page: () =>  SuccessfulSignIn() ,
  ),

GetPage(
    name: AppRoutes.homeScreen,
    page: () =>  HomeScreen() ,
  ),








  
];

