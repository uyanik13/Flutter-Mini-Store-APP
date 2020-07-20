import 'package:flutter/material.dart';
import 'package:store_app/screens/auth_screens/login_page/login_page.dart';
import 'package:store_app/screens/auth_screens/register_page/register_page.dart';
import 'file:///E:/PROJECTS/MOBILE/store_app/lib/screens/main_widgets/rounded_button.dart';
import 'package:store_app/utils/styles.dart';
import 'background.dart';
import 'package:easy_localization/easy_localization.dart';

class WelcomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('welcome', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold,fontSize: 24),).tr(),
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/images/logo.png",
              width: 375,
              height: 222,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "signIn".tr(),
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "register".tr(),
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
