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
              height: 200, // Adjust the height according to your needs
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 370.0,
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
                    width: 370.0,
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
                    width: 370.0,
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
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
            const Center(
              child: Text('Home View'),
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(brandName),
                    Text(
                      price,
                      style: TextStyle(color: Colors.green),
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
              icon: Icon(Icons.shopping_cart),
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
