import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/models/data_payload_model.dart';
import '../consts/consts.dart';
import '../services/logger/logger.dart';

final dataPayloadApiProvider = Provider<DataPayloadApiProvider>(
  (ref) => DataPayloadApiProvider(ref),
);

class DataPayloadApiProvider {
  DataPayloadApiProvider(this.ref) : super();

  final Ref ref;

  Future<AsyncValue<DataPayloadModel>> getData() async {
    logger.d('Fetching data(characters and info)...');
    try {
      final response = await Dio().get(Consts.rickAndMortyUrl);
      final dataJson = response.data;
      if (dataJson == null) {
        logger.w('No data found');
        return const AsyncValue.data(DataPayloadModel());
      }
      await Future.delayed(const Duration(
          seconds: 1)); // simulate network delay, mainly to show loaders
      return AsyncValue.data(
          DataPayloadModel.fromJson(dataJson as Map<String, dynamic>));
    } catch (e) {
      logger.e('Failed to fetch data: $e');
      return AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<DataPayloadModel> loadNewData(String nextUrl) async {
    logger.d('Fetching data(characters and info)...');
    try {
      final response = await Dio().get(nextUrl);
      final dataJson = response.data;
      if (dataJson == null) {
        logger.w('No data found');
        return const DataPayloadModel();
      }
      await Future.delayed(const Duration(
          milliseconds: 600)); // simulate network delay, mainly to show loaders
      return DataPayloadModel.fromJson(dataJson as Map<String, dynamic>);
    } catch (e) {
      logger.e('Failed to fetch data: $e');
      // what should it return in case of error?
      return const DataPayloadModel();
    }
  }
}
