import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/theme/text_theme.dart';
import '../../models/character_model.dart';
import '../../services/texts/texts.dart';
import 'modal_widget.dart';

class FilterButton extends StatelessWidget {
  const FilterButton(
      {super.key,
      required this.originalList,
      required this.filterCharacters,
      required this.filterStatus});
  final List<CharacterModel> originalList;
  final Function(String, List<CharacterModel>) filterCharacters;
  final String filterStatus;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _showFilterModal(
        context,
      ),
      icon: filterStatus != Texts.all ? const Icon(Icons.filter_list) : null,
      label: filterStatus != Texts.all
          ? Text(
              filterStatus,
              style: nameStyle.copyWith(fontSize: 13),
            )
          : const Icon(Icons.filter_list),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  void _showFilterModal(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ModalWidget(
            originalList: originalList,
            filterCharacters: filterCharacters,
            filterStatus: filterStatus);
      },
    );
  }
}
