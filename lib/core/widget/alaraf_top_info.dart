import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AlarafTopInfo extends StatelessWidget {
  final String back;
  final String page;
  final String customBackRoute;

  const AlarafTopInfo({Key key, this.back, this.page,this.customBackRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * (kIsWeb ? 0.2 : 0.65),
      decoration: BoxDecoration(
          color: Color(0xFFA367A6),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5), bottomRight: Radius.circular(5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              if(customBackRoute != null)
                locator<NavigationService>().navigateTo(customBackRoute);
                else
              locator<NavigationService>().goBack();
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "$back",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Hacen",
                    fontSize: ScreenUtil().setSp(kIsWeb ? 12: 40)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              "$page",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Hacen",
                  fontSize: ScreenUtil().setSp(kIsWeb ? 12:  40)),
            ),
          )
        ],
      ),
    );
  }
}
