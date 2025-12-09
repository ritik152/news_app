import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  // Device width & height
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  // Breakpoints
  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1100;
  bool get isDesktop => width >= 1100;

  // Scale text dynamically
  double font(double size) =>
      size * (width / 375); // 375 = base iPhone 11 width

  // Scale padding
  double padding(double value) =>
      value * (width / 375);

  // Scale for square components
  double scale(double value) =>
      value * (width / 375);
}