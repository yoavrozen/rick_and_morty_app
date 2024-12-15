import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/consts/consts.dart';
import 'package:rick_and_morty_app/controllers/data_payload_controller.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:rick_and_morty_app/views/widgets/empty_list_widget.dart';
import 'package:rick_and_morty_app/views/widgets/filter_button.dart';
import 'package:rick_and_morty_app/views/widgets/loading_indicator_widget.dart';
import '../services/texts/texts.dart';
import 'widgets/custom_appbar.dart';
import 'widgets/character_card.dart';
import 'widgets/error_screen_widget.dart';
import 'widgets/loading_list_skeleton.dart';
import 'widgets/reset_button.dart';
import 'widgets/custom_text_field.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();

  // deafult filter status is all
  String _filterStatus = Texts.all;
  String _searchQuery = "";
  List<CharacterModel> _filteredList = [];

  // to inidiacate if we are loading more characters
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreCharacters();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // this function is called to load more characters
  void _loadMoreCharacters() async {
    if (_isLoadingMore) return;

    setState(() => _isLoadingMore = true);

    await ref.read(dataPayloadProvider.notifier).loadMoreCharacters();
    final newCharacters =
        ref.read(dataPayloadProvider).asData?.value.results ?? [];

    setState(() {
      _isLoadingMore = false;
      _applyFiltersAndSearch(newCharacters);
    });
  }

  // this function is called when the user selects a filter
  void _filterCharacters(String status, List<CharacterModel> originalList) {
    setState(() {
      _filterStatus = status;
      _applyFiltersAndSearch(originalList);
    });
  }

  // this function is called when the user types in the search bar
  void _searchInCharacterList(String query) {
    setState(() {
      _searchQuery = query;
      _applyFiltersAndSearch(
          ref.read(dataPayloadProvider).asData?.value.results ?? []);
    });
  }

  // this function applies the filters and search to the character list
  void _applyFiltersAndSearch(List<CharacterModel> originalList) {
    _filteredList = originalList;
    if (_filterStatus != Texts.all) {
      _filteredList = _filteredList
          .where((character) => character.status == _filterStatus)
          .toList();
    }
    if (_searchQuery.isNotEmpty) {
      _filteredList = _filteredList
          .where((character) =>
              character.name
                  ?.toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ==
              true)
          .toList();
    }
  }

  // this function is called when the user clicks on the reset button, refreshes the state
  void _resetFiltersAndSearch() async {
    setState(() {
      _filterStatus = Texts.all;
      _searchQuery = "";
      _searchController = TextEditingController();
      _filteredList = [];
    });
    await ref.read(dataPayloadProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final dataPayload = ref.watch(dataPayloadProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: CustomAppBar(),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage(Consts.background),
                fit: BoxFit.fitHeight)),
        child: dataPayload.when(
          data: (data) {
            // initialzing the filteredList with the initial data, in case there is no data yet(happens before the  initial data is loaded)
            if (_filteredList.isEmpty &&
                _searchQuery.isEmpty &&
                _filterStatus == Texts.all) {
              _filteredList = data.results ?? [];
            }
            return Column(
              children: [
                actionsBarWidget(),
                _filteredList.isEmpty
                    ? const EmptyListWidget()
                    : Expanded(
                        child: Stack(children: [
                          ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                _filteredList.length + (_isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index >= _filteredList.length) {
                                return const LoadingIndicatorWidget();
                              }
                              final character = _filteredList[index];
                              return CharacterCard(character: character);
                            },
                          ),
                        ]),
                      )
              ],
            );
          },
          error: (error, stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ErrorScreeenWidget(
                  error: error,
                  resetFiltersAndSearch: _resetFiltersAndSearch,
                ),
              ],
            );
          },
          loading: () {
            return LoadingListSkeleton(
              actionsBarWidget: actionsBarWidget(),
            );
          },
        ),
      ),
    );
  }

  Widget actionsBarWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: CustomTextField(
            searchController: _searchController,
            searchInCharacterList: _searchInCharacterList,
          )),
          const SizedBox(width: 8),
          FilterButton(
            originalList:
                ref.read(dataPayloadProvider).asData?.value.results ?? [],
            filterCharacters: _filterCharacters,
            filterStatus: _filterStatus,
          ),
          const SizedBox(width: 8),
          ResetButton(
            resetFiltersAndSearch: _resetFiltersAndSearch,
          )
        ],
      ),
    );
  }
}
