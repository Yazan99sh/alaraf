import 'package:alaraf/core/widget/two_type_button.dart';
import 'package:alaraf/data/util_data.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
class FortuneTeller extends StatelessWidget {
  final String name;
  final num point;
  final double price;
  final String imageUrl;
  final Function function;
  final int status;
  final Function() sendCall;

  const FortuneTeller({Key key, this.name, this.point, this.price, this.imageUrl,this.function,this.status,this.sendCall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return   Container(
      width: size.width * 0.75,
      height: size.height * 0.15 + (price == -1 && status == 1 ? size.height* 0.07 : 0),
      child: InkWell(
        onTap: (){
            function();
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: size.height * 0.03 / 2,
                    right: size.width * 0.1,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8),
                      child: Container(
                        height: size.height * 0.12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)),
                            color: Colors.white),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 10,),
                            if(price == -1)
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("${locator<TranslateService>().selectedLanguageValue[UtilData.status[status]]}",style: TextStyle(color: Colors.black54),),
                              ),
                            if(price != -1)
                              Container(
                                transform: Matrix4.translationValues(0, -size.height * 0.15 /6, 0),
                                height: size.height * 0.13,
                                child: Stack(

                                  children: [


                                    Positioned(
                                      top: size.height * 0.12 /6,
                                      right: size.height * 0.04/3/2  ,
                                      child: Container(
                                        height: size.height * 0.12 /3 + size.height * 0.12 /6,
                                        width: size.height * 0.11 /3,
                                        color: Color(0xFFad62aa),
                                        child: Column(
                                          children: [
                                            Expanded(child: SizedBox(),),
                                            Container(
                                                width: size.height * 0.11 /3,
                                                child: AutoSizeText("$price",minFontSize: 6,maxLines:1,style: TextStyle(fontFamily: "Hacen",color: Colors.white),)),
                                          ],

                                        ),

                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Text("$status"),
                                    ),
                                    Image.asset("assets/images/coin.png",width: size.height * 0.15 /3,),
                                  ],
                                ),
                              ),

                            Expanded(child: Container(
                                height: size.height * 0.13,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AutoSizeText("${name}",maxLines: 1,textAlign: TextAlign.end,style: TextStyle(
                                      color: Color(0xFF413c69),
                                      fontSize: ScreenUtil().setSp(42),
                                    ),),
                                    Padding(
                                      padding:  EdgeInsets.only(left:size.width * 0.17),
                                      child: Container(
                                        height: 1,
                                        color: Color(0xFFad62aa),
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        Expanded(child: SizedBox(),),
                                        Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  for(int i = 0 ; i < point.floor()-1 ; i++)
                                                    Icon(Icons.star,color: Color(0xFFedb462),),
                                                ],
                                              ),
                                              Text("$point",style: TextStyle(color: Color(0xFFedb462),fontFamily: "Hacen"),),

                                            ],
                                          ),
                                        )
                                      ],
                                    )



                                  ],
                                ))),
                            SizedBox(width: size.width * 0.14,),
                          ],
                        ),
                      ),

                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      width: size.width * 0.25,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                "$imageUrl",
                              ),
                              fit: BoxFit.cover
                          ),
                          border: Border.all(
                            color: Color(0xFF853782),
                            width: 8,
                          ),
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            if(price == -1 && status == 1)
            TwoTypeButton(title: locator<TranslateService>().selectedLanguageValue[StringKeys.str_call_expert],
            onPressedFunc: sendCall,
            ),
            
          ],
        ),
      ),
    );
  }
}
