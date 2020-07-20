import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/utils/styles/user_app_theme.dart';

class AppBarView extends StatefulWidget {
  final String headText;
  const AppBarView(this.headText);

  @override
  _AppBarView createState() => _AppBarView();
}

class _AppBarView extends State<AppBarView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UserAppTheme.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: UserAppTheme.grey.withOpacity(0.4),
              offset: Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 30, right: 100),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '${widget.headText}',
                  style: TextStyle(
                    fontFamily:
                    UserAppTheme.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    letterSpacing: 0.0,
                    color:UserAppTheme.nearlyDarkBlue,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}