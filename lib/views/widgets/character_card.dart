import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/consts/consts.dart';
import 'package:rick_and_morty_app/services/texts/texts.dart';
import '../../models/character_model.dart';
import '../../theme/text_theme.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.character});

  final CharacterModel? character;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Container(
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
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(character?.image ?? ''),
            radius: 30,
            backgroundColor: Colors.grey[300],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  character?.name ?? "Unknown",
                  style: nameStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(character?.status),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(character?.status ?? Texts.unknown,
                    style: statusStyle),
              ),
            ],
          ),
          subtitle: Text(
            character?.species ?? Texts.unknownSpecies,
            style: speciesStyle,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(Texts.name, character?.name),
                  _buildDetailRow(Texts.species, character?.species),
                  _buildDetailRow(Texts.status, character?.status),
                  _buildDetailRow(Texts.gender, character?.gender),
                  _buildDetailRow(Texts.origin, character?.origin?.name),
                  _buildDetailRow(Texts.location, character?.location?.name),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            character?.image ?? '',
                            fit: BoxFit.cover,
                            height: 150,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: nameStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value ?? Texts.unknown,
              style: nameStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.normal),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case Texts.alive:
        return Colors.green;
      case Texts.dead:
        return Colors.red;
      // also handles 'unknown' status(not alive or dead)
      default:
        return Colors.grey;
    }
  }
}
