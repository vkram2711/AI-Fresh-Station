import 'dart:collection';

import 'package:ai_fresh_plant/widgets/calendar/calendar_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../calendar_bloc.dart';
import '../calendar_state.dart';
import '../calendar_utils.dart';
import 'calendar_widget.dart';

class Calendar extends StatelessWidget{

  final HashMap<String, Pip> pips;
  Calendar(this.pips);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => CalendarBloc(pips),
      dispose: (context, value) => value.dispose(),
      child: CalendarWidget(),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Calendar();
}

class _Calendar extends State<CalendarWidget> with SingleTickerProviderStateMixin{
  final controller = new PageController(initialPage: 1);

  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 230), vsync: this);
    _animation = Tween(begin: 136, end: 385).animate(_animationController);
    _animation.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CalendarBloc>(context, listen: false);
    bool weekMode = bloc.state.state == CalendarStates.weekMode;
    return StreamBuilderWithListener<CalendarState>(
        stream: bloc.blocStream.stream,
        listener: (value){


          weekMode = value.state == CalendarStates.weekMode;
          if(weekMode) {
            _animationController.duration = Duration(milliseconds: 350);
            _animationController.reverse();
          } else {
            _animationController.duration = Duration(milliseconds: 200);
            _animationController.forward();
          }
        },
        initialData: bloc.state,
        builder: (context, snapshot) {
          return Container(
                height: (_animation.value as int).toDouble(),//(335),
                //: FadeTransition(opacity: animationFade, child: widget.child), ,
                color: HexColor.fromHex("e5e5e5"),
                child: Column(children: [
                  Expanded(
                      //flex: _animation.value,
                      child:PageView.builder(
                        onPageChanged: (int page){
                          var swipingRight = page > controller.page;
                          if(swipingRight){
                            bloc.mapEventToState(CalendarAction.scrollRight());
                          }else {
                            bloc.mapEventToState(CalendarAction.scrollLeft());
                          }
                        },
                        controller: controller,
                        itemBuilder: (context, index) {
                          print("index $index");
                          return Column(
                              children: [
                                CalendarBody()
                              ]
                            );
                         },
                ))
          ]));
        });
  }
}