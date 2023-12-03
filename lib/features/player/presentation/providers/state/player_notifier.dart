import 'package:audio_player/core/models/composition.dart';
import 'package:audio_player/core/models/play_list.dart';
import 'package:audio_player/features/player/presentation/providers/state/player_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerNotifier extends StateNotifier<PlayerState> {
  PlayerNotifier() : super(PlayerState(player: null));

  void startPlayList(PlayList<Composition> player) {
    player.playAll();
    state = state.copyWith(player);
  }

  void previousTrack() {
    state.player?.previousTrack();
    state = state.copyWith(state.player!);
  }

  void nextTrack() {
    state.player?.nextTrack();
    state = state.copyWith(state.player!);
  }
}
