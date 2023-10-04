import 'package:flutter/material.dart';
import 'package:trustdine/components/ProductCardTwoRow.dart';
import 'package:trustdine/components/app_bar.dart';
import 'package:trustdine/components/product_info_medium_card.dart';
import 'package:trustdine/components/section_title.dart';
import 'package:trustdine/constants.dart';
import 'package:trustdine/demoData.dart';

class PizzaPage extends StatefulWidget {
  final double logoWidth;
  const PizzaPage({super.key, required this.logoWidth});

  @override
  State<PizzaPage> createState() => _PizzaPageState();
}

class _PizzaPageState extends State<PizzaPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double cardHeight = screenHeight / 3;
    if (screenWidth > screenHeight) {
      cardHeight = screenWidth / 2.5;
    }
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        CustomSliverAppBar(logoWidth: widget.logoWidth),
        SliverPadding(
          padding: const EdgeInsets.all(defaultPadding),
          sliver: SliverToBoxAdapter(
            child: SectionTitle(
              buttonText: "See All",
              title: "Veg Pizza",
              press: () {},
            ),
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
        SliverPadding(
          padding: const EdgeInsets.all(defaultPadding),
          sliver: SliverToBoxAdapter(
            child: SectionTitle(
              buttonText: "See All",
              title: "Non-Veg Pizza",
              press: () {},
            ),
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
        const SliverPadding(
          padding: EdgeInsets.only(
              top: defaultPadding + 30,
              left: defaultPadding,
              right: defaultPadding),
          sliver: SliverToBoxAdapter(
            child: SectionTitleNoButton(title: "Browse All Pizza"),
          ),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 1.2),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: demoPizzaData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: screenHeight > screenWidth ? 250 : cardHeight,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ProductCardTwoRow(
                      onPress: () {},
                      image: demoPizzaData[index]['image'],
                      name: demoPizzaData[index]['name'],
                      category: demoPizzaData[index]['category'],
                      size: demoPizzaData[index]['size'],
                      price: demoPizzaData[index]['price'],
                      rating: demoPizzaData[index]['rating']);
                },
              ),
            ),
          ),
        )
      ],
    ));
  }
}
