import 'package:flutter/material.dart';
import '../../services/texts/texts.dart';
import '../../theme/text_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.searchController,
      required this.searchInCharacterList});

  final TextEditingController searchController;
  final Function(String) searchInCharacterList;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: searchInCharacterList,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        hintText: Texts.searchCharactersByName,
        hintStyle: nameStyle.copyWith(fontSize: 13),
        filled: true,
        fillColor: Colors.black12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      style: nameStyle,
    );
  }
}
