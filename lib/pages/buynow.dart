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
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final isExtraLargeScreen = screenWidth > 1000;

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
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: isLargeScreen ? 800 : double.infinity,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isLargeScreen ? 40 : 8,
                              vertical: isLargeScreen ? 20 : 0,
                            ),
                            child: Column(
                              children: [
                                // Product Details Container - Responsive
                                Container(
                                  margin: EdgeInsets.all(
                                    isLargeScreen ? 16 : 8,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2),
                                    borderRadius: BorderRadius.circular(
                                      isLargeScreen ? 16 : 10,
                                    ),
                                    boxShadow: isLargeScreen
                                        ? [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                0.1,
                                              ),
                                              spreadRadius: 2,
                                              blurRadius: 8,
                                              offset: Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isLargeScreen ? 24 : 14,
                                    vertical: isLargeScreen ? 20 : 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: isLargeScreen ? 15 : 10),
                                      Text(
                                        product.producttitle ?? "Title",
                                        style: TextStyle(
                                          fontSize: isLargeScreen ? 26 : 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: isLargeScreen ? 20 : 10),

                                      // Responsive layout for image and details
                                      isLargeScreen
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Image section for desktop
                                                Expanded(
                                                  flex: 4,
                                                  child: Container(
                                                    height: 250,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      child: Image.network(
                                                        product.productImage ??
                                                            "https://via.placeholder.com/150",
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 30),
                                                // Details section for desktop
                                                Expanded(
                                                  flex: 6,
                                                  child: _buildProductDetails(
                                                    buyNowProvider,
                                                    product,
                                                    isLargeScreen,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                // Mobile layout - original structure
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child: Image.network(
                                                        product.productImage ??
                                                            "https://via.placeholder.com/150",
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      flex: 6,
                                                      child:
                                                          _buildProductDetails(
                                                            buyNowProvider,
                                                            product,
                                                            isLargeScreen,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),

                                // Promo Code Input - Responsive
                                Padding(
                                  padding: EdgeInsets.all(
                                    isLargeScreen ? 16 : 8,
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Enter promo code",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          isLargeScreen ? 12 : 10,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: isLargeScreen ? 20 : 12,
                                        vertical: isLargeScreen ? 16 : 12,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: isLargeScreen ? 16 : 14,
                                    ),
                                  ),
                                ),

                                SizedBox(height: isLargeScreen ? 20 : 10),

                                // Total Summary Container - Responsive
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isLargeScreen ? 16 : 9,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2),
                                      borderRadius: BorderRadius.circular(
                                        isLargeScreen ? 16 : 10,
                                      ),
                                      boxShadow: isLargeScreen
                                          ? [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                  0.1,
                                                ),
                                                spreadRadius: 2,
                                                blurRadius: 8,
                                                offset: Offset(0, 4),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isLargeScreen ? 24 : 14,
                                      vertical: isLargeScreen ? 20 : 10,
                                    ),
                                    child: Column(
                                      children: [
                                        _buildSummaryRow(
                                          "SubTotal :",
                                          "\$${buyNowProvider.productPrice.toStringAsFixed(2)}",
                                          isLargeScreen,
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 10 : 5,
                                        ),
                                        _buildSummaryRow(
                                          "Delivery charge :",
                                          "\$${buyNowProvider.deliveryCharge}",
                                          isLargeScreen,
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 15 : 10,
                                        ),
                                        Divider(),
                                        _buildSummaryRow(
                                          "Total :",
                                          "\$${(buyNowProvider.total.toStringAsFixed(2))}",
                                          isLargeScreen,
                                          isTotal: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: isLargeScreen ? 30 : 20),

                                // Bottom Action Row - Responsive
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isLargeScreen ? 16 : 17,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Invoice Button
                                      TextButton.icon(
                                        onPressed: () {},
                                        label: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.note_outlined,
                                              color: Colors.blue,
                                              size: isLargeScreen ? 24 : 20,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "Invoice",
                                              style: TextStyle(
                                                fontSize: isLargeScreen
                                                    ? 22
                                                    : 20,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Place Order Button
                                      SizedBox(
                                        width: isLargeScreen ? 200 : null,
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
                                            int quantity =
                                                buyNowProvider.quantity;

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
                                            minimumSize: Size(
                                              10,
                                              isLargeScreen ? 60 : 52,
                                            ),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                  255,
                                                  252,
                                                  107,
                                                  3,
                                                ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    isLargeScreen ? 12 : 7,
                                                  ),
                                            ),
                                          ),
                                          child: Text(
                                            "Place Order",
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

                                SizedBox(height: isLargeScreen ? 40 : 20),
                              ],
                            ),
                          ),
                        ),
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

  // Helper widget for product details section
  Widget _buildProductDetails(
    BuyNowProvider buyNowProvider,
    dynamic product,
    bool isLargeScreen,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Quantity row
        Row(
          children: [
            Text(
              "Quantity:",
              style: TextStyle(
                fontSize: isLargeScreen ? 18 : 17,
                fontWeight: isLargeScreen ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            SizedBox(width: isLargeScreen ? 15 : 10),
            GestureDetector(
              onTap: buyNowProvider.decreaseQuantity,
              child: Container(
                width: isLargeScreen ? 32 : 24,
                height: isLargeScreen ? 32 : 24,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(isLargeScreen ? 10 : 8),
                ),
                child: Icon(
                  CupertinoIcons.minus,
                  size: isLargeScreen ? 22 : 19,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: isLargeScreen ? 12 : 7),
            Text(
              "${buyNowProvider.quantity}",
              style: TextStyle(
                fontSize: isLargeScreen ? 22 : 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: isLargeScreen ? 12 : 7),
            GestureDetector(
              onTap: buyNowProvider.increaseQuantity,
              child: Container(
                width: isLargeScreen ? 32 : 24,
                height: isLargeScreen ? 32 : 24,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(isLargeScreen ? 10 : 8),
                ),
                child: Icon(
                  CupertinoIcons.plus,
                  size: isLargeScreen ? 22 : 19,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: isLargeScreen ? 15 : 10),

        // Rating
        Row(
          children: [
            Text(
              "Rating:",
              style: TextStyle(
                fontSize: isLargeScreen ? 18 : 17,
                fontWeight: isLargeScreen ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            SizedBox(width: isLargeScreen ? 15 : 10),
            Text(
              "${product.productRating}",
              style: TextStyle(fontSize: isLargeScreen ? 18 : 16),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.star,
              color: const Color.fromARGB(255, 255, 187, 1),
              size: isLargeScreen ? 20 : 18,
            ),
          ],
        ),
        SizedBox(height: isLargeScreen ? 15 : 10),

        // Price
        Row(
          children: [
            Text(
              "Price:",
              style: TextStyle(
                fontSize: isLargeScreen ? 18 : 17,
                fontWeight: isLargeScreen ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            SizedBox(width: isLargeScreen ? 15 : 10),
            Text(
              "\$${product.productPrice}",
              style: TextStyle(
                fontSize: isLargeScreen ? 20 : 16,
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Helper widget for summary rows
  Widget _buildSummaryRow(
    String label,
    String value,
    bool isLargeScreen, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal
                ? (isLargeScreen ? 22 : 20)
                : (isLargeScreen ? 18 : 16),
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        SizedBox(width: 50),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal
                ? (isLargeScreen ? 20 : 18)
                : (isLargeScreen ? 17 : 15),
            color: isTotal ? Colors.deepOrange : Colors.black,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
