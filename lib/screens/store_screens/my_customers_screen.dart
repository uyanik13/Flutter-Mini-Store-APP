import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/providers/store_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/auth_provider.dart';
import 'package:store_app/providers/user_provider.dart';
import 'package:store_app/screens/main_screens/check_status_screen.dart';
import 'package:store_app/screens/main_widgets/drawer.dart';
import 'package:store_app/services/check_internet_connection_service.dart';
import 'package:store_app/utils/dropdown_formfield.dart';
import 'package:store_app/utils/styles/custom_styles.dart';
import 'package:store_app/utils/styles/user_app_theme.dart';


class MyCustomersScreen extends StatefulWidget {
  @override
  _MyCustomersScreen createState() => _MyCustomersScreen();
}

class _MyCustomersScreen extends State<MyCustomersScreen> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _totalDebtFieldController = TextEditingController(text:'');
  final FocusNode myFocusNode = FocusNode();
  int _userSelectedItem;
  List users = List();
  bool debtStatus = true;



  @override
  void initState() {
    setState(() {
      // initThings(context);
      getUsers();
    });
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    _totalDebtFieldController.dispose();
    super.dispose();
  }


  Future<dynamic> getUsers() async {
    context.read<StoreProvider>().getUsers(context.read<AuthProvider>().token).then((response) => {
      //print('USERS ${response['data']}'),
      setState(() {
        users = response['data'];
      })
    });
  }





  Future<void> _submit(BuildContext context) async {
    //final AuthProvider _authProvider = context.read<AuthProvider>();
    if (await checkNetworkConnection(context)) {
      final postBody = {
        "user_total_debt": debtStatus ? _totalDebtFieldController.text : '-'+_totalDebtFieldController.text,
      };
      print('debtStatus $debtStatus');
      print('POST $postBody');
      await context.read<UserProvider>().updateUser(context,_userSelectedItem.toInt(),postBody,context.read<AuthProvider>().token,() => CheckStatusScreen());
    }
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      color: UserAppTheme.background,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer:DroDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: new IconButton(
            icon: new Icon(Icons.menu, color: Colors.deepPurple,),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          title: Text("addDebtOrIncScreen".tr(), style: TextStyle(fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.deepPurple),),
          /* actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.red), onPressed: () {},),
            IconButton(icon: Icon(Icons.notifications, color: Colors.red),
              onPressed: () {},)
          ],*/
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                  key:_formKey,
                  child:Padding(
                    padding: EdgeInsets.all(22.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 10),
                            debtStatus ? Text(
                              'debtIncActive'.tr(),
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ) : Text(
                              'debtDecActive'.tr(),
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            Switch(
                              value: this.debtStatus,
                              onChanged: (value) {
                                setState(() {
                                  this.debtStatus = value;
                                });
                              },
                              activeTrackColor: Colors.deepPurple,
                              activeColor: Colors.deepPurpleAccent,
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'debtIncOrDec'.tr();
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                      )),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff9785B7),
                                        width: 1,
                                      )),
                                  contentPadding: EdgeInsets.all(20),
                                  hintText: debtStatus ? 'debtInc'.tr() : 'debtDec'.tr() ,
                                  hintStyle: TextStyle(color: Color(0xff9785B7)),
                                  focusColor: Colors.red,
                                  hoverColor: Colors.green,
                                  prefixStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.funnelDollar,
                                    color: Color(0xff9785B7),
                                    size: 17,
                                  ),
                                ),
                                enabled: true,
                                controller: _totalDebtFieldController,
                              ),
                            ),//DEBT + OR -
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 5),
                                Container(
                                  child: DropDownFormField(
                                      hintText: 'shoppingUsersSelect'.tr(),
                                      value: _userSelectedItem,
                                      onChanged: (value1) {
                                        setState(() {
                                          _userSelectedItem = value1;
                                        });
                                      },
                                      item:users.map((user) {
                                        return DropdownMenuItem<dynamic>(
                                          value: user["id"],
                                          child: Text('${user['name']} --- Borç:${user['user_total_debt']}₺')
                                        );
                                      }).toList()
                                  ),
                                ),//User Select
                                SizedBox(height: 5),
                              ],
                            ),//USERS
                            SizedBox(height: 10.0,),
                            debtStatus ?  RaisedButton(
                              onPressed: () {
                                _submit(context);
                              },
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: 60,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      CustomColors.PurpleAccent,
                                      CustomColors.BlueDark,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CustomColors.BlueShadow,
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0.0, 0.0),
                                    ),
                                  ],
                                ),
                                padding:
                                const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Center(
                                  child:  Text(
                                    'debtInc'.tr(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ) : RaisedButton(
                              onPressed: () {
                                _submit(context);
                              },
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: 60,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      CustomColors.TrashRed,
                                      CustomColors.BlueDark,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CustomColors.BlueShadow,
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0.0, 0.0),
                                    ),
                                  ],
                                ),
                                padding:
                                const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Center(
                                  child:  Text(
                                    'debtDec'.tr(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }



}




