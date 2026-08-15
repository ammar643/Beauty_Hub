import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_user/constant/imageAssets.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  final CarouselSliderController _controller = CarouselSliderController();

  int currentIndex = 0;
  bool isForward = true;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (isForward) {
        if (currentIndex < 4) {
          currentIndex++;
        } else {
          isForward = false;
          currentIndex--;
        }
      } else {
        if (currentIndex > 0) {
          currentIndex--;
        } else {
          isForward = true;
          currentIndex++;
        }
      }

      _controller.animateToPage(currentIndex);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: _controller,
      itemCount: 5,
      options: CarouselOptions(
        height: 103,
        autoPlay: false, // 
        viewportFraction: 0.64,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
      ),
      itemBuilder: (context, index, realIndex) {
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              ImageAssets.Rectangle,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        );
      },
    );
  }
}