// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProductView extends StatelessWidget {
  ProductView({super.key});

  List<Product> allproduct = [
    Product(
        image: "assests/images/phone.png",
        productName: "Samsung S24 Ultra",
        price: "Rs 164000", newPrice: 'Rs 154000'),
    Product(
        image: "assests/images/fridge.png",
        productName: "Samsung Refrigerator 200Ltr",
        price: "Rs 48000", newPrice: 'Rs 44000'),
    Product(
        image: "assests/images/laptop.png",
        productName: "HP Vostro",
        price: "Rs 90000", newPrice: 'Rs 80000'),
    Product(
        image: "assests/images/smartwatch.png",
        productName: "Apple Watch 3",
        price: "Rs 58000", newPrice: 'Rs 40000'),
    Product(
        image: "assests/images/television.png",
        productName: "LG O-Led",
        price: "Rs 98000", newPrice: 'Rs 67000'),
    Product(
        image: "assests/images/washingmachine.png",
        productName: "Samsung Washing Machine (12 kg)",
        price: "Rs 87000", newPrice: 'Rs 80000'),
    Product(
        image: "assests/images/phone.png",
        productName: "Samsung S24 Ultra",
        price: "Rs 164000", newPrice: 'Rs 140000'),
    Product(
        image: "assests/images/fridge.png",
        productName: "Samsung Refrigerator 200Ltr",
        price: "Rs 48000", newPrice: 'Rs 39999'),
    Product(
        image: "assests/images/laptop.png",
        productName: "HP Vostro",
        price: "Rs 90000", newPrice: 'Rs 79999'),
    Product(
        image: "assests/images/smartwatch.png",
        productName: "Apple Watch 3",
        price: "Rs 58000", newPrice: 'Rs 49999'),
    Product(
        image: "assests/images/television.png",
        productName: "LG O-Led",
        price: "Rs 98000", newPrice: 'Rs 89999'),
    Product(
        image: "assests/images/washingmachine.png",
        productName: "Samsung WashingMachine (12 kg)",
        price: "Rs 87000", newPrice: 'Rs 7777'),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.only(left: 20, right: 20),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: allproduct.length,
        itemBuilder: (context, index) {
          return ProductCard(
            allproduct: allproduct[index],
          );
        });
  }
}

class Product {
  final String image;
  final String productName;
  final String price;
  final String newPrice;

  Product(
      {required this.image, required this.productName,  required this.price,required this.newPrice});
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.allproduct,
  });
  final Product allproduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: const Color.fromARGB(255, 249, 220, 224),
      // color: const Color.fromARGB(255, 247, 225, 250),
      child: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                allproduct.image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              allproduct.productName,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10,right: 8),
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(allproduct.newPrice,style: TextStyle(fontWeight: FontWeight.w900,color: const Color.fromARGB(255, 210, 128, 4),fontSize: 17),textAlign: TextAlign.left,),
                      Container(
                        decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(5)),
                        child: Icon(Icons.add,size: 26,),
                      )
                    ],
                  ),
                  Text(allproduct.price,style: const TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey,fontSize: 13),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
