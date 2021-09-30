import 'package:flutter/material.dart';

class BarItem extends StatelessWidget {
  final Function onTap;
  final String label;
  final String image;

  const BarItem({Key key, this.onTap, this.label, this.image});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkResponse(
          highlightColor: Colors.black.withOpacity(0.5),
          onTap: () {
            if (onTap != null) onTap();
          },
          child: Column(
            children: [
              Image.asset(
                "$image",
                height: size.height * 0.055,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "$label",
                style: TextStyle(
                    fontFamily: "Hacen", color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
