import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/auth_provider.dart';
import 'package:store_app/utils/styles/user_app_theme.dart';

import '../../../../main.dart';

class StoreTopBarWidget extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;


  const StoreTopBarWidget({Key key, this.animationController, this.animation})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();
    return Provider(
        create: (context) => new AuthProvider(),
        child: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: animation,
              child: new Transform(
                transform: new Matrix4.translationValues(
                    0.0, 30 * (1.0 - animation.value), 0.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 16, bottom: 18),
                  child: Container(
                    decoration: BoxDecoration(
                      color: UserAppTheme.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(68.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: UserAppTheme.grey.withOpacity(0.2),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8.0)),
                          child: SizedBox(
                            height: 74,
                            child: AspectRatio(
                              aspectRatio: 1.714,
                              child: Image.asset(
                                  "assets/images/app/back.png"),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(
                                  top: 16, left: 16, right: 24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 75, bottom: 24, top: 16),
                                    child: Text(
                                      '${authProvider.user?.storeName}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: UserAppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24,
                                        color: HexColor('#fe4343'),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),


                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}

