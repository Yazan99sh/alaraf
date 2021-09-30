import 'package:alaraf/future/alaraf_user_activity_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void openSocialSituationSelector(BuildContext context,AlarafUserActivityViewModel model){
  showDialog(context: context, builder: (_)=>AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for(String selector in model.socialSituations)
          ListTile(
            onTap: (){
              model.changeSocialSituation(model.socialSituations.indexOf(selector));
              Navigator.pop(context);
            },
            leading: CircleAvatar(backgroundColor: Colors.purple.withOpacity(0.9 - model.socialSituations.indexOf(selector)/10),),
            title: Text(selector),
          )
      ],
    ),
  ));
}