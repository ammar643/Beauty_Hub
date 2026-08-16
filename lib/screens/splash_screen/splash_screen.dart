import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:get/utils.dart';
import 'package:project_user/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _firstImageController;
  late AnimationController _secondImageController;
  late AnimationController _thirdImageController;
  late AnimationController _textController;

  late Animation<double> _firstImageFade;
  late Animation<double> _firstImageScale;
  late Animation<double> _secondImageFade;
  late Animation<double> _secondImageScale;
  late Animation<double> _thirdImageFade;
  late Animation<double> _thirdImageScale;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    _firstImageController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _secondImageController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _thirdImageController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _firstImageFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _firstImageController, curve: Curves.easeIn),
    );

    _firstImageScale = Tween<double>(begin: 1.2, end: 1.0).animate(
      CurvedAnimation(parent: _firstImageController, curve: Curves.easeOut),
    );

    _secondImageFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _secondImageController, curve: Curves.easeInOut),
    );

    _secondImageScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _secondImageController, curve: Curves.elasticOut),
    );

    _thirdImageFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _thirdImageController, curve: Curves.easeInOut),
    );

    _thirdImageScale = Tween<double>(begin: 1.1, end: 1.0).animate(
      CurvedAnimation(parent: _thirdImageController, curve: Curves.easeOut),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    _startSplashSequence();
  }

  void _startSplashSequence() async {

    await _thirdImageController.forward().orCancel;

    await Future.delayed(const Duration(milliseconds: 100));
    await _secondImageController.forward().orCancel;

    await Future.delayed(const Duration(milliseconds: 100));
    await _firstImageController.forward().orCancel;

    await Future.delayed(const Duration(milliseconds: 100));
    await _textController.forward().orCancel;

    await Future.delayed(const Duration(seconds: 5));
    Get.offNamed(AppRoutes.OnbordingScreen1);
  }

  @override
  void dispose() {
    _firstImageController.dispose();
    _secondImageController.dispose();
    _thirdImageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _firstImageController,
            builder: (context, child) {
              final fadeValue = _firstImageFade.value.clamp(0.0, 1.0);
              final scaleValue = _firstImageScale.value;

              return Opacity(
                opacity: fadeValue,
                child: Transform.translate(
                  offset: const Offset(
                    0,
                    210,
                  ), 
                  child: Transform.scale(
                    scale: scaleValue,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/imgth.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          AnimatedBuilder(
            animation: _secondImageController,
            builder: (context, child) {
              final fadeValue = _secondImageFade.value.clamp(0.0, 1.0);
              final scaleValue = _secondImageScale.value;

              return Opacity(
                opacity: fadeValue,
                child: Transform.scale(
                  scale: scaleValue,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/imgt.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          AnimatedBuilder(
            animation: _thirdImageController,
            builder: (context, child) {
              final fadeValue = _thirdImageFade.value.clamp(0.0, 1.0);
              final scaleValue = _thirdImageScale.value;

              return Opacity(
                opacity: fadeValue,
                child: Transform.translate(
                  offset: const Offset(0, -80),
                  child: Transform.scale(
                    scale: scaleValue,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/imgo.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          Center(
            child: FadeTransition(
              opacity: _textAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Beaut',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Image.asset(
                            "images/Vector.jpg",
                            height: 40,
                            width: 40,
                          ),
                          Text(
                            'Hub',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
