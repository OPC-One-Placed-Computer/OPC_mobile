import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'startup_viewmodel.dart';
import 'dart:async';

class StartupView extends StatefulWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  _StartupViewState createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  bool animationFrozen = false;
  bool showSecondText = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      setState(() {
        animationFrozen = true;
      });
    });
    Timer(const Duration(seconds: 5), () {
      setState(() {
        showSecondText = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (viewModel) => SchedulerBinding.instance
          .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic()),
      builder: (context, viewModel, child) => Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200,
                  child: Lottie.asset(
                    'lib/resources/images/anim.json',
                    fit: BoxFit.cover,
                    animate: !animationFrozen,
                  ),
                ),
                TweenAnimationBuilder(
                  duration: const Duration(seconds: 2),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double opacity, child) {
                    return AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(seconds: 1),
                      child: child,
                    );
                  },
                  child: Text(
                    'One Place Computer',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: showSecondText ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    'Where high quality products are in one place',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
