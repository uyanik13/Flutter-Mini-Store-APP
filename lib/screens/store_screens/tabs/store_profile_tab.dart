import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/user_model_files/user_model.dart';
import 'package:store_app/providers/auth_provider.dart';
import 'package:store_app/providers/user_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:store_app/screens/main_screens/check_status_screen.dart';
import 'package:store_app/services/check_internet_connection_service.dart';



class StoreProfileTab extends StatefulWidget {
  @override
  _StoreProfileTab createState() => _StoreProfileTab();
}

class _StoreProfileTab extends State<StoreProfileTab> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController(text:'');
  final _storeNameFieldController = TextEditingController(text:'');
  final _phoneFieldController = TextEditingController(text:'');
  final _emailFieldController = TextEditingController(text:'');
  final FocusNode myFocusNode = FocusNode();
  bool _status = true;
  String base64Image;
  File tmpFile;
  String errMessage = 'errorUploadImage'.tr();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        initThings(context);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    _nameFieldController.dispose();
    _storeNameFieldController.dispose();
    _phoneFieldController.dispose();
    _emailFieldController.dispose();
    super.dispose();
  }

  Future<void> initThings(BuildContext context) async {
    try {
      final AuthProvider _authProvider = context.read<AuthProvider>();
      _authProvider.currentUser(_authProvider.token).then((user) => {
        print('USER ${user.storeName}'),
        _nameFieldController.text = user.name?.toString()?? 'yükleniyor',
        _storeNameFieldController.text = user.storeName?? 'yükleniyor',
        _phoneFieldController.text = user.phone?.toString()?? 'yükleniyor',
        _emailFieldController.text = user.email?.toString()?? 'yükleniyor',
      });
    } catch (e) {
      print("initThings : $e");
    }
  }

  Future<void> _submit(BuildContext context) async {
    final AuthProvider _authProvider = context.read<AuthProvider>();
    if (await checkNetworkConnection(context)) {
      final postBody = {
        "name": _nameFieldController.text,
      };
      await context.read<UserProvider>().updateUser(context,_authProvider.user.id,postBody,_authProvider.token,()=> CheckStatusScreen());
    }
  }




  chooseImage(BuildContext context) {
    final _userProvider = context.read<UserProvider>();
    final _authProvider = context.read<AuthProvider>();
    _userProvider.updateUserImage(context,_authProvider.token,()=> CheckStatusScreen()).then((value) => {
      print('IAMGE $value')
    });
  }



  @override
  Widget build(BuildContext context) {
    final _userProvider = context.watch<UserProvider>();
    final UserModel user = context.watch<AuthProvider>().user;
    return Provider(
      create: (context) => new UserProvider(context.watch<AuthProvider>().token),
      child: SingleChildScrollView(
          child:Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: ()  {
                      chooseImage(context);
                    },
                    child: ClipRRect(
                      child:  Container(
                        height: 120,
                        width: 120,
                        margin: EdgeInsets.only(top: 20),
                        child: Stack(
                          children: <Widget>[
                            context.watch<UserProvider>().image == null ? ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(150.0)),
                              child: CachedNetworkImage(
                                placeholder: (context, url) =>  CircleAvatar(
                                  backgroundImage: NetworkImage('https://growtogive.com/wp-content/uploads/2019/12/user-icon-100x100.png'),
                                  radius: 150,
                                ),
                                imageUrl: '${user.photoUrl}',
                              ),
                            ) : ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(150.0)),
                              child: Image.file(context.watch<UserProvider>().image),
                            ) ,
                            Container(
                              padding: EdgeInsets.only(left:80,top: 20),
                              child: Stack(
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.edit,color:Colors.deepPurple)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              Form(
                  key:_formKey,
                  child:Padding(
                    padding: EdgeInsets.all(15.0),
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
                                  enabled: !_status,
                                  autofocus: !_status,
                                  controller: _nameFieldController,
                                ),
                              ),//NAME
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
                                    hintText: 'storeName'.tr(),
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
                                  enabled: false,
                                  controller: _storeNameFieldController,
                                ),
                              ),//STORE NAME
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
                                    enabled: false,
                                  ),
                                  controller: _phoneFieldController,
                                ),
                              ), //PHONE
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
                                    enabled: false,
                                  ),
                                  controller: _emailFieldController,
                                ),
                              ),//EMAIL
                            ],
                          ),
                        ),
                        _status == false
                            ? Container(
                          margin: EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: 262,
                            height: 48,
                            child:  _userProvider.loading ? LinearProgressIndicator() : GestureDetector(
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
                                    child: Text('save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),).tr(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                            : Container(
                          margin: EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: 262,
                            height: 48,
                            child:  GestureDetector(
                              onTap: ()  {
                                setState(() {
                                  _status = false;
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                          colors: [
                                            Color.fromRGBO(255, 20, 20, 1),
                                            Color.fromRGBO(143, 148, 251, .6),
                                          ]
                                      )
                                  ),
                                  child: Center(
                                    child: Text('edit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),).tr(),
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
          )
      )
    );
  }









}


