import 'package:ecommerce_application/model/productmodel.dart';
import 'package:ecommerce_application/pages/detailproduct.dart';
import 'package:ecommerce_application/services/product_services.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final String slug;
  const ProductScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProductServices().getProductsByCategory(slug),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assests/images/loading.gif",
                    height: MediaQuery.sizeOf(context).height * 0.2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Loading...",
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                ),
              ],
            ),
          );
        } else if (snapshot.hasData) {
          var data = snapshot.data as List<ProductModel>;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back, size: 25),
                      ),
                      const Text(
                        "All Product",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.shopping_bag_outlined),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(productId: data[index].id!),
                              ),
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Center(
                                        child: Image.network(
                                          data[index].thumbnail ??
                                              "https://via.placeholder.com/150",
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Icon(
                                                    Icons.broken_image,
                                                    color: Colors.grey[400],
                                                  ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    data[index].title ?? "No title",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${data[index].price!.toStringAsFixed(2)}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Color.fromARGB(
                                                  255,
                                                  210,
                                                  128,
                                                  4,
                                                ),
                                                fontSize: 17,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Rating: ${data[index].rating!.toStringAsFixed(1)}",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            const Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                255,
                                                249,
                                                204,
                                                2,
                                              ),
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text("Error while fetching data"));
        }
      },
    );
  }
}
