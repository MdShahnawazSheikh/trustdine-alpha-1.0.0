import 'dart:convert';
import 'package:http/http.dart' as http;

String baseUrl =
    "http://ec2-43-204-235-212.ap-south-1.compute.amazonaws.com:5001/api";

Future<Map<String, dynamic>> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/login'),
    headers: {"Content-Type": "application/json"},
    body: json.encode({"email": email, "password": password}),
  );
  return json.decode(response.body);
}

Future<List<dynamic>> fetchAllFoods(String authToken) async {
  final response = await http.get(
    Uri.parse('$baseUrl/foods/fetchallfoods'),
    headers: {
      "Accept": "*/*",
      "User-Agent": "Thunder Client",
      "auth-token": authToken
    },
  );
  return json.decode(response.body);
}

Future<void> verifyEmail(String otp, String userId, String authToken) async {
  await http.post(
    Uri.parse('$baseUrl/auth/verifyemail'),
    headers: {"Content-Type": "application/json", "auth-token": authToken},
    body: json.encode({"otp": otp, "userId": userId}),
  );
}

Future<void> addCategory(String categoryId, String categoryImgPath,
    String categoryName, String authToken) async {
  var request = http.MultipartRequest(
      'PUT', Uri.parse('$baseUrl/category/updatecategory/$categoryId'));
  request.headers.addAll({
    "Accept": "*/*",
    "User-Agent": "Thunder Client",
    "auth-token": authToken
  });
  request.fields['categoryName'] = categoryName;
  request.files
      .add(await http.MultipartFile.fromPath('categoryImg', categoryImgPath));
  await request.send();
}

Future<void> addFood(
    String foodImgPath,
    String foodName,
    String foodPrice,
    String foodDiscount,
    String foodType,
    String foodSize,
    String categoryId,
    String categoryName,
    String foodDisc,
    String authToken) async {
  var request =
      http.MultipartRequest('POST', Uri.parse('$baseUrl/foods/addfood'));
  request.headers.addAll({
    "Accept": "*/*",
    "User-Agent": "Thunder Client",
    "auth-token": authToken
  });
  request.fields.addAll({
    'foodName': foodName,
    'foodPrice': foodPrice,
    'foodDiscount': foodDiscount,
    'foodType': foodType,
    'foodSize': foodSize,
    'categoryId': categoryId,
    'categoryName': categoryName,
    'foodDisc': foodDisc,
  });
  request.files.add(await http.MultipartFile.fromPath('foodImg', foodImgPath));
  await request.send();
}

Future<void> updateFood(
    String foodId,
    String foodImgPath,
    String foodName,
    String foodPrice,
    String foodDiscount,
    String foodType,
    String foodSize,
    String categoryId,
    String categoryName,
    String foodDisc,
    String authToken) async {
  var request = http.MultipartRequest(
      'PUT', Uri.parse('$baseUrl/foods/updatefood/$foodId'));
  request.headers.addAll({
    "Accept": "*/*",
    "User-Agent": "Thunder Client",
    "auth-token": authToken
  });
  request.fields.addAll({
    'foodName': foodName,
    'foodPrice': foodPrice,
    'foodDiscount': foodDiscount,
    'foodType': foodType,
    'foodSize': foodSize,
    'categoryId': categoryId,
    'categoryName': categoryName,
    'foodDisc': foodDisc,
  });
  request.files.add(await http.MultipartFile.fromPath('foodImg', foodImgPath));
  await request.send();
}

Future<List<dynamic>> fetchAllCarousel(String authToken) async {
  final response = await http.get(
    Uri.parse('$baseUrl/carousel/fetchallcarousel'),
    headers: {
      "Accept": "*/*",
      "User-Agent": "Thunder Client",
      "auth-token": authToken
    },
  );
  return json.decode(response.body);
}

Future<void> addCarousel(String carouselImgPath, String authToken) async {
  var request =
      http.MultipartRequest('POST', Uri.parse('$baseUrl/carousel/addcarousel'));
  request.headers.addAll({
    "Accept": "*/*",
    "User-Agent": "Thunder Client",
    "auth-token": authToken
  });
  request.files
      .add(await http.MultipartFile.fromPath('carouselImage', carouselImgPath));
  await request.send();
}

Future<void> updateCarousel(
    String carouselId, String carouselImgPath, String authToken) async {
  var request = http.MultipartRequest(
      'PUT', Uri.parse('$baseUrl/carousel/updateCarousel/$carouselId'));
  request.headers.addAll({
    "Accept": "*/*",
    "User-Agent": "Thunder Client",
    "auth-token": authToken
  });
  request.files
      .add(await http.MultipartFile.fromPath('carouselImage', carouselImgPath));
  await request.send();
}
