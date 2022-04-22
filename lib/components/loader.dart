import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class KLoader extends StatelessWidget {
  final Color? color;
  final double? size;

  const KLoader({Key? key, this.color, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(color: color ?? Colors.white, size: size ?? 25);
  }
}
