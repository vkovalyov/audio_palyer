import 'package:audio_player/core/models/composition.dart';
import 'package:audio_player/core/models/play_list.dart';

class PlayerState {
  PlayList<Composition>? player;



  PlayerState({required this.player});

  PlayerState copyWith( PlayList<Composition> player) {
    return PlayerState(player: player);
  }
}
