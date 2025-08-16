import 'dart:convert';
import 'package:ecommerce_application/model/detailproductmodel.dart';
import 'package:ecommerce_application/model/productmodel.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  String baseURL = "https://dummyjson.com/products"; // Base URL for products
  String categoriesURL =
      "https://dummyjson.com/products/categories"; // Base URL for categories

  Future<List<String>> getAllCategoryUrls() async {
    var response = await http.get(Uri.parse(categoriesURL));
    if (response.statusCode == 200) {
      // Decode the response body to extract the URLs
      var decodedData = jsonDecode(response.body) as List;
      return List<String>.from(decodedData.map((category) => category['url']));
    } else {
      throw Exception("No categories found");
    }
  }

  Future<List<Detailproductmodel>> getAllProductData() async {
    List<Detailproductmodel> allProducts = [];

    try {
      List<String> categoryUrls = await getAllCategoryUrls();

      for (String url in categoryUrls) {
        var response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);

          // Check if "products" exists in the decoded data
          if (decodedData["products"] != null) {
            for (var product in decodedData["products"]) {
              allProducts.add(Detailproductmodel.fromJson(product));
            }
          }
        } else {
          print("Failed to load products for category: $url");
        }
      }
      return allProducts;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Detailproductmodel> getProductById(int id) async {
    try {
      // Get categories or other required logic
      List<String> categoryUrls = await getAllCategoryUrls();

      for (String url in categoryUrls) {
        var response = await http.get(Uri.parse("$baseURL/$id"));
        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);
          return Detailproductmodel.fromJson(
            decodedData,
          ); // Return a single product
        } else {
          print("Failed to load product details for category: $url");
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    throw Exception("Product not found"); // In case no product is found
  }

  Future<List<ProductModel>> getProductsByCategory(String slug) async {
    final url = 'https://dummyjson.com/products/category/$slug';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return (decodedData["products"] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } else {
      throw Exception("Failed to load products for category: $slug");
    }
  }

  Future<List<Detailproductmodel>> getTopDeal() async {
    const url = "https://dummyjson.com/products/category/sports-accessories";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return (decodedData["products"] as List)
          .map((product) => Detailproductmodel.fromJson(product))
          .toList();
    } else {
      throw Exception("Failed to load products ");
    }
  }
}
