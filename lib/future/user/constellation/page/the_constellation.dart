import 'package:alaraf/core/widget/alaraf_activity_info.dart';
import 'package:alaraf/core/widget/alaraf_background.dart';
import 'package:alaraf/core/widget/alaraf_generic_textfield.dart';
import 'package:alaraf/core/widget/alaraf_image_upload.dart';
import 'package:alaraf/core/widget/alaraf_indicator.dart';
import 'package:alaraf/core/widget/alaraf_multi_image_uplad.dart';
import 'package:alaraf/core/widget/alaraf_segmented.dart';
import 'package:alaraf/core/widget/alaraf_voice_widget.dart';
import 'package:alaraf/core/widget/bottom_picker.dart';
import 'package:alaraf/core/widget/two_type_button.dart';
import 'package:alaraf/future/alaraf_user_activity_view_model.dart';
import 'package:alaraf/future/user/shared/widget/acitvity_form.dart';
import 'package:alaraf/future/user/shared/widget/social_situation_selector.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';



class TheConstellation extends StatefulWidget {
  @override
  _TheConstellationState createState() => _TheConstellationState();
}

class _TheConstellationState extends State<TheConstellation> {
  var val = AlarafUserActivityViewModel();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;
    return ChangeNotifierProvider<AlarafUserActivityViewModel>.value(
      value: val,
      child: Consumer<AlarafUserActivityViewModel>(
        builder: (_,model,__){
          return  Scaffold(
              key:model.key,
              body: Builder(
                builder: (c) => GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: AlarafBackground(
                    child: Padding(
                      padding: MediaQuery.of(context).padding,
                      child:Stack(
                        children: [

                          Column(
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
                                      title:
                                      "${translate[StringKeys.str_constellations]}",
                                      imageUrl: "assets/images/activity/star.png",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AlarafAcitvityForm(model: model,acitivtyType: 7,translate: translate,),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),

                          if(model.isLoading)
                            AlarafIndicator(isDone: model.isDone,isLoading: model.isLoading,)
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },

      ),
    );
  }
}
