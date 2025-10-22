import 'package:flutter/material.dart';

import 'constants.dart';

class LoadingSpinCircle extends StatelessWidget {
  const LoadingSpinCircle({super.key});

  @override
  Widget build(BuildContext context) {
    double widthh = MediaQuery.of(context).size.width;
    return Center(
      child: CircularProgressIndicator(
        color: primaryColor,
        strokeWidth: widthh * 0.001,
      ),
    );
  }
}

PageRouteBuilder customePageTransion(newRoute) {
  return PageRouteBuilder(
      pageBuilder: (_, __, ___) => newRoute,
      transitionDuration: Duration(seconds: 1),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
        return Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
            axisAlignment: 0.0,
          ),
        );
      });
}
