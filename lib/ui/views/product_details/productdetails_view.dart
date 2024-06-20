import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'productdetails_viewmodel.dart';

class ProductdetailsView extends StatelessWidget {
  const ProductdetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductdetailsViewModel>.reactive(
      viewModelBuilder: () => ProductdetailsViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Product Details'),
            backgroundColor: Colors.blue,
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40), // Space above "Product 1"
                  const Text(
                    'Product 1',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Space between "Product 1" and image
                  Container(
                    width: double.infinity,
                    height: 200, // adjust as per your image aspect ratio
                    color: Colors.grey[300], // placeholder color
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Space between image and details
                  const Text(
                    'ACER Nitro 5 AN515-58-50YE GeForce RTX™ 3050 Intel® Core™ i5 Laptop (Obsidian Black)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Specification:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'ACER NITRO5 AN515-58-50YE OBSIDIAN BLACK INTEL CORE I5 12500H/8GB DDR4/512GB M.2 NVME PCIE SSD/NVIDIA GEFORCE RTX3050 4GB GDDR6/15.6" FHD IPS 144HZ/WINDOWS 11 HOME SL 64BIT/WEBCAM/BACKLIT KB/WIFI/BT/LAN/AUDIO PORT/USB 3.0/USB TYPE-C/HDMI/LAPTOP',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Price: \$999.99',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green, // example color
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Space before quantity incrementer
                  const QuantityIncrementer(),
                  const SizedBox(
                      height: 100), // Additional space at the bottom for safety
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class QuantityIncrementer extends StatelessWidget {
  const QuantityIncrementer({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductdetailsViewModel>.reactive(
      builder: (context, viewModel, child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: viewModel.decrementQuantity,
              ),
              const SizedBox(width: 20),
              Text(
                viewModel.quantity.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: viewModel.incrementQuantity,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Purchase'),
                    onPressed: () {
                      // Handle purchase logic here
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Product ID: 34565433', // Placeholder for product ID
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      viewModelBuilder: () => ProductdetailsViewModel(),
    );
  }
}
