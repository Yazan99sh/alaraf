import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TitleText extends StatelessWidget {
  final String label;
  final bool isPurple;
  final bool isWeb ;

  const TitleText({Key key, this.label, this.isPurple = false,this.isWeb= false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: TextStyle(
            color: isPurple ? Color(0xFF3F3D66) : Colors.white,
            fontSize: ScreenUtil().setSp(isWeb ? 36 : 64),
            fontFamily: "Hacen"));
  }
}
