import 'package:flutter/material.dart';
import '../../services/texts/texts.dart';
import '../../theme/text_theme.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  const LoadingIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const CircularProgressIndicator(color: Colors.white),
        const SizedBox(height: 10),
        Text(
          Texts.loadingMoreCharacters,
          style: nameStyle.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
