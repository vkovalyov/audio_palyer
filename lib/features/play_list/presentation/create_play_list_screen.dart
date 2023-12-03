import 'package:audio_player/core/consts.dart';
import 'package:audio_player/core/models/composition.dart';
import 'package:audio_player/core/models/play_list.dart';
import 'package:audio_player/core/utils.dart';
import 'package:audio_player/features/play_list/presentation/providers/play_list_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePlayListScreen extends ConsumerStatefulWidget {
  final PlayList<Composition>? playList;

  const CreatePlayListScreen({
    super.key,
    this.playList,
  });

  @override
  ConsumerState<CreatePlayListScreen> createState() =>
      _CreatePlayListScreenState();
}

class _CreatePlayListScreenState extends ConsumerState<CreatePlayListScreen> {
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late PlayList<Composition> playList;

  @override
  void initState() {
    if (widget.playList != null) {
      playList = widget.playList!;
      controller.text = playList.name;
    } else {
      playList = PlayList<Composition>(name: '', id: getRandomString(12));
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SizedBox(
            width: 200,
            child: FloatingActionButton(
              onPressed: () {
                final isValidated = _formKey.currentState?.validate() ?? false;

                if (isValidated) {
                  playList.name = controller.text;
                  if (widget.playList != null) {
                    ref
                        .read(playListNotifierProvider.notifier)
                        .updatePlayList(playList);
                  } else {
                    ref
                        .read(playListNotifierProvider.notifier)
                        .createPlayList(playList);
                  }

                  Navigator.pop(context);
                }
              },
              child: const Text(create),
            )),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.blue,
          title: const Text(
            createPlayListTitle,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 20,
              right: 20,
              bottom: 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(playListTitle),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (v) {
                      if (v == null) return formValidate;
                      if (v.isEmpty) return formValidate;
                      return null;
                    },
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.greenAccent,
                      ),
                    )),
                    controller: controller,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(musicList),
                getList(),
                TextButton(
                    onPressed: () async {
                      final FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        final String name = result.files.first.name;

                        final player = AudioPlayer();

                        //   await player.play(urlSourceFromBytes(result.files.first.bytes!));
                        await player.setSource(
                            urlSourceFromBytes(result.files.first.bytes!));

                        final durations = await player.getDuration();
                        final composition = Composition(
                          name: name,
                          seconds: durations?.inSeconds ?? 0,
                          bytes: result.files.first.bytes!,
                        );
                        setState(() {
                          playList.append(composition);
                        });
                      }
                    },
                    child: const Text(addMusic))
              ],
            ),
          ),
        ));
  }

  Widget getList() {
    if (playList.isEmpty) return const SizedBox();

    return SizedBox(
      height: 500,
      child: ReorderableListView(
          buildDefaultDragHandles: false,
          onReorder: (oldIndex, newIndex) => setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }

                final first = playList.getItem(oldIndex);
                final res = playList.remove(first!);
                if (res != null) {
                  playList.nodeAt(res, newIndex);
                }
              }),
          children: [
            for (int i = 0; i < playList.length; i++)
              ReorderableDragStartListener(
                key: Key('${playList.getItem(i)?.value.name}$i'),
                index: i,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${playList.getItem(i)?.value.name}'),
                        const SizedBox(height: 10),
                        Text(
                            formattedTime(playList.getItem(i)?.value.seconds ?? 0)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                final x = playList.getItem(i);
                                playList.remove(x!);
                              });
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              )
          ]),
    );
  }
}
