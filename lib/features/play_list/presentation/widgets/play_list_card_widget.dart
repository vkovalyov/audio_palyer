import 'package:audio_player/core/consts.dart';
import 'package:audio_player/core/models/composition.dart';
import 'package:audio_player/core/models/play_list.dart';
import 'package:audio_player/features/play_list/presentation/create_play_list_screen.dart';
import 'package:audio_player/features/play_list/presentation/providers/play_list_provider.dart';
import 'package:audio_player/features/player/presentation/play_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayListCardWidget extends ConsumerWidget {
  final PlayList<Composition> playList;

  const PlayListCardWidget({
    super.key,
    required this.playList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          Text(playList.name),
          Text('$countMusic: ${playList.length}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    ref
                        .read(playerNotifierProvider.notifier)
                        .startPlayList(playList);
                  },
                  icon: const Icon(Icons.play_circle)),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreatePlayListScreen(
                              playList: playList,
                            )));
                  },
                  icon: const Icon(Icons.settings)),
              IconButton(
                  onPressed: () {
                    _showAlertDialog(context, playList, ref);
                  },
                  icon: const Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }

  Future<void> _showAlertDialog(
    BuildContext context,
    PlayList playList,
    WidgetRef ref,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(removePlaylistTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$removePlaylistDesc ${playList.name}?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(yes),
              onPressed: () {
                Navigator.of(context).pop();
                ref
                    .read(playListNotifierProvider.notifier)
                    .deletePlayList(playList);
              },
            ),
          ],
        );
      },
    );
  }
}
