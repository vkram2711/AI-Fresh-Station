import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleLayout extends StatelessWidget {
  final Widget centerWidget;
  final List<Widget> children;


  CircleLayout(this.centerWidget, this.children);

  @override
  Widget build(BuildContext context) {
    List<Widget> positioned = List();

    positioned.add(Padding(child: centerWidget, padding: EdgeInsets.all(16),));



    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double height = constraints.maxHeight;
      double width = constraints.maxWidth;
      double radius = height/2 - 16;

      //(x-h)^2 + (y-k)^2 = r^2
      for(int i = 0; i < children.length; i++){
        positioned.add(Positioned(
          top: height/2 - radius*sin(pi*2/children.length*i) - 16,
          right: width/2 - radius*cos(pi*2/children.length*i) - 16,
          child: children[i],
        ));
      }
      return Stack(
          children: positioned
      );
    });
  }
}