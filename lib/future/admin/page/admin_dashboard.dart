import 'package:alaraf/core/util/country_data.dart';
import 'package:alaraf/core/widget/alaraf_generic_textfield.dart';
import 'package:alaraf/core/widget/alaraf_voice_widget.dart';
import 'package:alaraf/core/widget/one_typed.dart';
import 'package:alaraf/core/widget/title_text.dart';
import 'package:alaraf/future/admin/page/admin_activity_detail.dart';
import 'package:alaraf/future/admin/page/admin_user_info.dart';
import 'package:alaraf/future/admin/view_model/admin_view_model.dart';
import 'package:alaraf/future/admin/widget/admin_menu_item.dart';
import 'package:alaraf/future/fortune_teller/fortune_ability/page/fortune_ability.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Color(0xFFEBEDEF),
      body: ChangeNotifierProvider<AdminViewModel>.value(
        value: AdminViewModel(),
        child: Consumer<AdminViewModel>(
          builder: (_, model, __) {
            return Row(
              children: [
                Container(
                    width: 255,
                    color: Color(0xFF3E4B62),
                    child: Column(
                      children: [
                        Container(
                          color: Color(0xFF313C52),
                          width: 255,
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/shadow.png'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AdminMenuItem(
                          icons: Icons.supervised_user_circle,
                          title: 'Change User Role',
                          onTap: () =>
                              model.changePage(AdminPage.fortuneTeller),
                        ),
                        AdminMenuItem(
                          icons: Icons.person_search,
                          title: 'Look User Info',
                          onTap: () => model.changePage(AdminPage.user_info),
                        ),
                        AdminMenuItem(
                          icons: Icons.article,
                          title: 'Look User Activity',
                          onTap: () => model.changePage(AdminPage.activity),
                        ),
                        AdminMenuItem(
                          icons: Icons.wallet_travel,
                          title: 'Expert Income Info',
                          onTap: () =>
                              model.changePage(AdminPage.income),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 10,
                  child: Container(child: getPage(model.page, model)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  getPage(AdminPage page, AdminViewModel model) {
    var size = MediaQuery.of(context).size;
    print(model.alarafActivity);
    if (model.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (page == null) {
        return Container(color: Colors.white);
      }
      else if (page == AdminPage.add_expert_activity) {
        return FortuneAbility(expertId: model.selectedExpertId,);
      }
      else if (page == AdminPage.fortuneTeller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Search User'),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (a) => model.searchUser(a),
                      decoration: InputDecoration(
                        labelText: 'Type Mail',
                        hintText: 'Enter User Mail',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox())
              ],
            ),
            Expanded(
                child: GridView.builder(
                    itemCount: model.allUser.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 6),
                    itemBuilder: (c, i) {
                      var user = model.allUser[i];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: ListTile(
                            title: Text('${user.name} ${user.surname}'),
                            subtitle: Text(
                                'User Type: ${user.userType == 1 ? 'Client' : 'Expert'} '),
                            trailing: CupertinoSegmentedControl<int>(
                              children: {
                                1: Padding(
                                  child: Text('Client'),
                                  padding: EdgeInsets.all(8),
                                ),
                                2: Padding(
                                  child: Text('Expert'),
                                  padding: EdgeInsets.all(8),
                                ),
                              },
                              onValueChanged: (a) {
                                model.updateUserType(
                                    user.userType == 1 ? 2 : 1, user.id);
                              },
                              groupValue: user.userType,
                            ),
                          ),
                        ),
                      );
                    }))
          ],
        );
      } else if (page == AdminPage.activity) {
        return GridView.builder(
            itemCount: model.allUser.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 6),
            itemBuilder: (c, i) {
              var user = model.allUser[i];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: ListTile(
                    title: Text('${user.name} ${user.surname}'),
                    subtitle: Text(
                        'User Type: ${user.userType == 1 ? 'Client' : 'Fortune Teller'} '),
                    trailing: OutlinedButton(
                      onPressed: () => model.goDetail(user,context),
                      child: Text('See User Activity Detail'),
                    ),
                  ),
                ),
              );
            });
      } else if (page == AdminPage.activity_detail) {

        return ActivityDetail(model: model,);
      } else if (page == AdminPage.user_info) {
        return AdminUserInfo(model: model,);
      }else if (page == AdminPage.income) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Search User'),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (a) => model.searchUser(a),
                      decoration: InputDecoration(
                        labelText: 'Type Mail',
                        hintText: 'Enter User Mail',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox())
              ],
            ),
            Expanded(
                child: GridView.builder(
                    itemCount: model.allUser.where((element) => element.userType == 2).toList().length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 6),
                    itemBuilder: (c, i) {
                      var user = model.allUser.where((element) => element.userType == 2).toList()[i];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: ListTile(
                            title: Text('${user.name} ${user.surname}'),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: (){},
                                      child: Text('Look Income'),
                                    ),
                                  ),
                                  Expanded(child: SizedBox(),),
                                ],
                              ),
                            ),
                            trailing: Container(
                              width: 200,
                              child: Text(
                                  '${user.userName}\n${user.countryCode == 0 ? 'Turkey' : countryList.firstWhere((element) => element['dial_code'] == user.countryCode.toString())['name']} \n ${user.phoneNumber ?? ''}'),
                            ),
                          ),
                        ),
                      );
                    }))
          ],
        );
      }
    }
  }

  showDialogImg(url) {
    showDialog(
        context: context,
        builder: (c) => Dialog(
              child: Image.network(url),
            ));
  }
}
