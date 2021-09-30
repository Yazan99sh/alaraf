import 'package:alaraf/core/widget/alaraf_background.dart';
import 'package:alaraf/core/widget/alaraf_top_info.dart';
import 'package:alaraf/core/widget/one_typed.dart';
import 'package:alaraf/data/util_data.dart';
import 'package:alaraf/future/activity/view_model/activity_view_model.dart';
import 'package:alaraf/future/activity/widget/activity_item.dart';
import 'package:alaraf/future/fortune_select/model/fortuner_ability.dart';
import 'package:alaraf/future/fortune_teller/fortune_ability/view_model/fortune_ability_view_model.dart';
import 'package:alaraf/future/fortune_teller/fortune_home/widget/fortune_home_item.dart';
import 'package:alaraf/future/profile/widget/bar_item.dart';
import 'package:alaraf/future/profile/widget/point_area.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class FortuneAbility extends StatefulWidget {
  final int expertId;
  const FortuneAbility({Key key, this.expertId}) : super(key: key);
  @override
  _FortuneAbilityState createState() => _FortuneAbilityState();
}

class _FortuneAbilityState extends State<FortuneAbility> {
  var val;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    val = FortuneAbilityViewModel(widget.expertId);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var navigationService = locator<NavigationService>();
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: AlarafBackground(
          child: Padding(
            padding: MediaQuery.of(context).padding,
            child: ChangeNotifierProvider<FortuneAbilityViewModel>.value(
              value: val,
              child: Consumer<FortuneAbilityViewModel>(
                builder: (_,model,__){

                  return model.isLoading ? Center(child: CircularProgressIndicator(),)  : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      AlarafTopInfo(back: translate[StringKeys.str_back],page: translate[StringKeys.str_ability],),
                      SizedBox(height: 20,),
                      for(String ability in UtilData.activityName)
                        ListTile(
                          leading: Checkbox(
                            value: model.fortuneAbility.map((e) => e.activityTypeId).toList().contains(UtilData.activityName.indexOf(ability)+1),
                            onChanged: (a) async{
                              if(a){
                                TextEditingController controller = TextEditingController();
                                var result = await showDialog<String>(
                                    context: context, builder: (_)=>AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(translate[StringKeys.str_price],style: TextStyle(fontFamily: "Hacen",color: Colors.black),),
                                      TextField(
                                        keyboardType: TextInputType.number,

                                        controller: controller,
                                      ),
                                      SizedBox(height: 20,),
                                      OneTypedButton(
                                        onPressed: (){
                                          Navigator.pop(context,controller.text);
                                        },
                                        title: translate[StringKeys.str_send],
                                      ),
                                    ],
                                  ),
                                ));
                                if(result != null)
                                model.changeAbilityStatus(a,UtilData.activityName.indexOf(ability)+1,price: int.parse(result));
                              }
                              else{
                                model.changeAbilityStatus(a,UtilData.activityName.indexOf(ability)+1);
                              }
                            },
                          ),
                          title:   Text(translate[ability],style: TextStyle(fontFamily: "Hacen",color: Colors.white),),

                        ),

                      SizedBox(height: 20,),


                    ],
                  );
                },
              )
            ),
          ),
        ),
      ),
    );
  }}

