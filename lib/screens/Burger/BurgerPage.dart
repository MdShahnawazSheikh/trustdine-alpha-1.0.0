import 'package:flutter/material.dart';
import 'package:trustdine/components/app_bar.dart';

class BurgerPage extends StatefulWidget {
  final double logoWidth;
  const BurgerPage({super.key, required this.logoWidth});

  @override
  State<BurgerPage> createState() => _BurgerPageState();
}

class _BurgerPageState extends State<BurgerPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomSliverAppBar(logoWidth: widget.logoWidth),
        const SliverToBoxAdapter(
          child: Center(
            child: Text("Burger Page"),
          ),
        ),
      ],
    );
  }
}
