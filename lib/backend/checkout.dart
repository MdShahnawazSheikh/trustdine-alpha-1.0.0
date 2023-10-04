import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trustdine/backend/cartManager.dart';
import 'package:trustdine/backend/cashPage.dart';
import 'package:trustdine/backend/paymentSuccessPage.dart';

class CheckOutPage extends StatefulWidget {
  final double paymentAmount;
  const CheckOutPage({required this.paymentAmount, super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  Razorpay? _razorpay;

  void _handleSuccessfullPayment(PaymentSuccessResponse response) {
    final paymentId = response.paymentId.toString();
    Fluttertoast.showToast(
      msg: "Payment Successfull\nPayment ID: ${response.paymentId}",
      timeInSecForIosWeb: 4,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentSuccessPage(orderId: (paymentId)),
      ),
    );
    CartManager().pushCartToFirestore(paymentId);
    CartManager().clearCart();
  }

  // Cash Payment

  String generateHexCode() {
    // Generate a random 6-digit hexadecimal number
    String randomHex =
        (1000000 + (DateTime.now().millisecondsSinceEpoch % 9000000))
            .toRadixString(16);

    // Ensure the hexadecimal number is exactly 6 digits
    randomHex = randomHex.padLeft(6, '0');

    // Create the pattern by repeating the 6-digit number twice
    String hexCode = randomHex + randomHex;

    return hexCode;
  }

  void _handleCashPayment(String cashOrderID) {
    final orderID = cashOrderID;
    Fluttertoast.showToast(
      msg: "Order Confirmed!\nOrder ID: ${orderID}",
      timeInSecForIosWeb: 4,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CashPayment(orderId: (orderID)),
      ),
    );
    CartManager().pushCartToFirestore(orderID);
    CartManager().clearCart();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Error: ${response.code} - ${response.message}",
      timeInSecForIosWeb: 4,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "Error with wallet: ${response.walletName}",
      timeInSecForIosWeb: 4,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccessfullPayment);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void makePayment() async {
    var options = {
      'key': 'rzp_test_Z82cRZXwhEsVnK',
      'amount': widget.paymentAmount * 100,
      'name': 'TrustSign India',
      'description': "Paying for Food Order at TrustSign's kiosk",
      'prefill': {'contact': "PhoneNumber", 'email': "Email Address"},
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          content: Text(e.toString()),
          actions: [ElevatedButton(onPressed: () {}, child: Text("Close"))]));
    }
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'TrustSign',
                style: TextStyle(
                  fontFamily: "Sedwig",
                  fontSize: 70,
                  color: Colors.blue,
                ),
              ),
              /* SizedBox(
                height: 1,
              ), */
              /* Text(
                "Checkout",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ), */
              const SizedBox(
                height: 200,
              ),
              Text(
                "Thank You for your order\nChoose a payment method",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: const CheckoutButton(
                    yourText: "Pay with Razorpay",
                    yourIcon: FontAwesomeIcons.indianRupeeSign,
                    buttonColor: Color.fromARGB(255, 136, 0, 255),
                    textColor: Color.fromARGB(255, 255, 255, 255)),
                onTap: () {
                  print("tapped");
                  makePayment();
                },
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                child: const CheckoutButton(
                    yourText: "Pay with Cash",
                    yourIcon: FontAwesomeIcons.moneyCheckDollar,
                    buttonColor: Colors.grey,
                    textColor: Color.fromARGB(255, 255, 255, 255)),
                onTap: () {
                  _handleCashPayment(generateHexCode());
                },
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                child: const CheckoutButton(
                    yourText: "Pay with",
                    yourIcon: FontAwesomeIcons.applePay,
                    buttonColor: Color.fromARGB(255, 0, 0, 0),
                    textColor: Color.fromARGB(255, 255, 255, 255)),
                onTap: () {
                  Fluttertoast.showToast(
                    msg: "Coming Soon",
                    timeInSecForIosWeb: 4,
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckoutButton extends StatelessWidget {
  final String yourText;
  final IconData yourIcon;
  final Color textColor;
  final Color buttonColor;
  const CheckoutButton({
    required this.yourIcon,
    required this.yourText,
    required this.textColor,
    required this.buttonColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          color: buttonColor),
      // height: screenHeight / 15,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            yourText,
            style: TextStyle(
                color: textColor, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            width: 6,
          ),
          FaIcon(
            yourIcon,
            size: 50,
            color: textColor,
          ),
        ],
      ),
    );
  }
}
