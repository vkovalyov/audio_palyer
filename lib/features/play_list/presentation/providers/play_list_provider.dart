import 'package:audio_player/features/play_list/presentation/providers/state/play_list_notifier.dart';
import 'package:audio_player/features/play_list/presentation/providers/state/play_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playListNotifierProvider =
    StateNotifierProvider<PLayListNotifier, PlayListState>((ref) {
  return PLayListNotifier();
});
