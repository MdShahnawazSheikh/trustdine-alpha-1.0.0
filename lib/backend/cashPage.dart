import 'package:flutter/material.dart';
import 'package:trustdine/backend/qr_logic.dart';

class CashPayment extends StatelessWidget {
  final String orderId; // Add any other order details we want to display

  const CashPayment({required this.orderId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final productToAdd = AddedProduct(
    //     "productName", 23.5, 1, "imagePath", "productSize"); //test purpose
    /* Map<String, Map<String, dynamic>> purchaseData = {
      'Product1': {
        'Size': 'Large',
        'Price': 436.6,
        'Quantity': 54,
      },
      'Product2': {
        'Size': 'Medium',
        'Price': 249.99,
        'Quantity': 25,
      },
    };
    DatabaseManager().addData(purchaseData); */
    // CartManager().addProduct(productToAdd); //test purpose
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cash Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            const Text(
              'Pay in Cash',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // const SizedBox(height: 16),
            GenerateQr(data: orderId.toString()),
            Text(
              'Order ID: $orderId',
              style: const TextStyle(fontSize: 18),
            ),
            // Text(
            //     "Product Name: ${CartManager().addedProducts[0].productName}") //test purpose
            // You can add more order details here if needed
          ],
        ),
      ),
    );
  }
}
