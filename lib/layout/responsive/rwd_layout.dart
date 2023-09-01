import 'package:flutter/material.dart';

class RWDLayout extends Container {
  static final double smScreenWidth = 768;
  static final double mdScreenWidth = 992;
  static final double lgScreenWidth = 1200;
  RWDLayout({
    super.key,
    super.alignment,
    super.padding,
    super.color,
    super.decoration,
    super.foregroundDecoration,
    super.width,
    super.height,
    super.constraints,
    super.margin,
    super.transform,
    super.transformAlignment,
    super.child,
    super.clipBehavior,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return SafeArea(
          child: Container(
        alignment: Alignment.topCenter,
        child: FractionallySizedBox(
          widthFactor: (constraints.maxWidth <= smScreenWidth)
              ? 0.88
              : (constraints.maxWidth < mdScreenWidth)
                  ? 0.6
                  : 0.3,
          child: super.child,
        ),
      ));
    }));
  }
}
