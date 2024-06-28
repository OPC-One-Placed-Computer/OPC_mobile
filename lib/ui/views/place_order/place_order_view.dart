import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

import 'place_order_viewmodel.dart';

class PlaceOrderView extends StackedView<PlaceOrderViewModel> {
  const PlaceOrderView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PlaceOrderViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Placed Orders',
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 44, 45, 114),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on, color: Colors.black, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Delivery address',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.person, color: Colors.black, size: 15),
                        const SizedBox(width: 8),
                        Text(
                          'Fullname',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        initialValue:
                            'User 1', // Replace with the actual full name
                        enabled: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: AddressField(), // Use the AddressField widget
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.info, color: Colors.black, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Product Summary',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                padding: const EdgeInsets.all(10),
                height: 130,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          const Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'ASUS M3402WAFAK (90PT03L2-M00KL0) All-In-One Desktop',
                            maxLines: 2,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 33),
                          Text(
                            '\$50.00',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Quantity: 1',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_shipping,
                      color: Colors.black, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Shipping Option',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      'Cash on Delivery (COD)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.money, color: Colors.black, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Payment Details',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Padding(
                padding:
                    EdgeInsets.only(left: 28.0), // Adjust the value as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total payment:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          ' \$ 325.00', // Placeholder for total payment
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle),
                        const SizedBox(width: 4),
                        Text(
                          ' Place Order',
                          style: GoogleFonts.poppins(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  PlaceOrderViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PlaceOrderViewModel();
}

class AddressField extends StatefulWidget {
  @override
  _AddressFieldState createState() => _AddressFieldState();
}

class _AddressFieldState extends State<AddressField> {
  bool _isEditable = false;
  final TextEditingController _addressController = TextEditingController(
      text: 'Carmen ,Bohol'); // Replace with the actual address

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.home, color: Colors.black, size: 15),
            const SizedBox(width: 8),
            const Text(
              'Address',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(_isEditable ? Icons.check : Icons.edit,
                  color: Colors.black, size: 15),
              onPressed: () {
                setState(() {
                  _isEditable = !_isEditable;
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: _addressController,
            enabled: _isEditable,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            ),
          ),
        ),
      ],
    );
  }
}
