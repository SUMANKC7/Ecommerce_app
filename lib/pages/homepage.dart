import 'package:ecommerce_application/features/productsearch.dart';
import 'package:ecommerce_application/model/categorymodel.dart';
import 'package:ecommerce_application/pages/addtocart.dart';
import 'package:ecommerce_application/pages/allproduct.dart';
import 'package:ecommerce_application/pages/categorypage.dart';
import 'package:ecommerce_application/pages/productscreen.dart';
import 'package:ecommerce_application/pages/top%20_deals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final List<CategoryModel> categories = [
    CategoryModel(
      name: "Beauty ",
      imagePath: "assests/images/beauty.png",
      slug: "beauty",
      color: Colors.pink,
    ),
    CategoryModel(
      name: "Fragrances ",
      imagePath: "assests/images/fragrance.png",
      slug: "fragrances",
      color: Colors.green,
    ),
    CategoryModel(
      name: "Laptops ",
      imagePath: "assests/images/laptop.png",
      slug: "laptops",
      color: Colors.lightBlue,
    ),
    CategoryModel(
      name: "Groceries ",
      imagePath: "assests/images/grocery.png",
      slug: "groceries",
      color: const Color.fromARGB(255, 249, 197, 7),
    ),
    CategoryModel(
      name: "Furniture ",
      imagePath: "assests/images/furniture.png",
      slug: "furniture",
      color: Colors.orangeAccent,
    ),
    CategoryModel(
      name: "Watches ",
      imagePath: "assests/images/smartwatch.png",
      slug: "mens-watches",
      color: Colors.purpleAccent,
    ),
    CategoryModel(
      name: "Smartphones",
      imagePath: "assests/images/phone.png",
      slug: "smartphones",
      color: Colors.amber,
    ),
    CategoryModel(
      name: "Tablelets",
      imagePath: "assests/images/tablets.png",
      slug: "tablets",
      color: Colors.red,
    ),
    CategoryModel(
      name: "Women-Bags ",
      imagePath: "assests/images/bag.png",
      slug: "womens-bags",
      color: Colors.purple,
    ),
    CategoryModel(
      name: " Sports-Accessories",
      imagePath: "assests/images/sports.png",
      slug: "sports-accessories",
      color: Colors.brown,
    ),
    CategoryModel(
      name: "Sunglasses",
      imagePath: "assests/images/sunglasses.png",
      slug: "sunglasses",
      color: Colors.lightBlue,
    ),
    CategoryModel(
      name: "Mens-Shoes ",
      imagePath: "assests/images/shoes.png",
      slug: "mens-shoes",
      color: Colors.black,
    ),
    CategoryModel(
      name: "Vehicle",
      imagePath: "assests/images/beauty.png",
      slug: "vehicle",
      color: const Color.fromARGB(255, 196, 83, 42),
    ),
  ];

  List carosulImage = [
    "assests/carosuelImage/deal1.png",
    "assests/carosuelImage/deal2.png",
    "assests/carosuelImage/deal3.webp",
    "assests/carosuelImage/deal4.jpg",
    "assests/carosuelImage/deal5.jpg",
    "assests/carosuelImage/banner.png",
  ];

  bool get isLargeScreen => MediaQuery.of(context).size.width > 600;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _globalKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              );
            },
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            icon: const Icon(Icons.shopping_bag),
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(color: Colors.green),
              child: Column(
                children: [
                  Image.asset(
                    "assests/images/file.png",
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Text(
                    "Suman KC",
                    style: GoogleFonts.breeSerif(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.wallet),
              title: const Text("Order"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text("Message"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Favorite"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Setting"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text("Account "),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar Section - Responsive padding and constraints
            Container(
              height: isWideScreen
                  ? 80
                  : MediaQuery.sizeOf(context).height * 0.1,
              padding: EdgeInsets.symmetric(
                horizontal: isWideScreen ? 40 : 20,
                vertical: 15,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isWideScreen ? 800 : double.infinity,
                  ),
                  child: TextField(
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductSearchPage(),
                          ),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, size: 30),
                      hintText: "Search Anything...",
                      hintStyle: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Categories Section - Responsive layout
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWideScreen ? 40 : 25,
                vertical: 5,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWideScreen ? 1200 : double.infinity,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Categorypage(categories: categories),
                          ),
                        );
                      },
                      child: Row(
                        children: const [
                          Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          Icon(Icons.arrow_forward, color: Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Categories List - Responsive height and grid for large screens
            if (isWideScreen)
              // Grid layout for large screens
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screenWidth > 1000 ? 6 : 4,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: categories.length > (screenWidth > 1000 ? 12 : 8)
                        ? (screenWidth > 1000 ? 12 : 8)
                        : categories.length,
                    itemBuilder: (context, index) {
                      return CategoryItem(
                        category: categories[index],
                        isLargeScreen: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductScreen(slug: categories[index].slug),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            else
              // Horizontal scroll for mobile
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.15,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryItem(
                      category: categories[index],
                      isLargeScreen: false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductScreen(slug: categories[index].slug),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

            const SizedBox(height: 20),

            // Carousel Section - Responsive sizing
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isWideScreen ? 40 : 0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWideScreen ? 1200 : double.infinity,
                ),
                child: SizedBox(
                  height: isWideScreen
                      ? 250
                      : MediaQuery.sizeOf(context).height * 0.15,
                  child: CarouselItem(
                    carosulImage: carosulImage,
                    isLargeScreen: isWideScreen,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Top Deals Section - Responsive layout
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWideScreen ? 40 : 25,
                vertical: 5,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWideScreen ? 1200 : double.infinity,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Top Deals",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AllProduct()),
                        );
                      },
                      child: Row(
                        children: const [
                          Text(
                            "All Products",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          Icon(Icons.arrow_forward, color: Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Top Deals with responsive container
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isWideScreen ? 40 : 0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWideScreen ? 1200 : double.infinity,
                ),
                child: TopDeals(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    super.key,
    required this.carosulImage,
    this.isLargeScreen = false,
  });

  final List<dynamic> carosulImage;
  final bool isLargeScreen;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return CarouselView(
      itemExtent: isLargeScreen
          ? (screenWidth > 1000 ? 600 : 400)
          : MediaQuery.sizeOf(context).width * 0.8,
      children: List.generate(carosulImage.length, (int index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: isLargeScreen ? 8 : 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isLargeScreen ? 12 : 8),
            child: Image.asset(
              carosulImage[index],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        );
      }),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;
  final bool isLargeScreen;

  const CategoryItem({
    super.key,
    required this.category,
    required this.onTap,
    this.isLargeScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizing
    double avatarRadius;
    double imageSize;
    double fontSize;

    if (isLargeScreen) {
      avatarRadius = screenWidth > 1000 ? 40 : 35;
      imageSize = screenWidth > 1000 ? 55 : 50;
      fontSize = screenWidth > 1000 ? 14 : 12;
    } else {
      avatarRadius = 30;
      imageSize = 43;
      fontSize = 12;
    }

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isLargeScreen ? 5 : 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: avatarRadius,
              // backgroundColor: category.color.(0.1),
              child: Image.asset(
                category.imagePath,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: isLargeScreen ? 8 : 3),
            Flexible(
              child: Text(
                category.name,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
