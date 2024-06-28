import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:stacked/stacked.dart';

import 'add_to_cart_viewmodel.dart';

class AddToCartView extends StackedView<AddToCartViewModel> {
  const AddToCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddToCartViewModel>.reactive(
      viewModelBuilder: () => AddToCartViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 15.0, right: 8.0, bottom: 8.0),
                          child: Text(
                            'Shopping Cart',
                            style: GoogleFonts.poppins(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          padding: const EdgeInsets.all(10),
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
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
                                child: const Icon(Icons.image,
                                    size: 50, color: Colors.grey),
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
                                    const SizedBox(height: 9),
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
                                    Row(
                                      children: [
                                        IconButton(
                                          iconSize: 16,
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {},
                                        ),
                                        Text('1', style: GoogleFonts.poppins()),
                                        IconButton(
                                          iconSize: 16,
                                          icon: const Icon(Icons.add),
                                          onPressed: () {},
                                        ),
                                        const SizedBox(width: 20),
                                        Transform.scale(
                                          scale: 0.8,
                                          child: Checkbox(
                                            value: true,
                                            onChanged: (bool? value) {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub Total Item(s)',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '1',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub Total',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '\$100.00',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shipping',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '\$10.00',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$110.00',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              viewModel.navigationService
                                  .navigateTo(Routes.place_order);
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.shopping_cart),
                                const SizedBox(width: 4),
                                Text(
                                  'Check Out',
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
            ],
          ),
        );
      },
    );
  }

  @override
  Widget builder(
      BuildContext context, AddToCartViewModel viewModel, Widget? child) {
    // TODO: implement builder
    throw UnimplementedError();
  }

  @override
  AddToCartViewModel viewModelBuilder(BuildContext context) {
    // TODO: implement viewModelBuilder
    throw UnimplementedError();
  }
}
