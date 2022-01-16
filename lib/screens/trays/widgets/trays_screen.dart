import 'package:ai_fresh_plant/screens/sectors/widgets/sectors_screen.dart';
import 'package:ai_fresh_plant/screens/trays/trays_action.dart';
import 'package:ai_fresh_plant/screens/trays/trays_bloc.dart';
import 'package:ai_fresh_plant/screens/trays/trays_state.dart';
import 'package:ai_fresh_plant/screens/light/widgets/light_screen.dart';
import 'package:ai_fresh_plant/screens/trays/widgets/trays_widget.dart';
import 'package:ai_fresh_plant/widgets/base_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';

class TraysScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TraysScreenState();
}

class _TraysScreenState extends State<TraysScreen> {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<TraysBloc>(context, listen: false);
    return StreamBuilderWithListener<TraysBlocState>(
        stream: bloc.blocStream.stream,
        listener: (value) {
          if(value.state == TraysStates.traySelected){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SectorPage(value.selectedTrayId)
              ));
          }
        },
        initialData: bloc.state,
        builder: (context, snapshot) {
          switch(snapshot.data.state){
            case TraysStates.init:
              return DownloadWidget();
            case TraysStates.authCompleted:
              return DownloadWidget();
            case TraysStates.traysCountLoaded:
              return TraysWidget(bloc.state.traysCount);
            case TraysStates.traySelected:
              return TraysWidget(bloc.state.traysCount);
          }

          return Scaffold(body: Text("Error"));
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class TraysWidget extends StatefulWidget {
  final int traysCount;

  TraysWidget(this.traysCount);

  @override
  State<StatefulWidget> createState() => _TraysWidget(traysCount);
}

class _TraysWidget extends State<TraysWidget> {
  final int traysCount;

  _TraysWidget(this.traysCount);

  @override
  Widget build(BuildContext context) {
    List<Widget> trays = new List();
    for(int i = 0; i < traysCount; i+= 2) {
      trays.add(Row(children: [
        Flexible(fit: FlexFit.loose, flex: 1, child: Column(mainAxisSize: MainAxisSize.min,children: [constructCard(i)])),
        Flexible(fit: FlexFit.loose, flex: 1, child: Column(mainAxisSize: MainAxisSize.min,children: [constructCard(i+1)]))]
      ));
    }
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Text(
            "Trays",
            style: TextStyle(fontSize: 16),
          )),
      LightPage(),
      Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: trays,
            ),
          )
      )
    ]);
  }

  Widget constructCard(int id) {
    return Center(
        child: GestureDetector(
            onTap: () {
              var bloc = Provider.of<TraysBloc>(context, listen: false);
              bloc.mapEventToState(TraysAction.traySelected(id));
            },
            child: TrayWidget()
        ));
  }
}
