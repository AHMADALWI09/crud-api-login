import 'dart:convert';
import 'package:crud_api_flutterr/model/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  final String url = "http://10.0.2.2:3000";
  // final String url = "http://192.168.150.17:3000";
  var isLoading = false.obs;
  List<Product> products = <Product>[].obs;
  late Product product;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts(1);
  }

  createHeaders() async {
    final pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('access_token');
    return {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };
  }

  refreshProduct() async {
    products.clear();
    await getProducts(1);
  }

  createProduct() {
    product = Product(
        id: 0,
        title: '',
        description: '',
        price: 0,
        discountPercentage: 0,
        rating: 0,
        stock: 0,
        brand: '',
        category: '',
        thumbnail: '',
        images: '');
  }

  getProducts(int page) async {
    isLoading(true);
    final headers = await createHeaders(); // final skip = (page - 1) * 10;
    final response = await http.get(
        Uri.parse('$url/products?page=$page&perpage=100'),
        headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      var list =
          List<Product>.from(data['data'].map((item) => Product.fromMap(item)));
      products.addAll(list);
    }
    isLoading(false);
  }

  getProduct(int id) async {
    final headers = await createHeaders();
    // isLoading(true);
    // final skip = (page - 1) * 10;
    final response =
        await http.get(Uri.parse('$url/products/$id'), headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data);
      product = Product.fromMap(data);
    }
    // isLoading(false);
  }

  insertProduct() async {
    isLoading(true);
    final headers = await createHeaders();
    final response = await http.post(Uri.parse('$url/products'),
        headers: headers, body: jsonEncode(product.toMap()));
    if (response.statusCode == 200) {
      return true;
    }
    isLoading(false);

    return false;
  }

  updateProduct(int id) async {
    isLoading(true);
    final headers = await createHeaders();
    final response = await http.put(Uri.parse('$url/products/$id'),
        headers: headers, body: jsonEncode(product.toMap()));
    if (response.statusCode == 200) {
      return true;
    }
    isLoading(false);

    return false;
  }

  deleteProduct(int id) async {
    final headers = await createHeaders();
    // final headers = <String, String>{'Content-Type': 'aplication/json;'};
    final response =
        await http.delete(Uri.parse('$url/products/$id'), headers: headers);
    // headers: headers, body: jsonEncode(product));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
