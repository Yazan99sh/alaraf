import 'package:alaraf/core/widget/alaraf_background.dart';
import 'package:alaraf/core/widget/alaraf_top_info.dart';
import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/activity/model/alaraf_activity.dart';
import 'package:alaraf/future/fortune_teller/fortuner_message/view_model/fortuner_message_view_model.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/future/user/phone_call/page/phone_call.dart';
import 'package:alaraf/future/user/user_message/view_model/user_message_view_model.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class UserMessage extends StatefulWidget {
  @override
  _UserMessageState createState() => _UserMessageState();
}

class _UserMessageState extends State<UserMessage> {
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
            child: ChangeNotifierProvider<UserMessageViewModel>.value(
              value: UserMessageViewModel(),
              child:
              Consumer<UserMessageViewModel>(builder: (_, model, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            width: size.width * .5,
                            child:
                            Image.network("${locator<AlarafApiService>().serverUrl}/image?id=${locator<AlarafUser>().pictureUrl}"),
                          ),
                        ),
                        AlarafTopInfo(
                          back: translate[StringKeys.str_back],
                          page: translate[StringKeys.str_message],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (model.isLoading)
                      Expanded(
                        child: Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    else ...[
                      Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.all(8),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  FilterChip(
                                    avatar: model.messageType == MessageType.answered ?  Icon(Icons.circle,color: Color(0xffad62aa)  ): null ,
                                    showCheckmark:false,label: Text(translate[StringKeys.str_answered]), onSelected: (a){
                                      model.updateMessageType(MessageType.answered);
                                  },selected: model.messageType == MessageType.answered ? true : false),
                                  FilterChip(
                                    avatar:  model.messageType == MessageType.not_answered ?  Icon(Icons.circle,color: Color(0xffad62aa),) : null ,
                                    showCheckmark:false,label: Text(translate[StringKeys.str_not_answered]), onSelected: (a){
                                    model.updateMessageType(MessageType.not_answered);
                                  },selected: model.messageType == MessageType.not_answered ? true : false),
                                  FilterChip(
                                      avatar:  model.messageType == MessageType.rejected ?  Icon(Icons.circle,color: Color(0xffad62aa),) : null ,
                                      showCheckmark:false,label: Text(translate[StringKeys.str_rejected]), onSelected: (a){
                                    model.updateMessageType(MessageType.rejected);
                                  },selected: model.messageType == MessageType.rejected ? true : false),
                             



                                ],
                              ),

                            ],
                          )),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Color(0xffad62aa).withOpacity(0.5),
                              ),
                              width: size.width * .85,
                              child: ListView.builder(
                                  itemCount: model.allActivity.length,
                                  itemBuilder: (c,i){
                                    AlarafActivity activity = model.allActivity[i];
                                    return Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: size.width * 0.05),
                                      child: Column(

                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("${activity.alarafUser.name} ${activity.alarafUser.surname}",style: TextStyle(color: Colors.white,fontFamily: "Hacen"),),
                                          InkWell(
                                            onTap: ()=>model.goDetail(activity),
                                            child: Container(
                                              height:100,
                                              width:size.width * .80,
                                              decoration: BoxDecoration(
                                                color:Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),


                                              ),
                                              child: Stack(
                                                children: [
                                                  if(activity.isAnswered)
                                                    Container(
                                                        transform: Matrix4.translationValues(-20, -10, 0),
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(12.0),
                                                          child: Text(translate[StringKeys.str_new],style: TextStyle(color: Colors.white),),
                                                        )),
                                                  Positioned(
                                                    left: 0,
                                                    right: 0,
                                                    top: 0,
                                                    bottom: 0,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Text(translate[model.getType(activity.fortuneTypeId)],style: TextStyle(fontFamily: "Hacen"),),
                                                          Text(translate[StringKeys.str_read],style: TextStyle(fontFamily: "Hacen"),)

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      )
                    ]
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
