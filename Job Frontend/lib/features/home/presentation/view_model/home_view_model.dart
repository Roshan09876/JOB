import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/features/home/presentation/state/home_state.dart';

//Making provider to contact with main screen
final homeStateListViewProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel();
});

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(HomeState.intitial());

  //Now making function for bottom Navigation
  void changeIndex(int index) {
    state = state.copywith(index: index);
  }
}
