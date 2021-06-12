// ignore: file_names, file_names
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class UpperCircle extends StatelessWidget {
  late IconData icon;
  late double fabIconAlpha;
  late double position;
  UpperCircle(this.icon,this.fabIconAlpha,this.position);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        child: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: Align(
            heightFactor: 1,
            alignment: Alignment(position,0),
            child: FractionallySizedBox(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: ClipRect(
                        clipper: HalfClipper(),
                        child: Container(
                          child: Center(
                            child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 8)
                                    ])),
                          ),
                        )),
                  ),
                  SizedBox(
                      height: 70,
                      width: 90,
                      child: CustomPaint(
                        painter: HalfPainter(),
                      )),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple,
                          border: Border.all(
                              color: Colors.white,
                              width: 5,
                              style: BorderStyle.none)),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Opacity(
                          opacity: fabIconAlpha,
                          child: Icon(
                            icon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}

class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height / 2);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class HalfPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect beforeRect = Rect.fromLTWH(0, (size.height / 2) - 10, 10, 10);
    final Rect largeRect = Rect.fromLTWH(10, 0, size.width - 20, 70);
    final Rect afterRect =
    Rect.fromLTWH(size.width - 10, (size.height / 2) - 10, 10, 10);

    final path = Path();
    path.arcTo(beforeRect, vector.radians(0), vector.radians(90), false);
    path.lineTo(20, size.height / 2);
    path.arcTo(largeRect, vector.radians(0), -vector.radians(180), false);
    path.moveTo(size.width - 10, size.height / 2);
    path.lineTo(size.width - 10, (size.height / 2) - 10);
    path.arcTo(afterRect, vector.radians(180), vector.radians(-90), false);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}