import 'dart:convert'; // Import the dart:convert library
import 'package:http/http.dart' as http;
import 'package:trustdine/backend/central_api.dart';
import 'package:trustdine/demoData.dart';

Future<void> fetchData() async {
  Map<String, dynamic> userData = await loginUser("admin@gmail.com", "admin");

  String token = userData['authtoken'];
  final response = await fetchAllFoods(
      token); // Replace 'API_ENDPOINT' with the actual API endpoint
  // print(response);

  try {
    for (var food in response) {
      Map<String, dynamic> foodData = {
        'name': food['foodName'],
        'image': food['foodImg'],
        'rating': food['foodDiscount'],
        'size': food['foodSize'],
        'price': double.parse(food['foodPrice']),
        'category': food['categoryName'],
        'id': food['_id'],
      };

      if (food['categoryName'] == 'Pizza') {
        PizzaData.add(foodData);
      } else if (food['categoryName'] == 'Burger') {
        BurgerData.add(foodData);
      }
    }
    // print(PizzaData);
  } catch (e) {
    throw Exception('Failed to load data');
  }
}

bool checkExisting(String iD, List data) {
  for (var food in data) {
    if (iD == food['id']) {
      return true;
    }
  }
  return false;
}

void refreshData() async {
  PizzaData.clear();
  BurgerData.clear();
  await fetchData();
  /*  // print(response);

  try {
    for (var food in response) {
      if (checkExisting(food['id'], PizzaData)) {
        print('List ID: ${food['id']} - Your ID: $');
        //do nothing
      } else {
        Map<String, dynamic> foodData = {
          'name': food['foodName'],
          'image': food['foodImg'],
          'rating': food['foodDiscount'],
          'size': food['foodSize'],
          'price': double.parse(food['foodPrice']),
          'category': food['categoryName'],
          'id': food['_id'],
        };
        if (food['categoryName'] == 'Pizza') {
          PizzaData.add(foodData);
        } else if (food['categoryName'] == 'Burger') {
          BurgerData.add(foodData);
        }
      }
    }
    // print(PizzaData);
  } catch (e) {
    print(e);
  } */
}
