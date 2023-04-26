// ignore_for_file: non_constant_identifier_names

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlaySiren extends StatefulWidget {
  const PlaySiren({super.key});

  @override
  State<PlaySiren> createState() => _PlaySirenState();
}

class _PlaySirenState extends State<PlaySiren> {
  bool isPlaying = false;
  IconData playBtn = Icons.play_arrow;
  double value = 0;
  final _player = AudioPlayer();
  Duration? duration = const Duration();

  void initPlayer() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setSource(AssetSource('siren.mp3'));
    duration = await _player.getDuration();
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  showModelFalseAlarm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    const Text("PLAY A FALSE ALARM!!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${(value / 60).floor()}: ${(value % 60).floor()}",
                          style: const TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 260,
                          child: Slider.adaptive(
                            onChangeEnd: (new_value) async {
                              setState(() {
                                value = new_value;
                                // print(new_value);
                              });
                              await _player
                                  .seek(Duration(seconds: new_value.toInt()));
                            },
                            min: 0.0,
                            value: value,
                            max: 1.0,
                            onChanged: (value) {},
                            activeColor: Colors.white,
                          ),
                        ),
                        Text(
                          '${duration!.inMinutes}:${duration!.inSeconds % 60}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60.0),
                            color: Colors.purple,
                            border: Border.all(color: Colors.purple),
                          ),
                          width: 50.0,
                          height: 50.0,
                          child: InkWell(
                            onTapDown: (details) {
                              _player.setPlaybackRate(0.25);
                            },
                            onTapUp: (details) {
                              _player.setPlaybackRate(0.5);
                            },
                            child: const Center(
                              child: Icon(
                                Icons.fast_rewind_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60.0),
                            color: Colors.purple,
                            border: Border.all(color: Colors.purple),
                          ),
                          width: 60.0,
                          height: 60.0,
                          child: IconButton(
                            onPressed: () async {
                              //setting the play function

                              //             ),
                              if (!isPlaying) {
                                await _player.resume();
                                _player.onPositionChanged.listen(
                                  (Duration d) {
                                    setState(() {
                                      value = d.inSeconds.toDouble();
                                      playBtn = Icons.pause;
                                      isPlaying = true;
                                      // print(value);
                                    });
                                  },
                                );
                                // print(duration);
                              } else {
                                _player.pause();

                                setState(() {
                                  playBtn = Icons.play_arrow;
                                  isPlaying = false;
                                });
                              }
                            },
                            icon: Icon(
                              playBtn,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60.0),
                            color: Colors.purple,
                            border: Border.all(color: Colors.purple),
                          ),
                          width: 50.0,
                          height: 50.0,
                          child: InkWell(
                            onTapDown: (details) {
                              _player.setPlaybackRate(1.25);
                            },
                            onTapUp: (details) {
                              _player.setPlaybackRate(0.75);
                            },
                            child: const Center(
                              child: Icon(
                                Icons.fast_forward_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModelFalseAlarm(context),
      child: Card(
          color: Theme.of(context).colorScheme.background,
          child: Row(children: [
            Expanded(
                child: Column(
              children: const [
                ListTile(
                  title: Text("Play Siren"),
                  subtitle: Text("Fake Alarm"),
                ),
              ],
            )),
          ])),
    );
  }
}