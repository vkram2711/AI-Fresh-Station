import 'dart:math';

import 'package:ai_fresh_plant/screens/light/widgets/light_screen.dart';
import 'package:ai_fresh_plant/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrayWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: LightPage(),),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(padding: EdgeInsets.only(bottom: 12),child:SvgPicture.asset("assets/images/tray_back.svg")),
                Padding(padding: EdgeInsets.only(bottom: 24),child:Image.asset("assets/images/mint.png")),
                Padding(padding: EdgeInsets.only(bottom: 12),child: SvgPicture.asset("assets/images/tray_front.svg")),

                Row(
                  children: [
                    Expanded(flex: 1,child: Transform.rotate(angle: _degreesToRadians(27.71), child: Text("TRAY 1", textAlign: TextAlign.center, style: FontManager.sfProDisplay(size: 17),))),
                    Expanded(flex: 1,child: Transform.rotate(angle: _degreesToRadians(-27.71), child: Text("8/10 pots", textAlign: TextAlign.center, style: FontManager.sfProText(size: 12, color: HexColor.fromHex("A6A1A1")),)))
                  ],
                )

              ],
    )]));
  }

  double _degreesToRadians(double degrees){
    return degrees * pi /180;
  }
}

