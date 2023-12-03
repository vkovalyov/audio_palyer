import 'package:audio_player/features/player/presentation/providers/state/player_notifier.dart';
import 'package:audio_player/features/player/presentation/providers/state/player_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerNotifierProvider =
    StateNotifierProvider<PlayerNotifier, PlayerState>((ref) {
  return PlayerNotifier();
});
