import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/providers/auth_provider.dart';
import 'package:store_app/services/check_internet_connection_service.dart';
import 'package:easy_localization/easy_localization.dart';


class PasswordResetForm extends StatefulWidget {
  @override
  _PasswordResetForm createState() => _PasswordResetForm();
}

class _PasswordResetForm extends State<PasswordResetForm> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailFieldController = TextEditingController(text:'');






  Future<void> _submit(BuildContext context) async {
    if (await checkNetworkConnection(context)) {
      await context.read<AuthProvider>().forgotPassword(context,body: {
        "email": _emailFieldController.text.trim(),
      });
    }
  }



  @override
  void dispose() {
    _emailFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }


  void _loadRememberMe() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("saved_email") ?? "";
        _emailFieldController.text = _email ?? "";
    } catch (e) {
      print("_loadRememberMe : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
              key:_formKey,
              child:Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10)
                            )
                          ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]))
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'invalidEmailEmpty'.tr();
                                }
                                if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'invalidEmailErrorText'.tr();
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
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
                                hintText: 'emailHint'.tr(),
                                hintStyle: TextStyle(color: Color(0xff9785B7)),
                                focusColor: Colors.red,
                                hoverColor: Colors.green,
                                prefixStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.envelopeOpen,
                                  color: Color(0xff9785B7),
                                  size: 17,
                                ),
                              ),
                              controller: _emailFieldController,
                            ),
                          ),
                          new SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
              margin: EdgeInsets.only(top: 47),
              child: SizedBox(
                width: 262,
                height: 48,
                child: context.watch<AuthProvider>().loading
                    ? GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ]
                          )
                      ),
                      child: Center(
                        child: Text('signIn', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),).tr(),
                      ),
                    ),
                  ),
                )
                    : GestureDetector(
                  onTap: ()  {
                    _submit(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ]
                          )
                      ),
                      child: Center(
                        child: Text('forgotPasswordQuestion', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),).tr(),
                      ),
                    ),
                  ),
                ),
              ),
            ),

                  ],
                ),
              )
          )
        ],
      ),
    );
  }



}
