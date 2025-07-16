import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';

import 'audio_handler.dart';

class PlayerWidget extends StatefulWidget {
  final MyAudioHandler audioHandler;

  const PlayerWidget({required this.audioHandler, super.key});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  late final AudioPlayer player;

  Duration? _duration;
  Duration _position = Duration.zero;
  late StreamSubscription<Duration?> _durationSub;
  late StreamSubscription<Duration> _positionSub;
  late StreamSubscription<PlayerState> _stateSub;

  bool get _isPlaying => player.playing;

  PlayerState get _state => player.playerState;

  String get _durationText => _duration?.toString().split('.').first ?? '';

  String get _positionText => _position.toString().split('.').first;

  late StreamSubscription<MediaItem?> _mediaItemSub;
  MediaItem? _mediaItem;

  @override
  void initState() {
    super.initState();
    player = widget.audioHandler.player;

    // 订阅时长
    _durationSub = player.durationStream.listen((d) {
      setState(() => _duration = d);
    });

    // 订阅位置
    _positionSub = player.positionStream.listen((p) {
      setState(() => _position = p);
    });

    // 订阅状态（播放完成、缓冲等）
    _stateSub = player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        player.seek(Duration.zero);
        player.pause();
      }
      setState(() {}); // 仅用于刷新图标
    });
    _mediaItemSub = widget.audioHandler.mediaItem.listen((item) {
      setState(() => _mediaItem = item);
    });
  }

  @override
  void dispose() {
    _durationSub.cancel();
    _positionSub.cancel();
    _stateSub.cancel();
    _mediaItemSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 控制行
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // IconButton(
              //   iconSize: 32,
              //   color: color,
              //   icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              //   onPressed: _isPlaying ? _pause : _play,
              // ),
              // IconButton(
              //   iconSize: 40,
              //   color: color,
              //   icon: const Icon(Icons.stop),
              //   onPressed: (_position > Duration.zero || _isPlaying)
              //       ? _stop
              //       : null,
              // ),
              Expanded(
                  child: Center(heightFactor:2,child: Text(_mediaItem?.title ?? "未播放"))),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildArtImage(MediaItem? mediaItem) {
    final artUri = mediaItem?.artUri?.toString();
    print(artUri);
    Widget image;
    if (artUri == null || artUri.isEmpty) {
      image = const Icon(Icons.music_note, size: 32);
    }
    if (artUri!.startsWith('http')) {
      image = Image.network(artUri, height: 32, width: 32, fit: BoxFit.cover);
    } else if (artUri.startsWith('file://')) {
      image = Image.file(File(Uri.parse(artUri).path), height: 32, width: 32);
    } else {
      image = Image.asset(artUri, height: 32, width: 32);
    }
    return ClipRRect(borderRadius: BorderRadius.circular(4), child: image);
  }

  Future<void> _play() async => player.play();

  Future<void> _pause() async => player.pause();

  Future<void> _stop() async {
    await player.stop();
    await player.seek(Duration.zero);
  }
}
