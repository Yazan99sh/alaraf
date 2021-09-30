import 'package:alaraf/core/widget/alaraf_activity_info.dart';
import 'package:alaraf/core/widget/alaraf_background.dart';
import 'package:alaraf/core/widget/two_type_button.dart';
import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/data/util_data.dart';
import 'package:alaraf/future/fortune_select/model/fortuner_ability.dart';
import 'package:alaraf/future/fortune_select/view_model/fortuner_select_view_model.dart';
import 'package:alaraf/future/fortune_select/widget/fortune_teller_card.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FortuneSelect extends StatefulWidget {
  final int activityId;

  const FortuneSelect({Key key, this.activityId}) : super(key: key);
  @override
  _FortuneSelectState createState() => _FortuneSelectState();
}

class _FortuneSelectState extends State<FortuneSelect> {
  var vm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vm = FortunerSelectViewModel(widget.activityId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
            child: Column(
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
                          onPressedFunc: ()=>Navigator.pop(context),

                        ),
                      ),
                    ),
                    Center(
                      child: AlarafActivityInfo(
                        title:
                            "${translate[StringKeys.str_fortune_teller]}",
                        imageUrl:
                            "assets/images/activity/telescope.png",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Center(
                    child: Container(
                        width: size.width * 0.85,
                        decoration: BoxDecoration(
                            color: Color(0xffad62aa).withOpacity(0.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            )),
                        child: ChangeNotifierProvider<FortunerSelectViewModel>.value(
                          value: vm,
                          child: Consumer<FortunerSelectViewModel>(
                            builder: (_,model,__){
                              return model.isLoading ? Center(child: CircularProgressIndicator(),) :
                              ListView.builder(
                                itemCount: widget.activityId == -1 ? model.allExpert.length :model.allFortuner.length,
                                itemBuilder: (c,i){
                                  FortunerAbility fortuner = widget.activityId == -1 ? FortunerAbility(
                                    alarafUser: model.allExpert[i]
                                  ):model.allFortuner[i];
                                  return Column(
                                    children: [
                                      FortuneTeller(

                                        function: ()=> Navigator.pop(context,fortuner),
                                        sendCall: ()=>locator<NavigationService>().navigateTo(Routes.voiceCall,args: fortuner.alarafUser),
                                        price: widget.activityId == -1 ? -1 :fortuner.price,
                                        name: "${fortuner.alarafUser.name} ${fortuner.alarafUser.surname}",
                                        status: fortuner.alarafUser.userStatus,
                                        point: 4.2,
                                        imageUrl:
                                        "${locator<AlarafApiService>().serverUrl}/image?id=${fortuner.alarafUser.pictureUrl}"
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
