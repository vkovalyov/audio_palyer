import 'package:audio_player/features/play_list/presentation/providers/play_list_provider.dart';
import 'package:audio_player/features/play_list/presentation/widgets/play_list_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayListWidget extends ConsumerWidget {
  const PlayListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(playListNotifierProvider);
    final state = ref.read(playListNotifierProvider).playLists;

    return Wrap(
      runSpacing: 10.0,
      spacing: 10.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final play in state)
          PlayListCardWidget(
            playList: play,
          ),
      ],
    );
  }
}
