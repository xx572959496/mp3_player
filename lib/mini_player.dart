import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import 'audio_handler.dart';

class MiniPlayer extends StatefulWidget {
  final MyAudioHandler audioHandler;
  final VoidCallback? onTap; // 点击进入详情页

  const MiniPlayer({super.key, required this.audioHandler, this.onTap});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> with TickerProviderStateMixin {
  late final AudioPlayer _player;
  late final Stream<MediaItem?> _mediaStream;

  @override
  void initState() {
    super.initState();
    _player = widget.audioHandler.player;
    _mediaStream = widget.audioHandler.mediaItem;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: _mediaStream,
      builder: (context, mediaSnap) {
        final item = mediaSnap.data;
        // 未播放时隐藏
        if (item == null) return const SizedBox.shrink();
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            elevation: 4,
            color: Theme.of(context).colorScheme.surface,
            child: InkWell(
              onTap: widget.onTap,
              child: SizedBox(
                height: 64,
                child: Row(
                  children: [
                    // 封面
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          item.artUri?.toString() ?? '',
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.music_note, size: 48),
                        ),
                      ),
                    ),
                    // 标题 & 副标题
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.artist ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 播放 / 暂停
                    StreamBuilder<bool>(
                      stream: _player.playingStream,
                      builder: (context, snap) {
                        final playing = snap.data ?? false;
                        return IconButton(
                          iconSize: 36,
                          icon: Icon(
                            playing ? Icons.pause : Icons.play_arrow_outlined,
                          ),
                          onPressed:
                          playing ? widget.audioHandler.pause : widget.audioHandler.play,
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
