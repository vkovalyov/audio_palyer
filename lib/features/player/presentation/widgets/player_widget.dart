import 'dart:async';
import 'package:audio_player/core/models/composition.dart';
import 'package:audio_player/core/models/play_list.dart';
import 'package:audio_player/core/utils.dart';
import 'package:audio_player/features/player/presentation/play_list_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerWidget extends ConsumerStatefulWidget {
  const PlayerWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayerWidget();
}

class _PlayerWidget extends ConsumerState<PlayerWidget> {
  final player = AudioPlayer();
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  double valuePlayer = 0.5;

  bool get _isPlaying => _playerState == PlayerState.playing;

  @override
  void initState() {
    _playerState = player.state;
    player.getDuration().then(
          (value) => setState(() {
            _duration = value;
          }),
        );
    player.getCurrentPosition().then(
          (value) => setState(() {
            _position = value;
          }),
        );
    final state = ref.read(playerNotifierProvider).player;
    _initStreams(state);

    super.initState();
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();

    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }

  void _initStreams(PlayList<Composition>? state) async {
    player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
        nextTrack();
      });
    });

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });

    if (state != null) {
      await player.play(urlSourceFromBytes(state.current!.value.bytes));
    }
  }

  void startCurrentPlayer() async {
    final state = ref.read(playerNotifierProvider).player;
    if (state != null && state.current != null) {
      await player.play(urlSourceFromBytes(state.current!.value.bytes));
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(playerNotifierProvider).player;

    final int currentMin =
        Duration(seconds: _position?.inSeconds ?? 0).inMinutes.remainder(60);
    final int currentSec =
        Duration(seconds: _position?.inSeconds ?? 0).inSeconds.remainder(60);

    final int min =
        Duration(seconds: _duration?.inSeconds ?? 0).inMinutes.remainder(60);
    final int sec =
        Duration(seconds: _duration?.inSeconds ?? 0).inSeconds.remainder(60);

    final state = ref.read(playerNotifierProvider).player;
    return state == null
        ? const SizedBox()
        : Container(
            width: double.infinity,
            height: 150,
            color: Colors.blueAccent,
            child: Column(children: [
              Text('${state.current?.value.name}'),
              Text('${padDateTimeWithZero(currentMin.toString())}:'
                  '${padDateTimeWithZero(currentSec.toString())} /'
                  ' ${padDateTimeWithZero(min.toString())}:'
                  '${padDateTimeWithZero(sec.toString())}'),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        await player.play(
                            urlSourceFromBytes(state.current!.value.bytes));
                      },
                      icon: const Icon(Icons.play_circle)),
                  if (_isPlaying)
                    IconButton(
                        onPressed: () {
                          _pause();
                        },
                        icon: const Icon(Icons.pause))
                  else
                    const SizedBox(),
                  if (_isPlaying)
                    IconButton(
                        onPressed: () {
                          _stop();
                        },
                        icon: const Icon(Icons.stop))
                  else
                    const SizedBox()
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        previousTrack();
                      },
                      icon: const Icon(Icons.skip_previous)),
                  IconButton(
                      onPressed: () {
                        nextTrack();
                      },
                      icon: const Icon(Icons.skip_next)),
                  Slider(
                    value: valuePlayer,
                    onChanged: (double value) {
                      setState(() {
                        valuePlayer = value;
                        player.setVolume(valuePlayer);
                      });
                    },
                  ),
                ],
              ),
            ]));
  }

  void nextTrack() {
    ref.read(playerNotifierProvider.notifier).nextTrack();
    startCurrentPlayer();
  }

  void previousTrack() {
    ref.read(playerNotifierProvider.notifier).previousTrack();
    startCurrentPlayer();
  }
}
