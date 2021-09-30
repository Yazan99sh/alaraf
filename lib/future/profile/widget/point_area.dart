import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:flutter/material.dart';

class PointArea extends StatelessWidget {
  final translate;
  final double point;

  PointArea(this.translate, this.point);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: ()=>locator<NavigationService>().navigateTo(Routes.buyGold),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFad62aa),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/coin.png",
                width: size.width * 0.10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                children: [
                  Text(
                    translate[StringKeys.str_coin],
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Hacen"),
                  ),
                  Text(
                    "$point",
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Hacen"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
