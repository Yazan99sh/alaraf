import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class GenericTextField extends StatelessWidget {
  final String title;
  final int maxLines;
  final String hintText;
  final TextEditingController controller;
  final bool titleVisible;
  final Function onTap;

  const GenericTextField(
      {Key key,
      this.title,
        this.onTap,
        this.controller,
      this.maxLines,
      this.hintText,
      this.titleVisible = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget baseWidget ({child})=> onTap != null ? InkWell(onTap: (){ onTap();},child: child,)  : Container(child: child,);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: Visibility(
            visible: titleVisible,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                titleVisible == false ? "" : title,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontFamily: "Hacen",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: baseWidget(
                child: TextField(
                  controller: controller,
                    enabled: onTap == null,
                  maxLines: maxLines,
                  decoration: InputDecoration.collapsed(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(32),
                      fontFamily: "Hacen",
                      color: Color(0xffad62aa),
                    ),
                  ),
                  cursorColor: Colors.black,
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
