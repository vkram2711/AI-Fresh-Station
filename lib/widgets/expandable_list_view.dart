import 'package:ai_fresh_plant/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpandableListView extends StatelessWidget {
  final int countOfTrays;
  final int countOfPots;

  ExpandableListView(this.countOfTrays, this.countOfPots);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: countOfTrays,itemBuilder: (context, i) {
      return ExpansionTile(title: Text(S.of(context).trayNumber(i+1)),
         children: generateWidgets(countOfPots, context)
      );
    }));
  }

  List<Widget> generateWidgets(int size, BuildContext context){
    List <Widget> widgets = List<Widget>();
    for(int i = 0; i < size; i++) {
      widgets.add(Padding(padding: EdgeInsets.only(top: 16),child:Text(S.of(context).pot(i + 1))));
    }
    return widgets;
  }
}