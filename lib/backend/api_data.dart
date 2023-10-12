import 'dart:convert'; // Import the dart:convert library
import 'package:http/http.dart' as http;
import 'package:trustdine/backend/central_api.dart';
import 'package:trustdine/demoData.dart';

Future<void> fetchData() async {
  Map<String, dynamic> userData = await loginUser("admin@gmail.com", "admin");
  String token = userData['authtoken'];

  if (PizzaData.length > 0) {
    PizzaData.clear();
    PizzaVeg.clear();
    PizzaNonVeg.clear();
  }
  if (BurgerData.length > 0) {
    BurgerData.clear();
    BurgerVeg.clear();
    BurgerNonVeg.clear();
  }
  if (CarouselData.length > 0) {
    CarouselData.clear();
  }
  if (FeaturedFoods.length > 0) {
    FeaturedFoods.clear();
  }
  if (SpotlightFoods.length > 0) {
    SpotlightFoods.clear();
  }
  final response = await fetchAllFoods(
      token); // Replace 'API_ENDPOINT' with the actual API endpoint
  final carousels = await fetchAllCarousel(token);

  try {
    for (var item in carousels) {
      CarouselData.add(item['carouselImage']);
    }
    for (var food in response) {
      Map<String, dynamic> foodData = {
        'name': food['foodName'],
        'image': food['foodImg'],
        'rating': food['foodDiscount'],
        'size': food['foodSize'],
        'price': double.parse(food['foodPrice']),
        'category': food['categoryName'],
        'id': food['_id'],
        'type': food['foodType'],
        'featured': food['featured'],
        'spotlight': food['spotlight']
      };
      if (foodData['featured'] == true) {
        FeaturedFoods.add(foodData);
      }
      if (foodData['spotlight'] == true) {
        SpotlightFoods.add(foodData);
      }

      if (food['categoryName'] == 'Pizza') {
        PizzaData.add(foodData);
        if (food['foodType'] == 'veg' ||
            food['foodType'] == "Veg" ||
            food['foodType'] == "VEG") {
          PizzaVeg.add(foodData);
        } else {
          PizzaNonVeg.add(foodData);
        }
      } else if (food['categoryName'] == 'Burger') {
        BurgerData.add(foodData);
        if (food['foodType'] == 'veg' ||
            food['foodType'] == "Veg" ||
            food['foodType'] == "VEG") {
          BurgerVeg.add(foodData);
        } else {
          BurgerNonVeg.add(foodData);
        }
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
  CarouselData.clear();
  await fetchData();
}
