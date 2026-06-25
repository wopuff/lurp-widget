import 'dart:math';

import 'package:flutter/material.dart';

class DiagonalClipper extends CustomClipper<Path> {
  final double angle; // Angle in degrees
  final double
  heightFactor; // Determines where the cut starts on the left edge (0 to 1)
  final bool invert; // Whether to invert the clipping

  DiagonalClipper({
    required this.angle,
    this.heightFactor = 1.0, // Default is 1.0 (cut starts at the bottom)
    this.invert = false, // Default is false (cut at the bottom right)
  });

  @override
  Path getClip(Size size) {
    final double radians = angle * (pi / 180); // Convert degrees to radians

    // Calculate where the cut starts on the left edge based on heightFactor
    final double startY = size.height * heightFactor;

    // Calculate the x-distance the line needs to travel to reach the right edge
    final double deltaX = size.width;

    // Calculate the y-distance the line needs to travel based on the angle
    final double deltaY = deltaX * tan(radians);

    final Path path = Path();

    if (invert) {
      // When invert is true, keep the top left region visible
      path.moveTo(0, 0); // Start at the top-left corner
      path.lineTo(size.width, 0); // Go to the top-right corner
      path.lineTo(size.width, startY - deltaY); // Draw downwards at the angle
      path.lineTo(0, startY); // Draw to the left edge
    } else {
      // When invert is false, keep the bottom right region visible
      path.moveTo(0, startY); // Start at the left edge at startY
      path.lineTo(
        size.width,
        startY - deltaY,
      ); // Draw to the right edge, adjusted by the angle
      path.lineTo(size.width, size.height); // Go to the bottom-right corner
      path.lineTo(0, size.height); // Go to the bottom-left corner
    }

    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
