import 'package:alaraf/core/util/country_data.dart';
import 'package:alaraf/future/admin/view_model/admin_view_model.dart';
import 'package:flutter/material.dart';
class AdminUserInfo extends StatelessWidget {
  final AdminViewModel model;

  const AdminUserInfo({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4,),
                            Text(
                                'User Type: ${user.userType == 1 ? 'Client' : 'Expert'} '),
                            if(user.userType == 2)...[
                              SizedBox(height: 4,),
                              OutlinedButton(onPressed: (){
                                model.changePage(AdminPage.add_expert_activity,expertId: user.id);
                              }, child: Text('Add Ability')),
                              SizedBox(height: 4,),

                            ]
                          ],
                        ),
                        trailing: Text(
                            '${user.userName}\n${user.countryCode == 0 ? 'Turkey' : countryList.firstWhere((element) => element['dial_code'] == user.countryCode.toString())['name']} \n ${user.phoneNumber ?? ''}'),
                      ),
                    ),
                  );
                }))
      ],
    );;
  }
}
