import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class OneTypedButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final bool isWeb;

  OneTypedButton({this.onPressed, this.title,this.isWeb = false});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        if (onPressed != null) onPressed();
      },
      color: Color(0xFFad62aa),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06),
        child: Text(
          "$title",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Hacen",
              fontSize: ScreenUtil().setSp(isWeb ? 20 : 40)),
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
