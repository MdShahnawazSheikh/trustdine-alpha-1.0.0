import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:trustdine/backend/cartManager.dart';

class PrinterUtils {
  BlueThermalPrinter _printer = BlueThermalPrinter.instance;

  Future<List<BluetoothDevice>> getBondedDevices() async {
    return await _printer.getBondedDevices();
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await _printer.connect(device);
  }

  Future<void> disconnectDevice() async {
    await _printer.disconnect();
  }

  Future<void> newLine() async {
    await _printer.printNewLine();
  }

  Future get isConnected async {
    return await _printer.isConnected;
  }

  Future<void> printData(String data) async {
    if (await isConnected) {
      _printer.printNewLine();
      _printer.printCustom(data, 5, 10);
    }
  }

  Future<void> printQR() async {
    if (await isConnected) {
      _printer.printNewLine();
      _printer.printQRcode("Test Print", 250, 250, 15);
    }
  }

  Future<void> cutPaper() async {
    if (await isConnected) {
      _printer.paperCut();
    }
  }

  Future<void> printRestaurantReceipt(String restaurantName, String orderID,
      List<AddedProduct> cartItems, double totalAmount) async {
    if (await isConnected) {
      _printer.printNewLine();
      _printer.printCustom("**************************", 1, 1);
      _printer.printNewLine();
      _printer.printCustom("$restaurantName Receipt", 5, 1);
      _printer.printNewLine();
      _printer.printCustom(
        "A street name\n  State of Business with - pincode\n  Your Country Name",
        1,
        1,
      );
      _printer.printNewLine();
      _printer.printQRcode(orderID, 250, 250, 30);
      _printer.printCustom("---------------------------", 5, 1);

      for (AddedProduct item in CartManager().addedProducts) {
        _printer.printCustom(
            "${item.productName}  x ${item.quantity}\nRs ${item.price}", 1, 3);
      }

      _printer.printCustom("---------------------------", 5, 1);
      _printer.printNewLine();
      _printer.printCustom(
          "Total: Rs ${totalAmount.toStringAsFixed(2)}\n\n", 1, 1);
      _printer.printNewLine();
      _printer.printCustom("**************************", 1, 1);
      _printer.printNewLine();
    }
  }
}
