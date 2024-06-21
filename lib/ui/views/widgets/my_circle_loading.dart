import 'package:flutter/material.dart';

class MyCircleLoading extends StatelessWidget {
  const MyCircleLoading({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? const Color.fromARGB(255, 2, 0, 60),
      ),
    );
  }
}
