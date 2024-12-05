
import 'package:video_player/controllers/setting_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/controllers/home_controller.dart';
import 'package:video_player/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String title;
  final String videoUrl;

  const VideoPlayerWidget({
    super.key,
    required this.title,
    required this.videoUrl,
  });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late YoutubePlayerController youtubeController;
  late SettingController settingController;
  late HomeController homeController;
  @override
  void initState() {
    super.initState();
    settingController = Get.find();
    homeController = Get.find();

    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;
    youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        loop: true,
        enableCaption: false,
      ),
    );
    homeController.setVideoController(youtubeController, settingController.selectedIndex);
  }

  @override
  void dispose() {
    youtubeController.removeListener(() {});
    youtubeController.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    if (youtubeController.value.isPlaying) {
      youtubeController.pause();
    } else {
      youtubeController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = Get.height;
    final screenWidth = Get.width;
    final videoWidth = screenHeight * 9 / 16;

    return GestureDetector(
      onTap: togglePlayPause,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: screenHeight,
            width: videoWidth > screenWidth ? screenWidth : videoWidth,
            child: YoutubePlayer(
              controller: youtubeController,
              progressIndicatorColor: Colors.red,
              progressColors: const ProgressBarColors(
                playedColor: pinkColor,
                bufferedColor: Colors.white,
                handleColor: pinkColor,
                backgroundColor: greyColor,
              ),
              showVideoProgressIndicator: true,
              aspectRatio: 9 / 16,
            ),
          ),
          Positioned(
            bottom: 44,
            left: 12,
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
