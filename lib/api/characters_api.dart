import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:riverpod/riverpod.dart';
import '../consts/consts.dart';
import '../services/logger/logger.dart';

final charactersApiProvider = Provider<CharactersApiProvider>(
  (ref) => CharactersApiProvider(ref),
);

class CharactersApiProvider {
  CharactersApiProvider(this.ref) : super();

  final Ref ref;

  Future<AsyncValue<List<CharacterModel>>> getCharacters() async {
    logger.d('Fetching characters...');
    try {
      final response = await Dio().get(Consts.rickAndMortyUrl);
      final List<dynamic> results = response.data["results"] as List<dynamic>;
      List<CharacterModel> characters = results
          .map((json) => CharacterModel.fromJson(json as Map<String, dynamic>))
          .toList();
      if (characters.isEmpty) {
        logger.w('No characters found');
        return const AsyncValue.data([]);
      }
      return AsyncValue.data(characters);
    } catch (e) {
      logger.e('Failed to fetch characters: $e');
      return AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<AsyncValue<List<CharacterModel>>> loadMoreCharacters(
      String nextUrl) async {
    logger.d('Fetching new characters...');
    try {
      final response = await Dio().get(nextUrl);
      final List<dynamic> results = response.data["results"] as List<dynamic>;
      List<CharacterModel> characters = results
          .map((json) => CharacterModel.fromJson(json as Map<String, dynamic>))
          .toList();

      if (characters.isEmpty) {
        logger.w('No characters found');
        return const AsyncValue.data([]);
      }
      return AsyncValue.data(characters);
    } catch (e) {
      logger.e('Failed to fetch characters: $e');
      return AsyncValue.error(e, StackTrace.current);
    }
  }
}
