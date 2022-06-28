import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardStatusAnimation extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2500,
      ),
    );

    animateValue(1);

    animationController.forward();
  }

  late AnimationController animationController;
  late Animation<double> animation;
  var animationValue = 0.0.obs;

  var value = 0.0.obs;

  animateValue(double? toValue) {
    animation = Tween<double>(begin:.2, end: 1)
        .animate(animationController)
      ..addListener(() {
       
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });

    animationController.forward();
  }
}
