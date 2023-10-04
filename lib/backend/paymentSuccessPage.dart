import 'package:flutter/material.dart';
import 'package:trustdine/backend/qr_logic.dart';

class PaymentSuccessPage extends StatelessWidget {
  final String orderId; // Add any other order details we want to display
  final double logoWidth;

  const PaymentSuccessPage(
      {required this.orderId, Key? key, required this.logoWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        // floating: true,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Image.asset(
            'assets/trustdine_logo.png',
            width: logoWidth,
          ),
        ),
        backgroundColor: Colors.white,
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
              'Payment Successful',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // const SizedBox(height: 16),
            GenerateQr(data: orderId),
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
