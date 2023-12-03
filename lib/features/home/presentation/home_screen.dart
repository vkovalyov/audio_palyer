import 'package:audio_player/core/consts.dart';
import 'package:audio_player/features/play_list/presentation/create_play_list_screen.dart';
import 'package:audio_player/features/play_list/presentation/widgets/play_list_widget.dart';
import 'package:audio_player/features/player/presentation/widgets/player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _buttonWidth = 200.0;
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: const PlayerWidget(),
      floatingActionButton: SizedBox(
          width: _buttonWidth,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CreatePlayListScreen()));
            },
            child: const Text(createPlayList),
          )),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          myPlayLists,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: PlayListWidget(),
      ),
    );
  }
}
