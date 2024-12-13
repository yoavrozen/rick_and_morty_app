import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/api/info_api.dart';
import 'package:rick_and_morty_app/models/info_model.dart';

class InfoController extends StateNotifier<AsyncValue<InfoModel>> {
  InfoController(this.ref) : super(const AsyncValue.loading()) {
    loadInfo();
  }

  final Ref ref;

  Future<void> loadInfo() async {
    try {
      final info = await ref.read(ifnoApiProvider).getInfo();
      state = info;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await loadInfo();
  }
}

final infoProvider =
    StateNotifierProvider<InfoController, AsyncValue<InfoModel>>((ref) {
  return InfoController(ref);
});
