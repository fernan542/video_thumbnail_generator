import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(const VideoPlayerState());

  Future<void> generateThumbnail(String path) async {
    emit(
      state.copyWith(
        videoPath: () => path,
      ),
    );
    try {
      final rawStringUint8List = await VideoThumbnail.thumbnailFile(
        video: path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 500,
        quality: 100,
      );
      if (rawStringUint8List == null) return;

      final file = File(rawStringUint8List);
      final bytes = file.readAsBytesSync();

      emit(
        state.copyWith(
          thumbnail: () => bytes,
        ),
      );
    } catch (e) {
      dev.log('$e');
    }
  }

  Future<void> playerPagePopped() async {
    emit(
      state.copyWith(
        thumbnail: () => null,
        videoPath: () => null,
        isPlaying: false,
      ),
    );
  }

  void playVideo() => emit(state.copyWith(isPlaying: true));
}
