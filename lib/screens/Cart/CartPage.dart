import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trustdine/backend/cartManager.dart';
import 'package:trustdine/components/app_bar.dart';
import 'package:trustdine/components/cart_card.dart';
import 'package:trustdine/components/section_title.dart';
import 'package:trustdine/constants.dart';

class CartPage extends StatefulWidget {
  final double logoWidth;
  const CartPage({super.key, required this.logoWidth});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double imgSize =
        screenHeight > screenWidth ? (screenWidth / 4) : (screenHeight / 4);
    return Scaffold(
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          CustomSliverAppBar(logoWidth: widget.logoWidth),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            sliver: SliverToBoxAdapter(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  title: "Your Cart",
                  buttonText: "Checkout",
                  press: () {},
                ),
                Text(
                  "Grand Total: ₹ ${CartManager().calculateTotalPrice().toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
          ),
          /* SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            sliver: SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: screenHeight,
                  child: ListView.builder(
                    itemCount: CartManager().addedProducts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: cartCard(
                          imgSize: imgSize,
                          image: CartManager().addedProducts[index].imagePath,
                          title: CartManager().addedProducts[index].productName,
                          price: CartManager().addedProducts[index].price,
                          quantity: CartManager().addedProducts[index].quantity,
                          size: CartManager().addedProducts[index].size,
                          screenWidth: screenWidth,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ), */
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      right: defaultPadding, left: defaultPadding, bottom: 6.0),
                  child: cartCard(
                    imgSize: imgSize,
                    image: CartManager().addedProducts[index].imagePath,
                    title: CartManager().addedProducts[index].productName,
                    price: CartManager().addedProducts[index].price,
                    quantity: CartManager().addedProducts[index].quantity,
                    size: CartManager().addedProducts[index].size,
                    screenWidth: screenWidth,
                    decreaseButton: () {
                      _deductItem(index, setState);
                    },
                    deleteButton: () {
                      // Pass setState to trigger a rebuild
                      _removeProduct(index, setState);
                    },
                  ),
                );
              },
              childCount: CartManager().addedProducts.length,
            ),
          )
        ],
      ),
    );
  }

  // Function to remove a product from the cart
  void _deductItem(int index, StateSetter setState) {
    CartManager().deductQuantity(index); // Deduct quantity if possible
    setState(() {}); // Trigger a rebuild of the StatefulBuilder content
  }

  // Function to remove a product from the cart
  void _removeProduct(int index, StateSetter setState) {
    CartManager().removeProduct(index);
    setState(() {}); // Trigger a rebuild of the StatefulBuilder content
  }
}
