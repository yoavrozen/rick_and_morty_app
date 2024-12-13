import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/api/data_payload_api.dart';
import 'package:rick_and_morty_app/models/data_payload_model.dart';

final dataPayloadProvider =
    StateNotifierProvider<DataPayloadController, AsyncValue<DataPayloadModel>>(
        (ref) {
  return DataPayloadController(ref);
});

class DataPayloadController
    extends StateNotifier<AsyncValue<DataPayloadModel>> {
  DataPayloadController(this.ref) : super(const AsyncValue.loading()) {
    loadData();
  }

  final Ref ref;
  int currentPage = 1;

  Future<void> loadData() async {
    try {
      final data = await ref.read(dataPayloadApiProvider).getData();
      state = data;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> loadMoreCharacters() async {
    try {
      currentPage++;
      final newData = await ref
          .read(dataPayloadApiProvider)
          .loadNewData(state.asData?.value.info?.next ?? "");
      state = state.when(
        data: (data) {
          final updatedResults = [...?data.results, ...?newData.results];
          final updatedInfo = newData.info;
          final updatedData =
              data.copyWith(results: updatedResults, info: updatedInfo);
          return AsyncValue.data(updatedData);
        },
        error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
        loading: () => const AsyncValue.loading(),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> refresh() async {
    currentPage = 1;
    state = const AsyncValue.loading();
    await loadData();
  }
}
