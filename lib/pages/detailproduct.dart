import 'package:ecommerce_application/model/productmodel.dart';
import 'package:ecommerce_application/pages/addtocart.dart';
import 'package:ecommerce_application/pages/buynow.dart';
import 'package:ecommerce_application/provider/cart_provider.dart';
import 'package:ecommerce_application/services/product_services.dart';
import 'package:ecommerce_application/services/shared_preference.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  final int productId;

  const DetailPage({super.key, required this.productId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic>? paymentIntent;
  late ProductModel? product;
  String? name, email;

  getthesharedpref() async {
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return FutureBuilder(
      future: ProductServices().getProductById(widget.productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Image.asset("assests/images/loading.gif"));
        } else if (snapshot.hasData) {
          var product = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text("Product Details")),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                  icon: Icon(Icons.shopping_bag),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            product.productImage ??
                                "assets/images/placeholder.png",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.36,
                          ),
                          SizedBox(height: 12),
                          Text(
                            product.producttitle ?? "Product Name",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${product.productPrice!.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5,
                                  color: Colors.orange,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Rating: ${product.productRating ?? 0.0}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Icon(
                                    Icons.star,
                                    color: const Color.fromARGB(
                                      255,
                                      255,
                                      187,
                                      1,
                                    ),
                                    size: 24,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Stock: ${product.stock ?? 0.0}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.3,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            product.productDescription ?? "Product Description",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 14),
                          if (product.otherImages != null &&
                              product.otherImages!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "More Images",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ...product.otherImages!.map(
                                  (image) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5.0,
                                    ),
                                    child: Image.network(
                                      image,
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.8,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Image.asset(
                                              "assets/images/placeholder.png",
                                            );
                                          },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Spacer to push the buttons to the bottom
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            cartProvider.add(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('added to cart!'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(10, 52),
                            backgroundColor: const Color.fromARGB(
                              255,
                              246,
                              156,
                              20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Buynow(productId: widget.productId),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(10, 52),
                            backgroundColor: const Color.fromARGB(
                              255,
                              252,
                              107,
                              3,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: Text(
                            "Buy Now",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text("Error while fetching data"));
        }
      },
    );
  }
}
