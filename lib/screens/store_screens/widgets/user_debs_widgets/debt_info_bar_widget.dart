import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:store_app/utils/styles/user_app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../main.dart';
import 'package:store_app/screens/main_widgets/loading.dart';
import 'dart:async';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:store_app/providers/auth_provider.dart';
import 'package:store_app/models/user_model_files/user_model.dart';

class DebtInfoBarWidget extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const DebtInfoBarWidget({Key key, this.animationController, this.animation})
      : super(key: key);
  @override
  _DebtInfoBarWidget createState() => _DebtInfoBarWidget();
}

class _DebtInfoBarWidget extends State<DebtInfoBarWidget> with TickerProviderStateMixin {
  AnimationController animationController;
  final ScrollController _scrollController = ScrollController();
  StreamController _userStreamController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _userStreamController = new StreamController();
    loadInvoices(context);
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  loadInvoices(BuildContext context) async {
    context.read<AuthProvider>().currentUser(context.read<AuthProvider>().token).then((res) async {
      _userStreamController.add(res);
      return res;
    });
  }



  @override
  Widget build(BuildContext context) {
    final _authProvider = context.watch<AuthProvider>();

    return StreamBuilder(
      stream: _userStreamController?.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //print('CONNECTION STATE ===  ${snapshot.connectionState}');
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none ) { return Center(child:Loading()); }
        if (snapshot.hasError) { return Text(snapshot.error); }
        if (snapshot.hasData) {
          UserModel user = snapshot.data;
          return AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget child) {
              return FadeTransition(
                opacity: widget.animation,
                child: new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.animation.value), 0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 0, bottom: 18),
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
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 16),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                        left: 10, right: 8, top: 4,bottom:10),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              height: 100,
                                              width: 2,
                                              decoration: BoxDecoration(
                                                color: HexColor('#87A0E5')
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 5, bottom: 10),
                                                    child: Text(
                                                      'lastInvoice'.tr(),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                        UserAppTheme.fontName,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16,
                                                        letterSpacing: -0.1,
                                                        color: UserAppTheme.grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 48,
                                                        height: 48,
                                                        child: Image.asset(
                                                            "assets/images/app/shopping-cart.png"),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 2, bottom: 3),
                                                        child: Text(
                                                          '${(user.latestInvoice)}',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                            UserAppTheme
                                                                .fontName,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            fontSize: 18,
                                                            color: UserAppTheme
                                                                .darkerText,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 4, bottom: 3),
                                                        child: Text(
                                                          '₺',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                            UserAppTheme
                                                                .fontName,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            fontSize: 16,
                                                            letterSpacing: -0.2,
                                                            color: HexColor('#D4AF37'),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: UserAppTheme.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(100.0),
                                              ),
                                              border: new Border.all(
                                                  width: 4,
                                                  color: UserAppTheme
                                                      .nearlyDarkBlue
                                                      .withOpacity(0.2)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '${(user.totalDebt)}₺',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    UserAppTheme.fontName,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 22,
                                                    letterSpacing: 0.0,
                                                    color: HexColor('#D4AF37'),
                                                  ),
                                                ),
                                                Text(
                                                  'totalDebtYouGet'.tr(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    UserAppTheme.fontName,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    letterSpacing: 0.0,
                                                    color: UserAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: CustomPaint(
                                            painter: CurvePainter(
                                                colors: [
                                                  UserAppTheme.nearlyDarkBlue,
                                                  HexColor("#8A98E8"),
                                                  HexColor("#8A98E8")
                                                ],
                                                angle: _authProvider.user.totalDebt / 100),
                                            child: SizedBox(
                                              width: 108,
                                              height: 108,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } return Center(child:Loading());
      },
    );
  }



}

class CurvePainter extends CustomPainter {
  final double angle;
  final List<Color> colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = List<Color>();
    if (colors != null) {
      colorsList = colors;
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shadowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shadowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shadowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(
            center: shadowPaintCenter, radius: shadowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shadowPaint);

    shadowPaint.color = Colors.grey.withOpacity(0.3);
    shadowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(
            center: shadowPaintCenter, radius: shadowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shadowPaint);

    shadowPaint.color = Colors.grey.withOpacity(0.2);
    shadowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(
            center: shadowPaintCenter, radius: shadowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shadowPaint);

    shadowPaint.color = Colors.grey.withOpacity(0.1);
    shadowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(
            center: shadowPaintCenter, radius: shadowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shadowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var radian = (math.pi / 180) * degree;
    return radian;
  }

}