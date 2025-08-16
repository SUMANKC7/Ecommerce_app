// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce_application/provider/buynow_provider.dart';
import 'package:ecommerce_application/services/product_services.dart';
import 'package:ecommerce_application/services/stripe_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Buynow extends StatefulWidget {
  final int productId;
  const Buynow({super.key, required this.productId});

  @override
  State<Buynow> createState() => _BuynowState();
}

class _BuynowState extends State<Buynow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buy Now")),
      body: FutureBuilder(
        future: ProductServices().getProductById(widget.productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Image.asset("assests/images/loading.gif"));
          } else if (snapshot.hasData) {
            var product = snapshot.data!;

            return ChangeNotifierProvider(
              create: (_) => BuyNowProvider(product.productPrice ?? 0.0),
              child: Consumer<BuyNowProvider>(
                builder: (context, buyNowProvider, child) {
                  return Scaffold(
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Container(
                          //   decoration:
                          //       BoxDecoration(border: Border.all(width: 2)),
                          //   child: InkWell(
                          //     borderRadius: BorderRadius.circular(10),
                          //     highlightColor: Colors.green,
                          //     onTap: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => MapPage()));
                          //     },
                          //     child: SizedBox(
                          //         height:
                          //             MediaQuery.sizeOf(context).height * 0.15,
                          //         width:
                          //             MediaQuery.sizeOf(context).width * 0.94,
                          //         child: MapPage()),
                          //   ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    product.producttitle ?? "Title",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// Image takes 40% of available width
                                      Expanded(
                                        flex: 4,
                                        child: Image.network(
                                          product.productImage ??
                                              "https://via.placeholder.com/150",
                                          fit: BoxFit.contain,
                                        ),
                                      ),

                                      const SizedBox(width: 10),

                                      /// Details section takes remaining 60%
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Quantity row
                                            Row(
                                              children: [
                                                const Text(
                                                  "Quantity:",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: buyNowProvider
                                                      .decreaseQuantity,
                                                  child: Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                    child: const Icon(
                                                      CupertinoIcons.minus,
                                                      size: 19,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 7),
                                                Text(
                                                  "${buyNowProvider.quantity}",
                                                  style: const TextStyle(
                                                    fontSize: 19,
                                                  ),
                                                ),
                                                const SizedBox(width: 7),
                                                GestureDetector(
                                                  onTap: buyNowProvider
                                                      .increaseQuantity,
                                                  child: Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                    child: const Icon(
                                                      CupertinoIcons.plus,
                                                      size: 19,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),

                                            // Rating
                                            Row(
                                              children: [
                                                const Text(
                                                  "Rating:",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  "${product.productRating}",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),

                                            // Price
                                            Row(
                                              children: [
                                                const Text(
                                                  "Price:",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  "\$${product.productPrice}",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter promo code",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 9),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "SubTotal :",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(width: 50),
                                      Text(
                                        "\$${buyNowProvider.productPrice.toStringAsFixed(2)}",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Delivery charge :",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(width: 50),
                                      Text(
                                        "\$${buyNowProvider.deliveryCharge}",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total :",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "\$${(buyNowProvider.total.toStringAsFixed(2))}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 17),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton.icon(
                                  onPressed: () {},
                                  label: Row(
                                    children: [
                                      Icon(
                                        Icons.note_outlined,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Invoice",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // Extract product details
                                      String productName =
                                          product.producttitle ??
                                          "Unknown Product";
                                      double productPrice =
                                          product.productPrice ?? 0.0;
                                      String productId = product.id
                                          .toString(); // Assuming `productId` is available
                                      int quantity = buyNowProvider.quantity;

                                      // Prepare order details
                                      double totalAmt =
                                          productPrice *
                                          quantity; // Calculate total amount
                                      List<Map<String, dynamic>>
                                      productsDetails = [
                                        {
                                          "name": productName,
                                          "price": productPrice,
                                          "quantity": quantity,
                                          "id": productId,
                                        },
                                      ];

                                      // Log details (for debugging purposes)
                                      print("Total amount: $totalAmt");
                                      print(
                                        "Products Details: $productsDetails",
                                      );

                                      // Trigger payment process
                                      await PaymentService.makePayment(
                                        totalAmt.toString(),
                                        "usd", // Specify currency
                                        {
                                          "products": productsDetails,
                                          "total": totalAmt,
                                        },
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
                                      "Place Order",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("Error while fetching data"));
          }
        },
      ),
    );
  }
}
