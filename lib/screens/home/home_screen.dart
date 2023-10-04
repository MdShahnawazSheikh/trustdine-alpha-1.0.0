import 'package:flutter/material.dart';
import 'package:trustdine/components/app_bar.dart';
import 'package:trustdine/components/custom_modal_sheet.dart';
import 'package:trustdine/components/image_carousel.dart';
import 'package:trustdine/components/product_info_medium_card.dart';
import 'package:trustdine/components/section_title.dart';
import 'package:trustdine/constants.dart';
import 'package:trustdine/demoData.dart';

class HomeScreen extends StatefulWidget {
  final double logoWidth;
  const HomeScreen({Key? key, required this.logoWidth}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double cardHeight = screenHeight / 3;
    double logoWidth = screenWidth / 3;
    if (screenWidth > screenHeight) {
      logoWidth = screenHeight / 3;
      cardHeight = screenWidth / 2.5;
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(logoWidth: widget.logoWidth),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            sliver: SliverToBoxAdapter(
              child: ImageCarousel(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(defaultPadding),
            sliver: SliverToBoxAdapter(
              child: SectionTitle(
                  buttonText: "See All",
                  title: "Featured Products",
                  /* press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeaturedPage(),
                      ));
                }, */
                  press: () => CustomModalSheet(
                      context,
                      screenHeight,
                      screenWidth,
                      cardHeight,
                      "Featured Products",
                      featuredProducts)),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: const EdgeInsets.only(
                        left: defaultPadding / 1.2, right: 10),
                    child: ProductInfoMediumCard(
                      productName: featuredProducts[index]['name'],
                      image: featuredProducts[index]['image'],
                      press: () {},
                      rating: featuredProducts[index]['rating'],
                      size: featuredProducts[index]['size'],
                      price: featuredProducts[index]['price'],
                      category: featuredProducts[index]['category'],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
                top: defaultPadding,
                right: defaultPadding,
                left: defaultPadding),
            sliver: SliverToBoxAdapter(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/images/Banner_2.png",
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(defaultPadding),
            sliver: SliverToBoxAdapter(
              child: SectionTitle(
                  buttonText: "See All",
                  title: "Pizza Spotlight",
                  press: () {
                    CustomModalSheet(context, screenHeight, screenWidth,
                        cardHeight, "Pizza Spotlight", demoPizzaData);
                  }),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: const EdgeInsets.only(
                        left: defaultPadding / 1.2, right: 10),
                    child: ProductInfoMediumCard(
                      productName: demoPizzaData[index]['name'],
                      image: demoPizzaData[index]['image'],
                      press: () {},
                      rating: demoPizzaData[index]['rating'],
                      size: demoPizzaData[index]['size'],
                      price: demoPizzaData[index]['price'],
                      category: demoPizzaData[index]['category'],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
