import 'package:flutter/material.dart';

import '../../consts/consts.dart';
import '../../models/character_model.dart';
import '../../services/texts/texts.dart';
import '../../theme/text_theme.dart';

class ModalWidget extends StatelessWidget {
  const ModalWidget(
      {super.key,
      required this.originalList,
      required this.filterCharacters,
      required this.filterStatus});

  final List<CharacterModel> originalList;
  final Function(String, List<CharacterModel>) filterCharacters;
  final String filterStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Texts.filterByStatus,
              style: nameStyle.copyWith(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: [
                _buildFilterOption(context, Texts.all, originalList),
                _buildFilterOption(context, Texts.alive, originalList),
                _buildFilterOption(context, Texts.dead, originalList),
                _buildFilterOption(context, Texts.unknown, originalList),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(
      BuildContext context, String status, List<CharacterModel> originalList) {
    return ChoiceChip(
      label: Text(status, style: nameStyle.copyWith(color: Colors.black)),
      selected: filterStatus == status,
      onSelected: (selected) {
        if (selected) {
          Navigator.pop(context);
          filterCharacters(status, originalList);
        }
      },
    );
  }
}
