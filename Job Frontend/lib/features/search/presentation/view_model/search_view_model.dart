import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/features/search/data/datasource/search_remote_datasource.dart';
import 'package:job_finder/features/search/presentation/state/search_state.dart';

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, SearchState>((ref) {
  final searchRemoteDataSource = ref.read(searchRemoteDataSourceProvider);
  return SearchViewModel(searchRemoteDataSource);
});

class SearchViewModel extends StateNotifier<SearchState> {
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchViewModel(this.searchRemoteDataSource) : super(SearchState.initial());

    Future<void> getSearchJobs(String text) async {
    if (text.isEmpty) {
      state = state.copyWith(searchApiModel: [], isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: true);
    final result = await searchRemoteDataSource.searchJobs(text);
    result.fold((failure) {
      state = state.copyWith(isLoading: false,);
    }, (success) {
      state = state.copyWith(isLoading: false, searchApiModel: success);
    });
  }

  Future<void> resetState() async{
    state = SearchState.initial();
  }
}
