import 'package:ecommerce_application/model/categorymodel.dart';
import 'package:ecommerce_application/pages/productscreen.dart';
import 'package:flutter/material.dart';

class Categorypage extends StatelessWidget {
  final List<CategoryModel> categories;

  const Categorypage({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Adds some padding for better UI
        child: Column(
          children: [
            Expanded(
              // Expanded allows the GridView to take up available space
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductScreen(slug: category.slug),
                        ),
                      );
                    },
                    child: Card(
                      color: category.color,
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                category.imagePath,
                                height: MediaQuery.sizeOf(context).height * 0.1,
                                width: MediaQuery.sizeOf(context).height * 0.1,
                              ),
                            ),
                            Text(
                              category.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
  }
}
