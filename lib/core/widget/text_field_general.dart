import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TextFieldGeneral extends StatelessWidget {
  final Color theColor;
  final String label;
  final Function onChanged;
  final bool isRtl;
  final bool isObsecure;
  final Function onTap;
  final TextEditingController textEditingController;
  final bool isWeb;
  final int maxLine;

  TextFieldGeneral(
      {this.label,
        this.isWeb = false,
      this.theColor = Colors.white,
      this.onChanged,
      this.isRtl = false,
        this.onTap,
      this.isObsecure = false,
        this.maxLine = 1,
        this.textEditingController ,
      });
  Widget getWrapper({Widget child}) => onTap == null ? child : InkWell(onTap: ()=>onTap(),child: child,);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.075),
      child: getWrapper(
        child: TextField(

          controller: textEditingController == null ? TextEditingController() : textEditingController,
          obscureText: isObsecure,
          enabled: onTap == null,
          maxLines: maxLine,
          onChanged: (a) {
            if (onChanged != null) onChanged(a);
          },
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Tcm",
              fontSize: ScreenUtil().setSp(isWeb ? 20 : 40)),
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          decoration: InputDecoration(

            labelText: "$label",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: theColor),
            ),
            labelStyle: TextStyle(
                color: Colors.white,
                fontFamily: "Tcm",
                fontSize: ScreenUtil().setSp(isWeb ? 20 : 40)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: theColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: theColor),
            ),
          ),
        ),
      ),
    );
  }
}
