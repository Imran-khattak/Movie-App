import 'dart:ui';

import 'package:cinestream/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlassContainer extends StatelessWidget {
  Widget image;
  double height;
  double widht;

  GlassContainer(
      {super.key,
      required this.image,
      required this.height,
      required this.widht});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: height,
        width: widht,
        child: Stack(
          children: [
            //blur effect...
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
              child: Container(),
            ),

            //gradient effect...
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.munatee.withOpacity(0.2),
                        AppColors.munatee.withOpacity(0.2)
                      ])),
            ),

            Center(child: image),
          ],
        ),
      ),
    );
  }
}
