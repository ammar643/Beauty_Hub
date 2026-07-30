
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/controllers/onbording_controler.dart';

import 'package:project_user/services/static/static.dart';
import 'package:project_user/widgets/onbording/onboarding_back_button.dart';
import 'package:project_user/widgets/onbording/onboarding_background.dart';
import 'package:project_user/widgets/onbording/onboarding_glass_card.dart';

class Onbordingscreen1 extends StatelessWidget {
  Onbordingscreen1({super.key});

   OnboardingController controller =
      Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OnboardingController>(
        builder: (controller) {
          return PageView.builder(
            controller: controller.pageController,
            itemCount: onBordinglist.length,

            onPageChanged: controller.onPageChanged,

            itemBuilder: (context, index) {
              return Stack(
                children: [

                  /// الخلفية
                  OnboardingBackground(
                    image: onBordinglist[index].image!,
                  ),

                  /// زر الرجوع
                  if (controller.currentIndex > 0)
                    OnboardingBackButton(
                      onTap: controller.previousPage,
                    ),

                  /// الكارد
                  OnboardingGlassCard(
                    title: onBordinglist[index].title!,
                    body: onBordinglist[index].body!,
                    currentIndex: controller.currentIndex,
                    onNext: controller.nextPage,
                    onSkip: controller.skipPages,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}