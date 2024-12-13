import 'package:freezed_annotation/freezed_annotation.dart';

part 'name_and_url_model.freezed.dart';
part 'name_and_url_model.g.dart';

@freezed
class NameAndUrlModel with _$NameAndUrlModel {
  const factory NameAndUrlModel({
    String? name,
    String? url,
  }) = _NameAndUrlModel;

  factory NameAndUrlModel.fromJson(Map<String, dynamic> json) =>
      _$NameAndUrlModelFromJson(json);
}
