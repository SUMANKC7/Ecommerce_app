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
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return FutureBuilder(
      future: ProductServices().getProductById(widget.productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: Image.asset("assests/images/loading.gif")),
          );
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
                if (isLargeScreen) SizedBox(width: 20),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isLargeScreen ? 1200 : double.infinity,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isLargeScreen ? 40 : 30,
                          ),
                          child: isLargeScreen
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Left side - Image
                                    Expanded(
                                      flex: 6,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 450,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 2,
                                                  blurRadius: 8,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                product.productImage ??
                                                    "assets/images/placeholder.png",
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                            ),
                                          ),
                                          if (product.otherImages != null &&
                                              product
                                                  .otherImages!
                                                  .isNotEmpty) ...[
                                            SizedBox(height: 20),
                                            Text(
                                              "More Images",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount:
                                                        screenWidth > 1000
                                                        ? 3
                                                        : 2,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 10,
                                                    childAspectRatio: 1.0,
                                                  ),
                                              itemCount:
                                                  product.otherImages!.length,
                                              itemBuilder: (context, index) {
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    product.otherImages![index],
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) {
                                                          return Image.asset(
                                                            "assets/images/placeholder.png",
                                                          );
                                                        },
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 40),
                                    // Right side - Details
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 20),
                                          Text(
                                            product.producttitle ??
                                                "Product Name",
                                            style: TextStyle(
                                              fontSize: screenWidth > 1000
                                                  ? 28
                                                  : 25,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${product.productPrice!.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  fontSize: screenWidth > 1000
                                                      ? 26
                                                      : 23,
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
                                                      fontWeight:
                                                          FontWeight.w900,
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
                                          SizedBox(height: 15),
                                          Text(
                                            "Stock: ${product.stock ?? 0.0}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 1.3,
                                              color: Colors.green,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            product.productDescription ??
                                                "Product Description",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black54,
                                              height: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      product.productImage ??
                                          "assets/images/placeholder.png",
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.36,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                      product.productDescription ??
                                          "Product Description",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(height: 14),
                                    if (product.otherImages != null &&
                                        product.otherImages!.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 5.0,
                                                  ),
                                              child: Image.network(
                                                image,
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.8,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
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
                  ),
                ),
                // Bottom Action Buttons - Responsive
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 40 : 20,
                    vertical: isLargeScreen ? 20 : 10,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isLargeScreen ? 600 : double.infinity,
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
                                minimumSize: Size(10, isLargeScreen ? 60 : 52),
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  246,
                                  156,
                                  20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    isLargeScreen ? 10 : 7,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                  fontSize: isLargeScreen ? 20 : 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: isLargeScreen ? 20 : 10),
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
                                minimumSize: Size(10, isLargeScreen ? 60 : 52),
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  252,
                                  107,
                                  3,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    isLargeScreen ? 10 : 7,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Buy Now",
                                style: TextStyle(
                                  fontSize: isLargeScreen ? 20 : 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text("Error while fetching data")),
          );
        }
      },
    );
  }
}
