import 'package:alaraf/core/widget/alaraf_generic_textfield.dart';
import 'package:alaraf/core/widget/alaraf_voice_widget.dart';
import 'package:alaraf/future/admin/view_model/admin_view_model.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityDetail extends StatelessWidget {
  final AdminViewModel model;

  const ActivityDetail({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;
    showDialogImg(url) {
      showDialog(
          context: context,
          builder: (c) => Dialog(
                child: Image.network(url),
              ));
    }

    return GridView.builder(
        itemCount: model.alarafActivity.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        itemBuilder: (c, i) {
          var activity = model.alarafActivity[i];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Colors.white.withOpacity(0.8),
                elevation: 3,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate[StringKeys.str_date_of_birth],
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          ),
                          Text(
                            activity.dateOfBirth.toString().substring(0, 10),
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate[StringKeys.str_forename],
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          ),
                          Text(
                            activity.forename,
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate[StringKeys.str_mothers_name],
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          ),
                          Text(
                            activity.motherName,
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate[StringKeys.str_sex],
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          ),
                          Text(
                            activity.sex == 0
                                ? translate[StringKeys.str_male]
                                : translate[StringKeys.str_female],
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate[StringKeys.str_social_situation],
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          ),
                          Text(
                            model.getSocialSituation(translate, activity),
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate[StringKeys.str_written_letter],
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          ),
                          Container(
                              constraints:
                                  BoxConstraints(maxWidth: size.width * 0.4),
                              child: Text(
                                activity.writenLetter,
                                style: TextStyle(
                                    color: Colors.black, fontFamily: "Hacen"),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate[StringKeys.str_img],
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          ),
                          Container(
                              constraints:
                                  BoxConstraints(maxWidth: size.width * 0.4),
                              child: Wrap(
                                children: activity.allImage
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () => showDialogImg(
                                                "${model.alarafService.serverUrl}/image?id=$e"),
                                            child: Container(
                                              height: size.width * 0.05,
                                              width: size.width * 0.05,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "${model.alarafService.serverUrl}/image?id=$e")),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  border: Border.all(
                                                      color: Colors.black54,
                                                      width: 2)),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate[StringKeys.str_voice_message],
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          ),
                          Container(
                              constraints:
                                  BoxConstraints(maxWidth: size.width * 0.3),
                              child: VoiceMessage(
                                url:
                                    "${model.alarafService.serverUrl}/activity/record?id=${activity.id}&isAnswer=false",
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate[StringKeys.str_voice_message],
                            style: TextStyle(
                                color: Colors.black, fontFamily: "Hacen"),
                          ),
                          Container(
                              constraints:
                                  BoxConstraints(maxWidth: size.width * 0.3),
                              child: VoiceMessage(
                                url:
                                    "${model.alarafService.serverUrl}/activity/record?id=${activity.id}&isAnswer=true",
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
                      child: Text(
                        translate[StringKeys.str_response],
                        style:
                            TextStyle(color: Colors.black, fontFamily: "Hacen"),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: GenericTextField(
                          maxLines: 3,
                          controller: TextEditingController(
                              text: '${activity.answerOfFortuner}'),
                          titleVisible: false,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    if(model.actionType == ActionType.user)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () => model.changeActivityStatus(activity),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '${activity.activated ? 'De-Active' : 'Active'}'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () => model.changeUserRejectStatus(activity),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '${activity.rejected ? 'Not-Reject' : 'Reject  '}'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if(model.actionType == ActionType.expert)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () => model.changeAllowedForExpert(activity,context),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${activity.allowedForEXpert ? 'Un-Approved' : 'Approve'}'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () => model.changeRejectStatusForExpert(activity),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${activity.rejected ? 'Not-Reject' : 'Reject  '}'),
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
