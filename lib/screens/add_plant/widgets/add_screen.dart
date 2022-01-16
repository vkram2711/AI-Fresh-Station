import 'dart:collection';

import 'package:ai_fresh_plant/base/state.dart';
import 'package:ai_fresh_plant/generated/i18n.dart';
import 'package:ai_fresh_plant/screens/add_plant/add_action.dart';
import 'package:ai_fresh_plant/screens/add_plant/widgets/add_screen_buttons_widget.dart';
import 'package:ai_fresh_plant/screens/add_plant/widgets/plant_selection_widget.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_bloc.dart';
import 'package:ai_fresh_plant/widgets/calendar/widgets/calendar.dart';
import 'package:ai_fresh_plant/widgets/expandable_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:provider/provider.dart';
import '../../../utils.dart';
import '../add_bloc.dart';
import '../add_state.dart';

class AddPage extends StatelessWidget {
  final SectorBloc sectorBloc;
  final bool withSector;
  AddPage(this.sectorBloc, this.withSector);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AddBloc<SectorBloc>(sectorBloc, withSector),
      dispose: (context, value) => value.dispose(),
      child: AddScreen(),
    );
  }
}
class AddScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddScreen();
}

class _AddScreen extends State<AddScreen> with SingleTickerProviderStateMixin {
  static final List<Tab> tabs = <Tab>[
    Tab(text: "Choose harvest date"),
    Tab(text: "Choose start date")
  ];


  final _currentPageNotifier = ValueNotifier<int>(0);
  TabController tabController;
  var bloc;

  @override
  void initState() {
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<AddBloc<SectorBloc>>(context, listen: false);

    return StreamBuilderWithListener<AddBlocState>(
        stream: bloc.blocStream.stream,
        listener: (value) {
          if (value.state == AddStates.submited) {
            Navigator.pop(context);
          }
        },
        initialData: bloc.state,
        builder: (context, snapshot) {

          Widget plantsList =  PlantList();
          Widget calendar = Calendar(HashMap());

          /*Calendar(
              startOnMonday: true,
              initialDate: bloc.state.initialDate,
              weekDays: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
              isExpandable: true,
              events: Map(),
              onDateSelected: (date) => bloc.mapEventToState(AddAction.timestampChange(date.millisecondsSinceEpoch))
          );*/


          Widget sectorsList =  Column(
            children: <Widget>[
              ExpandableListView(1, 20),
            ],
          );

          var withoutSectors = <Widget>[
            plantsList,
            calendar
          ];
          var withSectors = <Widget>[
            sectorsList,
            plantsList,
            calendar
          ];
          print("current state ${bloc.state.state}");
          print("current page ${bloc.state.currentPage}");
          return Scaffold(
              backgroundColor: Colors.white,
              body: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16
                    ),
                    child: Text(S.of(context).setUpNewPots, style: FontManager.sfProText(size: 16))),
                Expanded(
                    child: PageView(
                      physics: new NeverScrollableScrollPhysics(),
                      controller: bloc.state.controller,
                      children: bloc.state.withSector ? withSectors : withoutSectors,
                  onPageChanged: (int index) {
                    _currentPageNotifier.value = index;
                  },
                )),
                Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16
                    ),
                    child: CirclePageIndicator(
                      selectedDotColor: HexColor.fromHex("#fdaa7c"),
                      itemCount: bloc.state.withSector ? 3 : 2,
                      currentPageNotifier: _currentPageNotifier,
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16
                    ),
                    child: bloc.state.state == AddStates.dateSelection ? SubmitButton() : NextButton(false)
                    //bloc.state.withSector ?
                    //  (bloc.state.state == 0 ? nextBack(false) : bloc.state.currentPage == 2 ? submit() : nextBack(true)) :
                     // (bloc.state.currentPage == 0 ? nextBack(false) : submit())
                )
              ]));
        });
  }


  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}