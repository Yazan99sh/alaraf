import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlarafActivityInfo extends StatelessWidget {
  final String title;
  final String imageUrl;

  const AlarafActivityInfo({Key key, this.title, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 4,
      height: size.height / 4.25,
      color: Color(0xFFA267A6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("$imageUrl"),
          Padding(
            padding: const EdgeInsets.only(right: 2, left: 2),
            child: AutoSizeText(
              "${title}",
              maxLines: 1,
              style: TextStyle(
                  fontFamily: "Hacen",
                  fontSize: ScreenUtil().setSp(64),
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
