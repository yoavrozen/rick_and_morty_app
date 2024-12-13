import 'package:flutter/material.dart';

import '../../consts/consts.dart';
import '../../services/texts/texts.dart';
import '../../theme/text_theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Consts.deepSpaceBlue,
              Consts.indigo,
              Colors.black,
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 20,
              right: -10,
              child: Image.asset(
                Consts.portalImage,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 40,
              child: Image.asset(
                Consts.logoImage,
                fit: BoxFit.contain,
                width: 300,
                height: 100,
              ),
            ),
            Positioned(
              bottom: 5,
              child: Text(
                Texts.appTitle,
                style: titleStyle.copyWith(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Colors.black,
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              child: Text(
                Texts.appTitle,
                style: titleStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
