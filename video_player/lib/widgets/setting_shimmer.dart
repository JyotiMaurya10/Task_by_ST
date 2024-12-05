import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SettingShimmer extends StatelessWidget {
  final int count;
  const SettingShimmer({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 30,
        runSpacing: 40,
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        children: List.generate(count, (index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 142,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          );
        }),
      ),
    );
  }
}
