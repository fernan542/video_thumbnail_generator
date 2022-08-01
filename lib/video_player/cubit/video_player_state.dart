part of 'video_player_cubit.dart';

enum EventStatus { loading, initial, success }

@immutable
class VideoPlayerState extends Equatable {
  final Uint8List? thumbnail;
  final String? videoPath;
  final bool isPlaying;

  const VideoPlayerState({
    this.thumbnail,
    this.videoPath,
    this.isPlaying = false,
  });

  @override
  String toString() {
    final s = {
      'thumbnail': thumbnail?.length,
      'videoPath': videoPath,
      'isPlaying': isPlaying,
    };
    return 'VideoPlayerState: $s';
  }

  @override
  List<Object?> get props => [
        thumbnail,
        videoPath,
        isPlaying,
      ];

  VideoPlayerState copyWith({
    Uint8List? Function()? thumbnail,
    String? Function()? videoPath,
    bool? isPlaying,
  }) {
    return VideoPlayerState(
      thumbnail: thumbnail != null ? thumbnail() : this.thumbnail,
      videoPath: videoPath != null ? videoPath() : this.videoPath,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
