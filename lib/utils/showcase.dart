import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShowCase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("SpinKit", style: TextStyle(fontSize: 24.0)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SpinKitRotatingCircle(color: Colors.deepPurple),
                const SpinKitRotatingPlain(color: Colors.deepPurple),
                const SpinKitChasingDots(color: Colors.deepPurple),
              ],
            ),
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SpinKitPumpingHeart(color: Colors.deepPurple),
                const SpinKitPulse(color: Colors.deepPurple),
                const SpinKitDoubleBounce(color: Colors.deepPurple),
              ],
            ),
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SpinKitWave(color: Colors.deepPurple, type: SpinKitWaveType.start),
                const SpinKitWave(color: Colors.deepPurple, type: SpinKitWaveType.center),
                const SpinKitWave(color: Colors.deepPurple, type: SpinKitWaveType.end),
              ],
            ),
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SpinKitThreeBounce(color: Colors.deepPurple),
                const SpinKitWanderingCubes(color: Colors.deepPurple),
                const SpinKitWanderingCubes(color: Colors.deepPurple, shape: BoxShape.circle),
              ],
            ),
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SpinKitCircle(color: Colors.deepPurple),
                const SpinKitFadingFour(color: Colors.deepPurple),
                const SpinKitFadingFour(color: Colors.deepPurple, shape: BoxShape.rectangle),
              ],
            ),
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SpinKitFadingCube(color: Colors.deepPurple),
                const SpinKitCubeGrid(size: 51.0, color: Colors.deepPurple),
                const SpinKitFoldingCube(color: Colors.deepPurple),
              ],
            ),
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SpinKitRing(color: Colors.deepPurple),
                const SpinKitDualRing(color: Colors.deepPurple),
                const SpinKitRipple(color: Colors.deepPurple),
              ],
            ),
            const SizedBox(height: 48.0),
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SpinKitSpinningCircle(color: Colors.deepPurple),
                const SpinKitSpinningCircle(color: Colors.deepPurple, shape: BoxShape.rectangle),
                const SpinKitFadingCircle(color: Colors.deepPurple),
              ],
            ),
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SpinKitHourGlass(color: Colors.deepPurple),
                const SpinKitPouringHourglass(color: Colors.deepPurple),
              ],
            ),
            const SizedBox(height: 64.0),
          ],
        ),
      ),
    );
  }
}
