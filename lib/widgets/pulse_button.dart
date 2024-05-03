import 'package:ai_friend/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PulseButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const PulseButton({
    required this.onTap,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<PulseButton> createState() => _PulseButtonState();
}

class _PulseButtonState extends State<PulseButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Shimmer(
        duration: const Duration(seconds: 3),
        interval: const Duration(milliseconds: 450),
        color: Colors.white,
        colorOpacity: 0.9,
        enabled: true,
        direction: const ShimmerDirection.fromLTRB(),
        child: AppButton(title: widget.title, onTap: widget.onTap),
      ),
    )
        .animate(
          delay: 100.ms,
          // autoPlay: true,
          onInit: (controller) => controller.repeat(reverse: true),
        )
        .scale(
          begin: 1,
          end: 1.015,
          delay: 100.ms,
          duration: 500.ms,
        );
  }
}

// egin: 1, end: 1.01,
