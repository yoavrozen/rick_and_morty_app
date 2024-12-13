import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_app/models/name_and_url_model.dart';

part 'character_model.freezed.dart';
part 'character_model.g.dart';

@freezed
class CharacterModel with _$CharacterModel {
  const factory CharacterModel({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    NameAndUrlModel? origin,
    NameAndUrlModel? location,
    String? image,
    List<String>? episode,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
}
