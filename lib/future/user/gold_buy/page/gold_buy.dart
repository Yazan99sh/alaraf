import 'package:alaraf/core/widget/alaraf_activity_info.dart';
import 'package:alaraf/core/widget/alaraf_background.dart';
import 'package:alaraf/core/widget/alaraf_top_info.dart';
import 'package:alaraf/core/widget/one_typed.dart';
import 'package:alaraf/core/widget/two_type_button.dart';
import 'package:alaraf/future/fortune_teller/fortune_home/widget/fortune_home_item.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/future/user/gold_buy/view_model/gold_buy_view_model.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class GoldBuy extends StatefulWidget {
  @override
  _GoldBuyState createState() => _GoldBuyState();
}

class _GoldBuyState extends State<GoldBuy> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var navigationService = locator<NavigationService>();
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;
    return ChangeNotifierProvider<GoldBuyViewModel>.value(
      value: GoldBuyViewModel(),
      child: Consumer<GoldBuyViewModel>(builder: (_,model,__){
        return Scaffold(
          key: model.key,
          body: AlarafBackground(
            child: Padding(
              padding: MediaQuery.of(context).padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 30.0, left: 10),
                        child: Container(
                          child: TwoTypeButton(
                            title: "${translate[StringKeys.str_back]}",
                          ),
                        ),
                      ),
                      Center(
                        child: AlarafActivityInfo(
                          title: "${translate[StringKeys.str_buy_gold]}",
                          imageUrl: "assets/images/coin.png",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom:20.0),
                          child: Container(
                              width: size.width * 0.85,
                              decoration: BoxDecoration(
                                  color: Color(0xffad62aa).withOpacity(0.5),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(3),
                                  )),
                              child: GridView.builder(
                                  itemCount: model.products.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3.5/3), itemBuilder: (c,i){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Colors.white
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(),
                                        Image.asset("assets/images/coin.png"),
                                        InkWell(
                                          onTap: (){
                                            model.buyProduct(model.products[i]);
                                          },
                                          child: Container(
                                            transform: Matrix4.translationValues(0, 10, 0),
                                            decoration: BoxDecoration(
                                                color: Color(0xFF7B3D7E),
                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Text('Gold ${model.products[i].title.split(" ").toList()[1]}',style: TextStyle(color: Colors.white,fontFamily: "Hacen"),),
                                            ),

                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                );
                              })
                          ),
                        ),
                      )),

                ],
              ),
            ),
          ),
        );
      }),
    );
  }

}

