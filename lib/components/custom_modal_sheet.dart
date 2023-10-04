import 'package:flutter/material.dart';
import 'package:trustdine/components/ProductCardTwoRow.dart';

Future<dynamic> CustomModalSheet(
  BuildContext context,
  double screenHeight,
  double screenWidth,
  double cardHeight,
  String sheetTitle,
  List<Map<String, dynamic>> yourData,
) {
  return showModalBottomSheet(
    enableDrag: true,
    // barrierLabel: text,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    )),
    isDismissible: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(
          // top: 20,
          right: 8,
          left: 8,
        ),
        child: SizedBox(
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  sheetTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 15,
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: yourData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent:
                        screenHeight > screenWidth ? 250 : cardHeight,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCardTwoRow(
                        onPress: () {},
                        image: yourData[index]['image'],
                        name: yourData[index]['name'],
                        category: yourData[index]['category'],
                        size: yourData[index]['size'],
                        price: yourData[index]['price'],
                        rating: yourData[index]['rating']);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
