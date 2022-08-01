import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_thumbnail_generator/video_player/video_player.dart';

class VideoUploadPage extends StatelessWidget {
  const VideoUploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Tap the upload a video story button to get started.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pickedFile = await FilePicker.platform.pickFiles();
          if (pickedFile == null) return;

          context.read<VideoPlayerCubit>().generateThumbnail(
                pickedFile.files.single.path!,
              );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VideoPlayerPage(),
            ),
          );
        },
        child: const Icon(Icons.upload),
      ),
    );
  }
}
