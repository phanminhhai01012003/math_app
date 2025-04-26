import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';

class DotImages extends StatelessWidget {
  final List<String> dotImages;
  const DotImages({super.key, required this.dotImages});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CommonConstants.lightYellow,
          borderRadius: BorderRadius.circular(14),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          shrinkWrap: true,
          itemCount: dotImages.length,
          itemBuilder: (context, index) {
            return Image.asset(dotImages[index],
              fit: BoxFit.cover,
              width: 37,
              height: 37,
            );
          },
        )
      ),
    );
  }
}