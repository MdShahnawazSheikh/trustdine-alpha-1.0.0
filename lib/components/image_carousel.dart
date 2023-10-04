import 'package:flutter/material.dart';
import 'package:trustdine/constants.dart';
import 'package:trustdine/demoData.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({
    super.key,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.81,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: demoBigImages.length,
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                demoBigImages[index],
              ),
            ),
          ),
          Positioned(
            bottom: defaultPadding,
            right: defaultPadding,
            child: Row(
                children: List.generate(
                    demoBigImages.length,
                    (index) => Padding(
                          padding:
                              const EdgeInsets.only(left: defaultPadding / 4),
                          child: IndicatorDot(isActive: index == _currentPage),
                        ))),
          )
        ],
      ),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  const IndicatorDot({
    required this.isActive,
    super.key,
  });
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white38,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
