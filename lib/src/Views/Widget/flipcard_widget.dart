import 'dart:math';
import 'package:flutter/material.dart';

class FlipCardController {
  _FlipcardWidgetState? _state;

  Future flipCard() async => _state?.flipCard();
}

class FlipcardWidget extends StatefulWidget {
  final FlipCardController controller;
  final Image front;
  final Image back;

  const FlipcardWidget({
    super.key,
    required this.front,
    required this.back,
    required this.controller,
  });

  @override
  State<FlipcardWidget> createState() => _FlipcardWidgetState();
}

class _FlipcardWidgetState extends State<FlipcardWidget> with TickerProviderStateMixin {
  late AnimationController controller;
  bool isFront = true;
  int flipCount = 0; 
  final int maxFlips = 5;

  Future flipCard() async {
    if (controller.isAnimating || flipCount >= maxFlips) return;
    setState(() {
      isFront = !isFront;
      flipCount++; 
    });

    if (isFront) {
      await controller.reverse();
    } else {
      await controller.forward();
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(widget.front.image, context);
      precacheImage(widget.back.image, context);

      // Automatically start flipping when the screen appears
      _startAutomaticFlip();
    });

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    widget.controller._state = this;
  }

  void _startAutomaticFlip() {
    // Use a Future to loop and flip the card 10 times automatically
    Future.doWhile(() async {
      if (flipCount >= maxFlips) return false; // Stop after 10 flips
      await flipCard();
      await Future.delayed(const Duration(milliseconds: 100)); // Wait for flip animation duration
      return true; // Continue flipping
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final angle = controller.value * -pi;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: isFrontImage(angle.abs())
                ? widget.front
                : Transform(
                    transform: Matrix4.identity()..rotateY(pi),
                    alignment: Alignment.center,
                    child: widget.back,
                  ),
          );
        },
      );

  bool isFrontImage(double angle) {
    const degrees90 = pi / 2;
    const degrees270 = 3 * pi / 2;

    return angle <= degrees90 || angle >= degrees270;
  }
}
