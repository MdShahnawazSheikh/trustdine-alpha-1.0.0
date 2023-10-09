import 'package:flutter/material.dart';
import 'package:trustdine/backend/fetchfoods.dart';

class CustomSliverAppBar extends StatefulWidget {
  final double logoWidth;

  const CustomSliverAppBar({super.key, required this.logoWidth});

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      elevation: 0,
      floating: true,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: GestureDetector(
          onDoubleTap: () {
            setState(() {
              refreshData();
            });
            print("Data Refreshed");
          },
          child: Image.asset(
            'assets/trustdine_logo.png',
            width: widget.logoWidth,
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
