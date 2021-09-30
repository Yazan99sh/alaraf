import 'package:flutter/material.dart';

class AlarafBackground extends StatelessWidget {
  final Widget child;

  const AlarafBackground({Key key, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
      child: child,
    );
  }
}
