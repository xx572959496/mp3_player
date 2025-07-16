import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler {
  final AudioPlayer player = AudioPlayer();

  MyAudioHandler() {
    // 同步播放器状态到 AudioService
    player.playerStateStream.listen((playerState) {
      final playing = playerState.playing;
      final processingState = playerState.processingState;

      // 映射 processingState
      AudioProcessingState audioState;
      switch (processingState) {
        case ProcessingState.idle:
          audioState = AudioProcessingState.idle;
          break;
        case ProcessingState.loading:
          audioState = AudioProcessingState.loading;
          break;
        case ProcessingState.buffering:
          audioState = AudioProcessingState.buffering;
          break;
        case ProcessingState.ready:
          audioState = AudioProcessingState.ready;
          break;
        case ProcessingState.completed:
          audioState = AudioProcessingState.completed;
          break;
      }

      playbackState.add(
        PlaybackState(
          controls: [
            MediaControl.skipToPrevious,
            playing ? MediaControl.pause : MediaControl.play,
            MediaControl.skipToNext,
          ],
          androidCompactActionIndices: const [0, 1, 2],
          playing: playing,
          processingState: audioState
        ),
      );
    });
  }

  @override
  Future<void> play() => player.play();

  @override
  Future<void> pause() => player.pause();

  @override
  Future<void> stop() => player.stop();

  @override
  Future<void> skipToNext() async {
    // TODO: 添加你的切歌逻辑
  }

  @override
  Future<void> skipToPrevious() async {
    // TODO: 添加你的切歌逻辑
  }

  Future<void> playAudio(String url, {String? title, required String artUri}) async {
    try {
      await player.setUrl(url); // ⚠️ 必须 await，否则 play 会出错
      mediaItem.add(
        MediaItem(
          id: url,
          title: title ?? '未知歌曲',
          artist: '直播',
          album: '未知专辑',
          artUri: Uri.parse(artUri),
          duration: player.duration, // 更准确
        ),
      );
      await player.play();
    } catch (e) {
      print("播放网络音频失败: $e");
    }
  }

  Future<void> playLocalAudio(String assetPath, {String? title}) async {
    try {
      print("尝试播放：$assetPath");
      await player.setAsset(assetPath);
      mediaItem.add(MediaItem(
        id: assetPath,
        title: title ?? '未知歌曲',
        artist: '未知艺术家',
        album: '未知专辑',
        duration: player.duration,
      ));
      await player.play();
    } catch (e) {
      print("播放本地音频失败: $e");
    }
  }

}
