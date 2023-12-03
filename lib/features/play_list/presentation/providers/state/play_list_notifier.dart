import 'package:audio_player/core/models/composition.dart';
import 'package:audio_player/core/models/play_list.dart';
import 'package:audio_player/features/play_list/presentation/providers/state/play_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PLayListNotifier extends StateNotifier<PlayListState> {
  PLayListNotifier() : super(PlayListState(playLists: []));

  void createPlayList(PlayList<Composition> plaList) {
    final oldState = state;
    oldState.playLists.add(plaList);

    state = state.copyWith(oldState.playLists);
  }

  void deletePlayList(Object playlist) {
    final oldState = state;
    oldState.playLists.remove(playlist);

    state = state.copyWith(oldState.playLists);
  }

  void updatePlayList(PlayList<Composition> plaList) {
    state = state.copyWith(state.playLists);
  }
}
