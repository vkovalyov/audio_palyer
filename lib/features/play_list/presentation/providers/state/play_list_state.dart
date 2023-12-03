import 'package:audio_player/core/models/composition.dart';
import 'package:audio_player/core/models/play_list.dart';

class PlayListState {
  final List<PlayList<Composition>> playLists;

  PlayListState({required this.playLists});

  PlayListState copyWith(List<PlayList<Composition>> playLists) {
    return PlayListState(playLists: playLists);
  }
}
