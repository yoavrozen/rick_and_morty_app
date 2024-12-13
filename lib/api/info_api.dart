import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/models/info_model.dart';
import '../consts/consts.dart';
import '../services/logger/logger.dart';

final ifnoApiProvider = Provider<InfoApiProvider>(
  (ref) => InfoApiProvider(ref),
);

class InfoApiProvider {
  InfoApiProvider(this.ref) : super();

  final Ref ref;

  Future<AsyncValue<InfoModel>> getInfo() async {
    logger.d('Fetching info...');
    try {
      final response = await Dio().get(Consts.rickAndMortyUrl);
      final infoJson = response.data["info"];

      if (infoJson == null) {
        logger.w('No info found');
        return const AsyncValue.data(InfoModel());
      }
      return AsyncValue.data(
          InfoModel.fromJson(infoJson as Map<String, dynamic>));
    } catch (e) {
      logger.e('Failed to fetch info: $e');
      return AsyncValue.error(e, StackTrace.current);
    }
  }
}
