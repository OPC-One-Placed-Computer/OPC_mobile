import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 250, // Adjust the height according to your needs
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 320.0,
                    margin: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://via.placeholder.com/370x200',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 320.0,
                    margin: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://via.placeholder.com/370x200',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 320.0,
                    margin: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://via.placeholder.com/370x200',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Featured Products',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(
                  left: 16.0, top: 8.0, bottom: 8.0, right: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Latest Products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  ProductItem(
                    imageUrl: 'https://via.placeholder.com/150',
                    productName: 'Product 1',
                    brandName: 'Brand 1',
                    price: '\$100',
                  ),
                  ProductItem(
                    imageUrl: 'https://via.placeholder.com/150',
                    productName: 'Product 2',
                    brandName: 'Brand 2',
                    price: '\$200',
                  ),
                  ProductItem(
                    imageUrl: 'https://via.placeholder.com/150',
                    productName: 'Product 3',
                    brandName: 'Brand 3',
                    price: '\$300',
                  ),
                  // Add more ProductItem widgets as needed
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/view_more');
                },
                child: const Text(
                  'View More',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: 16.0, top: 8.0, bottom: 8.0, right: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Top Sale Products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  ProductItem(
                    imageUrl: 'https://via.placeholder.com/150',
                    productName: 'Product 1',
                    brandName: 'Brand 1',
                    price: '\$100',
                  ),
                  ProductItem(
                    imageUrl: 'https://via.placeholder.com/150',
                    productName: 'Product 2',
                    brandName: 'Brand 2',
                    price: '\$200',
                  ),
                  ProductItem(
                    imageUrl: 'https://via.placeholder.com/150',
                    productName: 'Product 3',
                    brandName: 'Brand 3',
                    price: '\$300',
                  ),
                  // Add more ProductItem widgets as needed
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/view_more');
                },
                child: const Text(
                  'View More',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String brandName;
  final String price;

  const ProductItem({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.brandName,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 24,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(brandName),
                    Text(
                      price,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, '/product_details');
              },
            ),
          ),
        ],
      ),
    );
  }
}
