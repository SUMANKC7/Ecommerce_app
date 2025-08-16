import 'package:ecommerce_application/model/categorymodel.dart';
import 'package:ecommerce_application/pages/addtocart.dart';
import 'package:ecommerce_application/pages/homepage.dart';
import 'package:ecommerce_application/pages/profile.dart';
import 'package:ecommerce_application/provider/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  final List<CategoryModel> categories;

  const Homescreen({super.key, required this.categories});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Initialize the _pages list here, where widget.categories is available
    _pages = <Widget>[
      Homepage(),
      // Pass widget.categories here
      CartPage(),
      MyProfile(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body:
          _pages[bottomNavProvider.SelectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: bottomNavProvider.SelectedIndex,
        selectedItemColor: const Color.fromARGB(255, 255, 123, 0),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          bottomNavProvider.updateindex(index);
        },
      ),
    );
  }
}
