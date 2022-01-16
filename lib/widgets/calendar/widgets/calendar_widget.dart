
import 'package:ai_fresh_plant/utils.dart';
import 'package:ai_fresh_plant/widgets/calendar/calendar_state.dart';
import 'package:ai_fresh_plant/widgets/calendar/calendar_utils.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../calendar_action.dart';
import '../calendar_bloc.dart';
import '../calendar_utils.dart';


class CalendarBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CalendarBloc>(context, listen: false);
    ExpandableController controller = ExpandableController(initialExpanded: bloc.state.state != CalendarStates.weekMode);

    if(controller.expanded == (bloc.state.state == CalendarStates.weekMode)) controller.toggle();
    return Padding(padding: EdgeInsets.only(top: 32, left: 24, right: 24),
        child: ExpandablePanel(
          controller: controller,
          collapsed: Month(Date.generateWeek(bloc.state.focusedDate), controller),
          expanded: Month(Date.generateMonth(bloc.state.focusedDate), controller),
        )
    );
  }
}

class Month extends StatelessWidget {
  final List<Date> dates;
  final ExpandableController controller;
  Month(this.dates, this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MonthPanel(controller),
      Weekdays(),
      GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 48/33,
              crossAxisCount: 7,
              mainAxisSpacing: 11),
          itemCount: dates.length,
          itemBuilder: (context, index) {
            return Day(dates[index]);
          })
    ]);
  }
}

class MonthPanel extends StatelessWidget{
  final ExpandableController controller;

  MonthPanel(this.controller);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CalendarBloc>(context, listen: false);
    return Padding(padding: EdgeInsets.only(bottom: 8, left: 8),child:
      Align(alignment: Alignment.centerLeft,
        child: GestureDetector(onTap: (){
          controller.toggle();
         // Future.delayed(const Duration(milliseconds: 350), (){
            bloc.mapEventToState(CalendarAction.modeChange());
         // });
        },
        child: Text("${Date.months[bloc.state.focusedDate.month - 1]} ${bloc.state.focusedDate.year}",
          style: FontManager.sfProText(
              size: 12,
              color: HexColor.fromHex("#555555"),
              weight: FontWeight.w500
          ),))));
  }
}

class Weekdays extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Center(child: Text("Mon", style: FontManager.sfProText(size: 12, color: HexColor.fromHex("828181")),))),
      Expanded(child: Center(child: Text("Tue", style: FontManager.sfProText(size: 12, color: HexColor.fromHex("828181")),))),
      Expanded(child: Center(child: Text("Wed", style: FontManager.sfProText(size: 12, color: HexColor.fromHex("828181")),))),
      Expanded(child: Center(child: Text("Thu", style: FontManager.sfProText(size: 12, color: HexColor.fromHex("828181")),))),
      Expanded(child: Center(child: Text("Fri", style: FontManager.sfProText(size: 12, color: HexColor.fromHex("828181")),))),
      Expanded(child: Center(child: Text("Sat", style: FontManager.sfProText(size: 12, color: HexColor.fromHex("828181")),))),
      Expanded(child: Center(child: Text("Sun", style: FontManager.sfProText(size: 12, color: HexColor.fromHex("828181")),))),
    ],);
  }
}

class Day extends StatelessWidget{
  final Date date;

  Day(this.date);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CalendarBloc>(context, listen: false);
    Date selectedDate = bloc.state.selectedDate;
    Date focusedDate = bloc.state.focusedDate;

    bool dateSelected;

    if(selectedDate == null){
      dateSelected = false;
    } else{
      dateSelected = ((selectedDate.day == date.day) && (selectedDate.month == date.month) && (selectedDate.year == date.year));
    }

    return GestureDetector(
        onTap: (){
          bloc.mapEventToState(CalendarAction.dateSelect(date));
        },
        child: dateSelected ?
           Container(
              //height: makeVerticalResponsible(31),
             // width: makeHorizontalResponsible(31),
              decoration: BoxDecoration(
                  color: HexColor.fromHex("56cc9a"),
                  shape: BoxShape.circle
              ),
              child: DayText(date, focusedDate, true)
          ) : DayText(date, focusedDate, false)
    );
  }
}

class DayText extends StatelessWidget {
  final Date date;
  final Date focusedDate;
  final bool selected;

  DayText(this.date, this.focusedDate, this.selected);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CalendarBloc>(context, listen: false);
    String key = "${date.day} ${date.month} ${date.year}";

    print("pips info date: " + key + "keys: "+ bloc.state.pips.keys.toString());

    return Center(
        child: Column(children: [
            Text(
              date.day.toString(),
              style: FontManager.sfProText(
                size: 16,
                color: selected ? Colors.white : (date.month == focusedDate.month ? ColorsRes.grey : ColorsRes.greyLight)
              ),
            ),
            Builder(
                builder: (BuildContext context) => bloc.state.pips.containsKey(key) ? InfoPip(bloc.state.pips[key].color) : Container(height: 0,)
            ),
        ]
    ));
  }
}

class InfoPip extends StatelessWidget{
  final Color color;

  InfoPip(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: 6,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle
      ),);
  }
}