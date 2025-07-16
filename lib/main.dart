import 'package:flutter/material.dart';
import 'package:mp3_player/data/categories.dart' hide Data;
import 'package:audio_service/audio_service.dart';
import 'package:mp3_player/theme/theme.dart';
import 'audio_handler.dart';
import 'package:window_manager/window_manager.dart';
import 'package:dio/dio.dart';

import 'data/channels.dart' hide Categories;
import 'mini_player.dart';

late MyAudioHandler _audioHandler;

void main() async {
  _audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.example.music.channel.audio',
      androidNotificationChannelName: 'Music Playback',
      androidNotificationOngoing: true,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  // 必须加上这一行。
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(600, 800),
    minimumSize: Size(300, 400),
    fullScreen: false,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        colorScheme: MaterialTheme.lightScheme(),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<RegionsMap>? regionsList = [];

  List<Data> channelsList = [];
  int _selectedLeftIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  void _getCategories() async {
    Dio dio = Dio();
    Response response = await dio.get("https://rapi.qingting.fm/categories");
    Categories categories = Categories.fromJson(response.data);
    regionsList = categories.data?.regionsMap;
    num id = regionsList?[_selectedLeftIndex].id ?? 7;
    // https://rapi.qingting.fm/categories/7/channels?&page=1&pagesize=300
    Response res = await dio.get(
      "https://rapi.qingting.fm/categories/$id/channels?&page=1&pagesize=100",
    );
    Channels channels = Channels.fromJson(res.data);
    channelsList = channels.data ?? [];
    setState(() {});
  }

  void _getChannels(int index) async {
    Dio dio = Dio();
    num? id = regionsList?[index].id;
    Response res = await dio.get(
      "https://rapi.qingting.fm/categories/$id/channels?&page=1&pagesize=100",
    );
    Channels channels = Channels.fromJson(res.data);
    channelsList = channels.data ?? [];
    setState(() {
      _selectedLeftIndex = index;
    });
  }

  void _playChannel(Data data) {
    _audioHandler.playAudio(
      "https://lhttp.qingting.fm/live/${data.contentId}/64k.mp3",
      title: data.title,
      artUri: data.cover ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("收音机 📻"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // PlayerWidget(audioHandler: _audioHandler),
            Expanded(
              child: Row(
                children: [
                  // 左侧列表
                  SizedBox(
                    width: 100,
                    child: ListView.builder(
                      itemCount: regionsList?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(regionsList?[index].title ?? ""),
                          selected: _selectedLeftIndex == index,
                          tileColor: _selectedLeftIndex == index
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : Theme.of(context).colorScheme.primaryContainer,
                          onTap: () {
                            _getChannels(index);
                          },
                        );
                      },
                    ),
                  ),
                  // 右侧列表
                  Expanded(
                    child: ListView.builder(
                      itemCount: channelsList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(channelsList[index].title ?? ""),
                          subtitle: Text(
                            "正在播放：${channelsList[index].nowplaying?.title ?? ""}",
                          ),
                          // leading: channelsList[index].cover != null ? Image.network(channelsList[index].cover!) : Icon(Icons.radio) ,
                          // leading: channelsList[index].cover != null ? Image.network(channelsList[index].cover!) : Icon(Icons.radio) ,
                          onTap: () {
                            _playChannel(channelsList[index]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            MiniPlayer(
              audioHandler: _audioHandler,
              onTap: () {
                // TODO: push 到全屏播放页
              },
            ),
          ],
        ),
      ),

      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: <Widget>[
      //     // PlayerWidget(audioHandler: _audioHandler),
      //     Expanded(
      //       child: Row(
      //         children: [
      //           // 左侧列表
      //           SizedBox(
      //             width: 100,
      //             child: ListView.builder(
      //               itemCount: regionsList?.length,
      //               itemBuilder: (context, index) {
      //                 return ListTile(
      //                   title: Text(regionsList?[index].title ?? ""),
      //                   selected: _selectedLeftIndex == index,
      //                   selectedTileColor: Colors.white,
      //                   tileColor: _selectedLeftIndex == index
      //                       ? Colors.white
      //                       : Colors.grey[300],
      //                   onTap: () {
      //                     _getChannels(index);
      //                   },
      //                 );
      //               },
      //             ),
      //           ),
      //           // 右侧列表
      //           Expanded(
      //             child: ListView.builder(
      //               itemCount: channelsList.length,
      //               itemBuilder: (context, index) {
      //                 return ListTile(
      //                   title: Text(channelsList[index].title ?? ""),
      //                   subtitle: Text(
      //                     "正在播放：${channelsList[index].nowplaying?.title ?? ""}",
      //                   ),
      //                   // leading: channelsList[index].cover != null ? Image.network(channelsList[index].cover!) : Icon(Icons.radio) ,
      //                   // leading: channelsList[index].cover != null ? Image.network(channelsList[index].cover!) : Icon(Icons.radio) ,
      //                   onTap: () {
      //                     _playChannel(channelsList[index]);
      //                   },
      //                 );
      //               },
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     /// Mini‑Player 悬浮到底部
      //     MiniPlayer(
      //       audioHandler: _audioHandler,
      //       onTap: () {
      //         // TODO: push 到全屏播放页
      //       },
      //     ),
      //   ],
      // ),

      // floatingActionButton: StreamBuilder<MediaItem?>(
      //   stream: _audioHandler.mediaItem,
      //   builder: (context, mediaSnapshot) {
      //     final mediaItem = mediaSnapshot.data;
      //     if (mediaItem == null) return const SizedBox.shrink();
      //
      //     return StreamBuilder<bool>(
      //       stream: _audioHandler.player.playingStream,
      //       builder: (context, playingSnapshot) {
      //         final isPlaying = playingSnapshot.data ?? false;
      //
      //         // 如果正在播放，展示封面+标题
      //         if (isPlaying && mediaItem.artUri != null) {
      //           return FloatingActionButton.extended(
      //             backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      //             onPressed: _audioHandler.pause,
      //             icon: const Icon(Icons.pause),
      //             label: Row(
      //               children: [
      //                 ClipRRect(
      //                   borderRadius: BorderRadius.circular(4),
      //                   child: Image.network(
      //                     mediaItem.artUri.toString(),
      //                     height: 32,
      //                     width: 32,
      //                     errorBuilder: (context, error, stackTrace) =>
      //                         const Icon(Icons.music_note, size: 32),
      //                   ),
      //                 ),
      //                 const SizedBox(width: 8),
      //                 Text(
      //                   mediaItem.title,
      //                   style: const TextStyle(fontSize: 14),
      //                 ),
      //               ],
      //             ),
      //           );
      //         } else {
      //           // 未播放 或 无封面，仅显示按钮居中图标
      //           return FloatingActionButton(
      //             backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      //             onPressed: _audioHandler.play,
      //             child: const Icon(Icons.play_arrow),
      //           );
      //         }
      //       },
      //     );
      //   },
      // ),
    );
  }
}
