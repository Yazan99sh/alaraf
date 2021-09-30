import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/activity/model/alaraf_activity.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/strings.dart';
import 'package:flutter/material.dart';

enum AdminPage {
  fortuneTeller,
  user_info,
  activity,
  activity_list,
  activity_detail,
  add_expert_activity,
  income,
}
enum ActionType{
  user,
  expert
}

class AdminViewModel extends ChangeNotifier {
  bool isLoading = false;
  AdminPage page;
  var alarafService = locator<AlarafApiService>();
  var selectedUser;
  List<AlarafUser> allUser;
  List<AlarafUser> allUserTemp;
  List<AlarafActivity> alarafActivity;
  ActionType actionType;
  int selectedExpertId;

  void changePage(AdminPage page,{int expertId}) async {
    isLoading = true;
    notifyListeners();
    if (page == AdminPage.fortuneTeller || page == AdminPage.user_info || page == AdminPage.income || page == AdminPage.activity) {
      var result = await alarafService.getAllAralafUser();
      allUser = result;
      allUserTemp = [...allUser];
    }
    else if(page == AdminPage.add_expert_activity){
      selectedExpertId = expertId;
    }

    this.page = page;
    isLoading = false;
    notifyListeners();
  }

  updateUserType(int type, int id) {
    alarafService.updateUserType(type, id).then((value) {
      allUser.firstWhere((element) => element.id == id).userType = type;
      notifyListeners();
    });
  }

  goDetail(AlarafUser user,BuildContext context) async {
    selectedUser = user;
    page = AdminPage.activity_detail;
    actionType  =  await showActionTypeSelector(context);
    alarafActivity =  user.userType == 1
        ? await alarafService.getUserActivity(user.id)
        : await alarafService.getFortunerActivity(user.id);
    notifyListeners();
  }
  String getSocialSituation(Map translate,AlarafActivity activity) {
    var temp =  [
      translate[StringKeys.str_single],
      translate[StringKeys.str_divorced],
      translate[StringKeys.str_widower],
      translate[StringKeys.str_separated],
      translate[StringKeys.str_linked],
      translate[StringKeys.str_married],
    ];
    return temp[activity.socialSituation];

  }

  searchUser(String a) {
    allUser = allUserTemp.where((element) => element.userName.contains('$a')).toList();
    notifyListeners();

  }

  changeActivityStatus(AlarafActivity activity) async{
    await alarafService.updateActivityState(activity.id, !activity.activated);
    activity.activated = !activity.activated;
    notifyListeners();
  }
  showActionTypeSelector(BuildContext context){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (_)=>AlertDialog(
          title: Text('Select Action Type'),
          content:Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            TextButton.icon(onPressed: (){
              return Navigator.pop(context,ActionType.user);
            }, icon: Icon(Icons.person), label: Text('User To Expert')),
            TextButton.icon(onPressed: (){
              return Navigator.pop(context,ActionType.expert);
            }, icon: Icon(Icons.supervised_user_circle), label: Text('Expert To User')),
          ],) ,

        )

    );
  }

  changeUserRejectStatus(AlarafActivity activity) async {
    await alarafService.updateRejectState(activity.id, !activity.rejected);
    activity.rejected = !activity.rejected;
    notifyListeners();
  }

  changeAllowedForExpert(AlarafActivity activity,BuildContext context) async{
     var result = await getActivityExpertPrice(context);
     print('${result} reslute');
     if(result != null){
       print("${result} * * ");
       await alarafService.updateExpertActiveState(activity.id, !activity.allowedForEXpert);
       activity.allowedForEXpert = !activity.allowedForEXpert;
       notifyListeners();
     }

  }
  changeRejectStatusForExpert(AlarafActivity activity) async{
    await alarafService.updateExpertMessageRejectState(activity.id, !activity.rejectedForEXpert);
    activity.rejectedForEXpert = !activity.rejectedForEXpert;
    notifyListeners();
  }
  Future<dynamic> getActivityExpertPrice(BuildContext context){
    var txtController = TextEditingController();
    return showDialog(context: context, builder: (_)=>AlertDialog(content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
          Text('Enter price of expert'),
          TextField(controller: txtController,),
          SizedBox(),
          OutlinedButton(onPressed: (){
            Navigator.pop(context,txtController.text);
          }, child: Text('Done')),
      ],
    ),));
  }
}
