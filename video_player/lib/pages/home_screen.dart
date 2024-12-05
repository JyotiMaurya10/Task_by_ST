import 'package:video_player/widgets/video_player_widget.dart';
import 'package:video_player/controllers/home_controller.dart';
import 'package:video_player/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: headingColor,
      body: SafeArea(
        child: Obx(() {
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: controller.videos.length,
            onPageChanged: (index) => controller.currentIndex.value = index,
            itemBuilder: (context, index) {
              final videoData = controller.videos[index];
              return VideoPlayerWidget(
                title: videoData['title']!,
                videoUrl: videoData['link']!,
              );
            },
          );
        }),
      ),
    );
  }
}
