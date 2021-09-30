import 'package:flutter/material.dart';
class AlarafLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        color: Colors.black,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
