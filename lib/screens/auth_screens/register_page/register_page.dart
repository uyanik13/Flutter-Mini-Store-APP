import 'package:flutter/material.dart';

import 'components/register_form_component.dart';



class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops:[0.1,0.4],
          colors: [Colors.deepPurple,Colors.white],
    ),
          ),
          child: SingleChildScrollView(child:RegisterForm())),
    );
  }
}

