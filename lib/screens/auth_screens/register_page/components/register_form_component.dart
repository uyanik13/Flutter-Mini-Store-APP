
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:store_app/providers/auth_provider.dart';
import 'package:store_app/screens/auth_screens/login_page/login_page.dart';



class RegisterForm extends StatefulWidget {
  @override
  _RegisterForm createState() => _RegisterForm();
}

class _RegisterForm extends State<RegisterForm> {

  @override
  void initState() {
    super.initState();

  }

  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController(text:'');
  final _emailFieldController = TextEditingController(text:'');
  final _phoneFieldController = TextEditingController(text:'');
  final _refNumberController = TextEditingController(text:'');
  final _storeNameController = TextEditingController(text:'');
  final _passwordFieldController = TextEditingController(text:'');
  final _passwordFieldController2 = TextEditingController(text:'');
  String token;
  bool _visible = false;
  bool isStore = false;
  bool _labelStatus = true;



  Future<bool> _register(BuildContext context) async {
    final bodyData = {
      "name": _nameFieldController.text.trim(),
      "email": _emailFieldController.text.trim(),
      "phone": _phoneFieldController.text.trim(),
      "user_ref_number": isStore == false ?_refNumberController.text.trim() : null,
      "store_name": isStore == true ? _storeNameController.text.trim() : null,
      "password": _passwordFieldController.text,
      "password_confirmation": _passwordFieldController2.text,
    };
    await context.read<AuthProvider>().register(context,body:bodyData);
    return true;
  }

  @override
  void dispose() {
    _nameFieldController.dispose();
    _emailFieldController.dispose();
    _phoneFieldController.dispose();
    _passwordFieldController.dispose();
    _passwordFieldController2.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 55),
                  child: Text('register', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 24),).tr(),),
            ],
          ),
          Form(
              key:_formKey,
              child:Padding(
                padding: EdgeInsets.all(22.0),
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
                                  return 'nameRequired'.tr();
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
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
                                hintText: 'name'.tr(),
                                hintStyle: TextStyle(color: Color(0xff9785B7)),
                                focusColor: Colors.red,
                                hoverColor: Colors.green,
                                prefixStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.user,
                                  color: Color(0xff9785B7),
                                  size: 17,
                                ),
                              ),
                              controller: _nameFieldController,
                            ),
                          ),
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
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]))
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'invalidPhoneEmpty'.tr();
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
                                hintText: 'phoneHint'.tr(),
                                hintStyle: TextStyle(color: Color(0xff9785B7)),
                                focusColor: Colors.red,
                                hoverColor: Colors.green,
                                prefixStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.phone,
                                  color: Color(0xff9785B7),
                                  size: 17,
                                ),
                              ),
                              controller: _phoneFieldController,
                            ),
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
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _passwordFieldController2,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'passwordConfirmLabel'.tr();
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
                                hintText: 'passwordConfirmLabel'.tr(),
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
                          _labelStatus
                              ? Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]))
                            ),
                            child: TextFormField(
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
                                enabled:_labelStatus,
                                contentPadding: EdgeInsets.all(20),
                                hintText: 'refNumber'.tr(),
                                hintStyle: TextStyle(color: Color(0xff9785B7)),
                                focusColor: Colors.red,
                                hoverColor: Colors.green,
                                prefixStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.store,
                                  color: Color(0xff9785B7),
                                  size: 17,
                                ),
                              ),
                              controller: _refNumberController,
                            ),
                          )
                              : Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]))
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
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
                                enabled:!_labelStatus,
                                contentPadding: EdgeInsets.all(20),
                                hintText: 'storeName'.tr(),
                                hintStyle: TextStyle(color: Color(0xff9785B7)),
                                focusColor: Colors.red,
                                hoverColor: Colors.green,
                                prefixStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.store,
                                  color: Color(0xff9785B7),
                                  size: 17,
                                ),
                              ),
                              controller: _storeNameController,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text('isStore').tr(),
                          Switch(
                            value: this.isStore,
                            onChanged: (value) {
                              setState(() {
                                this.isStore = value;
                                 _labelStatus = !_labelStatus;
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
                child:  context.watch<AuthProvider>().loading
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
                    _register(context);
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
                        child: Text('register', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),).tr(),
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
                              return LoginPage();
                            },
                          ),
                        );
                        },
                      child: Text('haveAnAccount', style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),).tr(),
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
