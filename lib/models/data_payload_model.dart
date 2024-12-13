import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:rick_and_morty_app/models/info_model.dart';

part 'data_payload_model.freezed.dart';
part 'data_payload_model.g.dart';

@freezed
class DataPayloadModel with _$DataPayloadModel {
  const factory DataPayloadModel({
    InfoModel? info,
    List<CharacterModel>? results,
  }) = _DataPayloadModel;

  factory DataPayloadModel.fromJson(Map<String, dynamic> json) =>
      _$DataPayloadModelFromJson(json);
}
