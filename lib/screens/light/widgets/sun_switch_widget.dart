import 'package:ai_fresh_plant/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../light_action.dart';
import '../light_bloc.dart';
import 'light_screen.dart';

class SunSwitchWidget extends State<LightWidget>{


  @override
  Widget build(BuildContext context) {
    double sensitivity = 0.5;
    var state = Provider.of<LightBloc>(context, listen: false).state;
    return AnimatedContainer(
          duration: Duration(milliseconds: 800),
          height: 34,
          width: 57,
          child: Stack(children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Container(
              height: 26,
              width: 49,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 800),
                decoration: BoxDecoration(
                    color: state.light ? HexColor.fromHex("FFFFFF") : HexColor.fromHex("EAEAEA"),
                    borderRadius: BorderRadius.circular(20.0),
                   /* boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                      ),
                    ]*/

                ),),
            )),
            AnimatedPositioned(
            duration: Duration(milliseconds: 800),
            curve: Curves.easeIn,
            left: state.light? 35 : 0,
            right: state.light? 0 : 35,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {

                  var event;
                  state = Provider.of<LightBloc>(context, listen: false).state;
                  if (details.delta.dx > sensitivity) {
                    event = LightAction.onAction();
                    Provider.of<LightBloc>(context, listen: false).mapEventToState(event);
                  } else if(details.delta.dx < -sensitivity){
                    event = LightAction.offAction();
                    Provider.of<LightBloc>(context, listen: false).mapEventToState(event);
                  }
              },

              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 800),
                transitionBuilder: (Widget child, Animation<double> animation){
                  return RotationTransition(turns: animation, child: child,);
                },
                child: state.light ?
                  Padding(
                      padding: EdgeInsets.only(bottom: 6, right: 2),
                      child: SvgPicture.asset("assets/images/light_on.svg", height: 34, width: 34,)):
                  Padding(
                      padding: EdgeInsets.only(left: 10, top: 6),
                      child: SvgPicture.asset("assets/images/light_off.svg", height: 22, width: 22,)),
              )),
            ),
          ],
    ));
  }

}