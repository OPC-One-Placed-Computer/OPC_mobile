import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'success_message_viewmodel.dart';

class SuccessMessageView extends StatefulWidget {
  const SuccessMessageView({Key? key}) : super(key: key);

  @override
  _SuccessMessageViewState createState() => _SuccessMessageViewState();
}

class _SuccessMessageViewState extends State<SuccessMessageView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    Timer(const Duration(seconds: 3), () {
      _controller.stop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SuccessMessageViewModel>.reactive(
      viewModelBuilder: () => SuccessMessageViewModel(),
      onViewModelReady: (viewModel) => viewModel.handleNavigation(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Cash on Delivery',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          body: Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    child: Lottie.asset(
                      'lib/resources/images/success.json',
                      fit: BoxFit.cover,
                      controller: _controller,
                      onLoaded: (composition) {
                        _controller
                          ..duration = composition.duration
                          ..forward();
                      },
                    ),
                  ),
                  Text(
                    'Placed Order Successful',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.green,
                      fontSize: 38,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your Placed Order was successful. Thank you for your order!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
