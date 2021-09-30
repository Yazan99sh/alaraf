import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityItem extends StatelessWidget {
  final bool dLeft;
  final bool dTop;
  final String imageUrl;

  final String title;
  final Function onTap;

  const ActivityItem(
      {this.onTap,
      this.imageUrl,
      this.title,
      Key key,
      this.dLeft = false,
      this.dTop = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width * 0.35,
        height: size.width * 0.35,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Color(0xFF403D66), width: 3),
            left: BorderSide(
                color: Color(0xFF403D66), width: dLeft ? 0 : 3),
            bottom: BorderSide(color: Color(0xFF403D66), width: 3),
            top: BorderSide(
                color: Color(0xFF403D66), width: dTop ? 0 : 3),
          ),
        ),
        child: Stack(
          children: [
            Container(
                width: size.width * 0.35,
                height: size.width * 0.35,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        "$imageUrl",
                        fit: BoxFit.fitHeight,
                      )),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutoSizeText(
                        "$title",
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontFamily: "Hacen",
                            fontSize: ScreenUtil().setSp(40)),
                      ),
                    )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        "$imageUrl",
                        fit: BoxFit.cover,
                        scale: 2,
                      )),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
