import 'package:flutter/material.dart';
class AlarafIndicator extends StatelessWidget {
  final bool isLoading;
  final bool isDone;

  const AlarafIndicator({Key key, this.isLoading, this.isDone = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: Container(
        color: Colors.black,
        child: isLoading ? Center(
          child: isDone ? Image.asset("assets/images/shadow.png",width: 100,) : CircularProgressIndicator(),
        ) : SizedBox(),
      ),

    );
  }
}
