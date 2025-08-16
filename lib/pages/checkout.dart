import 'package:ecommerce_application/model/cartmodel.dart';
import 'package:ecommerce_application/pages/addressDetail.dart';
import 'package:ecommerce_application/provider/buynow_provider.dart';
import 'package:ecommerce_application/services/stripe_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  final List<Cartmodel> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double subtotal = cartItems.fold(
      0,
      (sum, item) => sum + (item.product.productPrice ?? 0.0),
    );
    double deliveryCharge = 5.0; // Flat delivery fee
    double total = subtotal + deliveryCharge;

    return Scaffold(
      appBar: AppBar(title: const Text('Buy Now')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Addressdetail()),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.07,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add address", style: TextStyle(fontSize: 17)),
                      SizedBox(width: 5),
                      Icon(Icons.add, size: 26),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];

                return ChangeNotifierProvider(
                  create: (_) =>
                      BuyNowProvider(item.product.productPrice ?? 0.0),
                  child: Consumer<BuyNowProvider>(
                    builder: (context, checkoutProvider, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.19,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 2),
                              Text(
                                item.product.producttitle ?? "Title",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Image.network(
                                    item.product.productImage ??
                                        "Product Image",
                                    fit: BoxFit.contain,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.34,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.1,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 7),
                                          Text(
                                            "Quantity:",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: 30),
                                          GestureDetector(
                                            onTap: checkoutProvider
                                                .decreaseQuantity,
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                CupertinoIcons.minus,
                                                size: 19,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 7),
                                          Text(
                                            "${checkoutProvider.quantity}",
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          SizedBox(width: 7),
                                          GestureDetector(
                                            onTap: checkoutProvider
                                                .increaseQuantity,
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                CupertinoIcons.plus,
                                                size: 19,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Rating:",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          SizedBox(width: 60),
                                          Text(
                                            "${item.product.productRating}",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Price:",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          SizedBox(width: 50),
                                          Text(
                                            "\$${item.product.productPrice}",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 9),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal:", style: TextStyle(fontSize: 16)),
                        Text(
                          "\$${subtotal.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Charge:",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "\$${deliveryCharge.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total:", style: TextStyle(fontSize: 20)),
                        Text(
                          "\$${total.toStringAsFixed(2)}",
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
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    label: Row(
                      children: [
                        Icon(Icons.note_outlined, color: Colors.blue),
                        SizedBox(width: 5),
                        Text(
                          "Invoice",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      double totalAmt = total;

                      // Extract product details from cartItems
                      List<Map<String, dynamic>> productsDetails = cartItems
                          .map((item) {
                            return {
                              "name":
                                  item.product.producttitle ??
                                  "Unknown Product",
                              "price": item.product.productPrice ?? 0.0,
                              "quantity": item.quantity,
                              "id": item.product.id, // Ensure `id` exists
                            };
                          })
                          .toList();

                      // Pass the productsDetails and totalAmt to your payment service
                      PaymentService.makePayment(totalAmt.toString(), "usd", {
                        "products": productsDetails,
                        "total": totalAmt,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(10, 52),
                      backgroundColor: Color.fromARGB(255, 252, 107, 3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: Text(
                      "Place Order",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
