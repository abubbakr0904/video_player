//import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:flutter/material.dart';
//
// class VideoScreen extends StatefulWidget {
//   const VideoScreen({super.key});
//
//   @override
//   State<VideoScreen> createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//   late VideoPlayerController videoPlayerController;
//   late CustomVideoPlayerController _customVideoPlayerController;
//
//   String videoUrl = "assets/video/hihi.MP4";
//   List<String> speedOptions = ["0.5x", "1.0x", "1.5x", "2.0x"];
//   String selectedSpeed = "1.0x";
//
//   @override
//   void initState() {
//     super.initState();
//     videoPlayerController = VideoPlayerController.asset(videoUrl)
//       ..initialize().then((_) => setState(() {}));
//     _customVideoPlayerController = CustomVideoPlayerController(
//       context: context,
//       videoPlayerController: videoPlayerController,
//       customVideoPlayerSettings: CustomVideoPlayerSettings(
//         settingsButtonAvailable: false,
//         controlBarDecoration: const BoxDecoration(
//           color: Colors.transparent,
//         ),
//         enterFullscreenButton: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             DropdownButton<String>(
//               value: selectedSpeed,
//               dropdownColor: Colors.black54,
//               style: const TextStyle(color: Colors.white),
//               items: speedOptions
//                   .map((speed) => DropdownMenuItem<String>(
//                 value: speed,
//                 child: Text(speed),
//               ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedSpeed = value!;
//                   _changePlaybackSpeed(selectedSpeed);
//                 });
//               },
//             ),
//             const SizedBox(width: 16),
//             GestureDetector(
//               child: const Icon(
//                 Icons.fullscreen,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         exitFullscreenButton: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             DropdownButton<String>(
//               value: selectedSpeed,
//               dropdownColor: Colors.black54,
//               style: const TextStyle(color: Colors.white),
//               items: speedOptions
//                   .map((speed) => DropdownMenuItem<String>(
//                 value: speed,
//                 child: Text(speed),
//               ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedSpeed = value!;
//                   _changePlaybackSpeed(selectedSpeed);
//                 });
//               },
//             ),
//             const SizedBox(width: 16),
//             GestureDetector(
//               child: const Icon(
//                 Icons.fullscreen,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _changePlaybackSpeed(String speed) {
//     double playbackSpeed = double.tryParse(speed.replaceAll('x', '')) ?? 1.0;
//     videoPlayerController.setPlaybackSpeed(playbackSpeed);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Video Player"),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: CustomVideoPlayer(
//                 customVideoPlayerController: _customVideoPlayerController,
//               ),
//             ),
//             Center(
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     if (videoPlayerController.value.isPlaying) {
//                       videoPlayerController.pause();
//                     } else {
//                       videoPlayerController.play();
//                     }
//                   });
//                 },
//                 child: Container(
//                   color: Colors.black26,
//                   child: Icon(
//                     videoPlayerController.value.isPlaying
//                         ? Icons.pause
//                         : Icons.play_arrow,
//                     size: 80,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late FlickManager flickManager;
  String selectedSpeed = "1.0x";
  List<String> speedOptions = ["0.5x", "1.0x", "1.5x", "2.0x"];

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      autoPlay: false,
      autoInitialize: true,
      videoPlayerController: VideoPlayerController.asset("assets/video/hihi.MP4"),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 200),
          FlickVideoPlayer(
            flickManager: flickManager,
            flickVideoWithControls: FlickVideoWithControls(
              controls: FlickPortraitControls(
                progressBarSettings: FlickProgressBarSettings(
                  playedColor: Colors.red, // Play barning qizil rangi
                  handleColor: Colors.red, // Tugmaning qizil rangi
                  bufferedColor: Colors.grey,
                  backgroundColor: Colors.black,
                  handleRadius: 5,
                ),
                // Add playback speed control

              ),
            ),
          ),
        ],
      ),
    );
  }
}
