import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/api/characters_api.dart';
import 'package:rick_and_morty_app/models/character_model.dart';

class CharactersController
    extends StateNotifier<AsyncValue<List<CharacterModel>>> {
  CharactersController(this.ref) : super(const AsyncValue.loading()) {
    loadCharacters();
  }

  final Ref ref;

  Future<void> loadCharacters() async {
    try {
      final characters = await ref.read(charactersApiProvider).getCharacters();
      state = characters;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await loadCharacters();
  }

  Future<void> loadMoreCharacters(String nextUrl) {
    return ref.read(charactersApiProvider).loadMoreCharacters(nextUrl);
  }
}

final charactersProvider = StateNotifierProvider<CharactersController,
    AsyncValue<List<CharacterModel>>>((ref) {
  return CharactersController(ref);
});
