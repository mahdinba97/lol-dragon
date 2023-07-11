import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lol_dragon/context_extension.dart';

class AnimatedOpenContainer extends StatefulWidget {
  const AnimatedOpenContainer({super.key, required this.closedBuilder, required this.openBuilder});
  final CloseContainerBuilder closedBuilder;
  final OpenContainerBuilder openBuilder;

  @override
  State<AnimatedOpenContainer> createState() => _AnimatedOpenContainerState();
}

class _AnimatedOpenContainerState extends State<AnimatedOpenContainer> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openBuilder: widget.openBuilder,
      closedColor: Colors.transparent,
      middleColor: Colors.transparent,
      openColor: Colors.transparent,
      closedElevation: 0,
      closedBuilder: widget.closedBuilder,
    );
  }
}
