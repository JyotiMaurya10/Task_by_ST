import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var videos = <Map<String, String>>[].obs;
  var currentIndex = 0.obs;
  YoutubePlayerController? youtubeController;
  bool isFirstTime = true;

  @override
  void onInit() {
    super.onInit();
    fetchVideos();
  }

  void setVideoController(YoutubePlayerController controller, RxInt indexOfTab) {
    youtubeController = controller;
    youtubeController!.addListener(() {
      if (isFirstTime && youtubeController!.value.isReady) {
        youtubeController!.pause();
      }
    });
    ever(indexOfTab, (index) {
      if (index != 2 && youtubeController != null) {
        youtubeController!.pause();
      } else if (index == 2 && youtubeController != null) {
        youtubeController!.play();
        isFirstTime = false;
      }
    });
  }

  Future<void> fetchVideos() async {
    try {
      final snapshot = await firestore.collection('video_links').get();
      videos.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'title': data['title']?.toString() ?? '',
          'link': data['link']?.toString() ?? '',
        };
      }).toList();
    } catch (e) {
      debugPrint('Error fetching videos: $e');
    }
  }
}
