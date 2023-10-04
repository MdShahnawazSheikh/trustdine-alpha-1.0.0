import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final double logoWidth;

  const CustomSliverAppBar({super.key, required this.logoWidth});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      elevation: 0,
      floating: true,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Image.asset(
          'assets/trustdine_logo.png',
          width: logoWidth,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
