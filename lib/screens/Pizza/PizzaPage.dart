import 'package:flutter/material.dart';
import 'package:trustdine/backend/fetchfoods.dart';
import 'package:trustdine/components/NetworkProductCardTwoRow.dart';
import 'package:trustdine/components/ProductCardTwoRow.dart';
import 'package:trustdine/components/app_bar.dart';
import 'package:trustdine/components/network_product_info_medium_card.dart';
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

    try {
      return Scaffold(
          body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            logoWidth: widget.logoWidth,
          ),
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
                    child: NetworkProductInfoMediumCard(
                      productName: PizzaData[index]['name'],
                      image: PizzaData[index]['image'],
                      press: () {},
                      rating: PizzaData[index]['rating'],
                      size: PizzaData[index]['size'],
                      price: PizzaData[index]['price'],
                      category: PizzaData[index]['category'],
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
                    child: NetworkProductInfoMediumCard(
                      productName: PizzaData[index]['name'],
                      image: PizzaData[index]['image'],
                      press: () {},
                      rating: PizzaData[index]['rating'],
                      size: PizzaData[index]['size'],
                      price: PizzaData[index]['price'],
                      category: PizzaData[index]['category'],
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
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding / 1.2),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: PizzaData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent:
                        screenHeight > screenWidth ? 250 : cardHeight,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return NetworkProductCardTwoRow(
                        onPress: () {},
                        image: PizzaData[index]['image'],
                        name: PizzaData[index]['name'],
                        category: PizzaData[index]['category'],
                        size: PizzaData[index]['size'],
                        price: PizzaData[index]['price'],
                        rating: PizzaData[index]['rating']);
                  },
                ),
              ),
            ),
          )
        ],
      ));
    } on RangeError {
      return Scaffold(
        body: Center(
          child: Text(
            "Something went wrong!!!\nMake sure you are connected.",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
