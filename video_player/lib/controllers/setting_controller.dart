import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var languages = <Map<String, String>>[].obs;
  var selectedLanguages = 0.obs;
  var colors = <Map<String, String>>[].obs;
  var selectedColor = 4.obs;
  RxBool languageLoading = false.obs;
  RxBool colorLoading = false.obs;
  final defaultBackgroundColor = const Color(0xFFF5F5DC);
  var bottomNavItems = <Map<String, String>>[].obs;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBottomNavItems();
    fetchLanguages();
    fetchColors();
  }

Color get selectedBackgroundColor {
    if (colors.isEmpty) {
      return defaultBackgroundColor;
    }
    return getColor(colors[selectedColor.value]['label'] ?? "");
  }

  Color getColor(String label) {
    switch (label) {
      case 'Beige (default)':
        return const Color(0xFFF5F5DC);
      case 'Sea Green':
        return const Color.fromARGB(255, 27, 216, 109);
      case 'Hot Pink':
        return const Color(0xFFFF69B4);
      case 'Lavender':
        return const Color(0xFFE6E6FA);
      case 'Lemon Yellow':
        return const Color(0xFFFFF700);
      default:
        return const Color(0xFF808080);
    }
  }

  Future<void> fetchBottomNavItems() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('bottom_tray_options').get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;

        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data.forEach((key, value) {
            bottomNavItems.add({'label': value});
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching bottom nav items: $e');
    }
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchLanguages() async {
    try {
      languageLoading.value = true;
      QuerySnapshot querySnapshot = await firestore.collection('language_options').get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;

        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data.forEach((key, value) {
            languages.add({'label': value});
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching bottom nav items: $e');
    } finally {
      languageLoading.value = false;
    }
  }

  Future<void> fetchColors() async {
    try {
      colorLoading.value = true;
      QuerySnapshot querySnapshot = await firestore.collection('color_options').get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data.forEach((key, value) {
            colors.add({'label': value});
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching bottom nav items: $e');
    } finally {
      colorLoading.value = false;
    }
  }
}
