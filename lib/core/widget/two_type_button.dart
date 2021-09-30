import 'package:alaraf/future/activity/page/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TwoTypeButton extends StatelessWidget {
  final String title;
  final Function function;
  final Function onPressedFunc;

  const TwoTypeButton(
      {Key key, this.title, this.function, this.onPressedFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Color(0xFF853782),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      onPressed: () {
        if (onPressedFunc != null) {
          onPressedFunc();
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => Activity()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          "$title",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Hacen",
              fontSize: ScreenUtil().setSp(40)),
        ),
      ),
    );
  }
}
