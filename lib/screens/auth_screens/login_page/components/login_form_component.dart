import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:store_app/providers/auth_provider.dart';
import 'package:store_app/screens/auth_screens/password_reset_page/password_reset_page.dart';
import 'package:store_app/services/check_internet_connection_service.dart';


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailFieldController = TextEditingController(text:'');
  TextEditingController _passwordFieldController = TextEditingController(text:'');

  bool _visible = false;
  bool rememberMe = false;
  String token;


  Future<void> _logIn(BuildContext context) async {
    final Map body = {
      "email": _emailFieldController.text.trim(),
      "password": _passwordFieldController.text.trim()
       };

    if (rememberMe == true) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString("saved_email", _emailFieldController.text.trim());
      _prefs.setString("saved_password", _passwordFieldController.text.trim());
      _prefs.setBool("remember_me", true);
    }else{
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.remove('saved_email');
      _prefs.remove('saved_password');
      _prefs.setBool('remember_me',false);
    }
    if (await checkNetworkConnection(context)) {
      await context.read<AuthProvider>().login(context,body);
      }
    }




  @override
  void dispose() {
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }


  @override

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        _loadRememberMe();
      });
    });
    super.didChangeDependencies();
  }


  void _loadRememberMe() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _rememberMe = _prefs.getBool("remember_me") ?? false;
      var _email = _prefs.getString("saved_email") ?? "";
      var _password = _prefs.getString("saved_password") ?? "";
          rememberMe = _rememberMe ?? false;
        _emailFieldController.text = _email ?? "";
        _passwordFieldController.text = _password ?? "";
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
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _passwordFieldController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'invalidPasswordEmpty'.tr();
                                }
                                if (value.length < 6) {
                                  return 'password6CharactersLabel'.tr();
                                }
                                return null;
                              },
                              obscureText: _visible ? false : true,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff9785B7),
                                      width: 1,
                                    )),
                                contentPadding: EdgeInsets.all(20),
                                hintText: 'passwordLabel'.tr(),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      _visible
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye,
                                      color: Color(0xff9785B7),
                                      size: 17,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _visible = !_visible;
                                      });
                                    }),
                                hintStyle: TextStyle(color: Color(0xff9785B7)),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.key,
                                  color: Color(0xff9785B7),
                                  size: 17,
                                ),
                              ),
                            ),
                          ),
                          Text('rememberme').tr(),
                          Switch(
                            value: this.rememberMe,
                            onChanged: (value) {
                              setState(() {
                                this.rememberMe = value;
                              });
                            },
                            activeTrackColor: Colors.deepPurple,
                            activeColor: Colors.deepPurpleAccent,
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
                        child: const CircularProgressIndicator(backgroundColor: Colors.white,),
                      ),
                    ),
                  ),
                )
                    : GestureDetector(
                  onTap: ()  {
                    _logIn(context);
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
                        child: Text('signIn', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),).tr(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PasswordResetPage();
                            },
                          ),
                        );
                      },
                      child: Text('forgotPasswordQuestion', style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),).tr(),
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
