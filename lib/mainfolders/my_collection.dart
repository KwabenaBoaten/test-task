import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_task/mainfolders/collections_folder/collection_page.dart';
import 'package:test_task/mainfolders/collections_folder/scan_page.dart';
import 'package:test_task/mainfolders/collections_folder/settings_page.dart';
import 'package:test_task/mainfolders/collections_folder/shop_page.dart';

class MyCollection extends StatefulWidget {
  const MyCollection({super.key});

  @override
  State<MyCollection> createState() => _MyCollectionState();
}

class _MyCollectionState extends State<MyCollection> {
  // Index of the currently selected tab
  int _currentIndex = 0;

  // List of pages for each tab
  final List<Widget> _pages = [
    const ScanPage(),
    const CollectionPage(),
    const ShopPage(),
    const SettingsPage(),
  ];

  // List of titles for each page
  final List<String> _titles = [
    'Scan',
    'Collection',
    'Shop',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex], // Set title based on the selected index
          style: const TextStyle(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // You can add notification functionality here
            },
            icon: const Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: _pages[_currentIndex], // Show the page based on the selected index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Current selected index
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected index
          });
        },
        type: BottomNavigationBarType.fixed, // Allows more than 3 items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.barcode_viewfinder),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_grid_2x2),
            label: 'Collection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.liquor_outlined),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
