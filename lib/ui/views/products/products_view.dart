import 'package:flutter/material.dart';
import 'package:opc_mobile_development/ui/views/home/home_view.dart';
import 'package:opc_mobile_development/ui/views/profile/profile_view.dart';
import 'package:opc_mobile_development/ui/views/store/store_view.dart';
import 'package:opc_mobile_development/ui/views/wishlist/wishlist_view.dart';
import 'package:stacked/stacked.dart';

import 'products_viewmodel.dart';

class ProductsView extends StackedView<ProductsViewModel> {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ProductsViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: _getViewForIndex(viewModel.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.setIndex,
        backgroundColor: Colors.blue, // Set your desired background color here
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white, // Set your desired selected item color
        unselectedItemColor:
            Colors.white70, // Set your desired unselected item color
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                viewModel.setIndex(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Store'),
              onTap: () {
                viewModel.setIndex(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Wishlist'),
              onTap: () {
                viewModel.setIndex(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                viewModel.setIndex(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const StoreView();
      case 2:
        return const WishlistView();
      case 3:
        return const ProfileView();
      default:
        return const HomeView();
    }
  }

  @override
  ProductsViewModel viewModelBuilder(BuildContext context) =>
      ProductsViewModel();
}
