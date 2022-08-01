import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail_generator/video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    final assetPath = context.read<VideoPlayerCubit>().state.videoPath;
    _controller = VideoPlayerController.file(
      File(assetPath!),
    );
  }

  Future<void> _playVideo() async {
    await _controller.initialize();
    await _controller.setLooping(true);
    await _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await context.read<VideoPlayerCubit>().playerPagePopped();
        return true;
      },
      child: Scaffold(
        body: Center(
          child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
            builder: (context, state) {
              if (state.thumbnail != null) {
                if (!state.isPlaying) {
                  return GestureDetector(
                      onTap: () async {
                        context.read<VideoPlayerCubit>().playVideo();
                        await _playVideo();
                      },
                      child: Image.memory(state.thumbnail!));
                }

                return VideoPlayer(_controller);
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
