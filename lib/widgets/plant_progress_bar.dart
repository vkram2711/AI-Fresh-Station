


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class PlantProgressBar extends StatelessWidget {
  final double progress;

  final List<Color> _colors = [HexColor.fromHex("#afe0b4"), HexColor.fromHex("#d9f6dc"), Colors.white];
  final BoxShape shape;

  PlantProgressBar(this.progress, {this.shape = BoxShape.rectangle});

  @override
  Widget build(BuildContext context) {
    List<double> _stops = [progress/100/2.5 - 0.05, progress/100 + 0.05,  progress/100 + 0.15];
    return Padding(padding: EdgeInsets.symmetric(horizontal: 8),child:Align(alignment: Alignment.center,child:Container(
        decoration: BoxDecoration(shape: shape, gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: _colors,
          stops: _stops,
        ))
    )));
  }
}

class RoundPlantProgressBar extends StatelessWidget {
  final double progress;

  RoundPlantProgressBar(this.progress);

  @override
  Widget build(BuildContext context) {
    return PlantProgressBar(progress, shape: BoxShape.circle);
  }
}

class PlantImageWithProgressBar extends StatelessWidget{
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center,children: <Widget>[
      PlantProgressBar(progress),
      Image.asset("assets/images/mint.png", fit: BoxFit.fitWidth,),
    ]);
  }
  PlantImageWithProgressBar(this.progress);
}

class RoundPlantImageWithProgressBar extends StatelessWidget{
  final double progress;

  RoundPlantImageWithProgressBar(this.progress);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center,children: <Widget>[
      RoundPlantProgressBar(progress),
      Image.asset("assets/images/mint.png", fit: BoxFit.fitWidth,),
    ]);
  }
}
