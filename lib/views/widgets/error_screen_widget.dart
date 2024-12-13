import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/consts/consts.dart';
import 'package:rick_and_morty_app/views/widgets/reset_button.dart';

import '../../services/texts/texts.dart';
import '../../theme/text_theme.dart';

class ErrorScreeenWidget extends StatelessWidget {
  const ErrorScreeenWidget(
      {super.key, required this.error, required this.resetFiltersAndSearch});

  final dynamic error;
  final void Function() resetFiltersAndSearch;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Consts.errorImage,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            Texts.somethingWentWrong,
            style: nameStyle.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            Texts.errorText(error),
            style: nameStyle.copyWith(
              color: Colors.red,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        ResetButton(
          resetFiltersAndSearch: resetFiltersAndSearch,
        ),
      ],
    );
  }
}
