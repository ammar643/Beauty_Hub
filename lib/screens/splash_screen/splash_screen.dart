// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:project_user/constant/imageAssets.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {

//   int currentIndex = 0;

//   final List<String> images = [
    
//     ImageAssets.splash1,
//     ImageAssets.splash4,
//     ImageAssets.splash2,
//     ImageAssets.splas3,

//   ];

//   @override
//   void initState() {
//     super.initState();

//     Timer.periodic(const Duration(seconds: 2), (timer) {

//       if (currentIndex < images.length - 1) {
//         setState(() {
//           currentIndex++;
//         });
//       } else {
//         timer.cancel();

//     
//         // Get.offAll(HomeScreen());
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       body: Center(
//         child: Stack(
//          // alignment: Alignment.center,
//           children: List.generate(images.length, (index) {

//             return AnimatedOpacity(
//               duration: const Duration(milliseconds: 800),
//               opacity: index <= currentIndex ? 1.0 : 0.0,

//               child: Image.asset(
//                 images[index],
//                 width: 393,
//                 height: 852,
//                 fit: BoxFit.contain,
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
