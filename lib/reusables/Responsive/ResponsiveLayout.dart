import 'package:flutter/material.dart';
import 'package:multimodule/homepage.dart';
import 'package:multimodule/reusables/constants.dart';

class SResponsiveLayout extends StatelessWidget {
  const SResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_,constraints){
        if(constraints.maxWidth >= desktopScreenSize){
          return Dekstop();
        }else if(constraints.maxWidth < desktopScreenSize && constraints.maxWidth >= mobileScreenSize){
          return Tablet();
        }else{
          return Mobile();
        }
      },
    );
  }
}
