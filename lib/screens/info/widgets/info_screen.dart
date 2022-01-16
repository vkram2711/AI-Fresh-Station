import 'package:ai_fresh_plant/base/state.dart';
import 'package:ai_fresh_plant/generated/i18n.dart';
import 'package:ai_fresh_plant/models/models.dart';
import 'package:ai_fresh_plant/screens/info/info_action.dart';
import 'package:ai_fresh_plant/screens/info/info_bloc.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_bloc.dart';
import 'package:ai_fresh_plant/screens/trays/widgets/trays_screen.dart';
import 'package:ai_fresh_plant/widgets/base_widgets.dart';
import 'package:ai_fresh_plant/widgets/circle_layout.dart';
import 'package:ai_fresh_plant/widgets/plant_progress_bar.dart';
import 'package:circle_list/circle_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import '../../../utils.dart';
import '../info_state.dart';
import 'info_widgets.dart';

class InfoScreenPage extends StatelessWidget {
  final SectorBloc sectorBloc;
  final bool scheduled;
  InfoScreenPage(this.sectorBloc, this.scheduled);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => InfoBloc<SectorBloc>(sectorBloc),
      dispose: (context, value) => value.dispose(),
      child: Scaffold(body: InfoScreen(scheduled)),
    );
  }
}

class InfoScreen extends StatefulWidget {
  final bool scheduled;

  InfoScreen(this.scheduled);

  @override
  State<StatefulWidget> createState() => _InfoScreen(scheduled);
}

class _InfoScreen extends State<InfoScreen> {
  final TextStyle trayStyle = TextStyle(fontFamily: "SF Pro Display", fontSize: 18, color: ColorsRes.greyLight);
  final TextStyle plantNameStyle = TextStyle(fontFamily: "SF Pro Text", fontSize: 22, color: ColorsRes.blackLight, fontWeight: FontWeight.w500);
  final TextStyle percentStyle = TextStyle(fontFamily: "SF Pro Text", fontSize: 20, color: ColorsRes.orangeAccent);
  final bool scheduled;
  final PageController controller = PageController(initialPage: 1);
  _InfoScreen(this.scheduled);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<InfoBloc<SectorBloc>>(context, listen: false);

    return StreamBuilderWithListener<InfoBlocState>(
        stream: bloc.blocStream.stream,
        listener: (value) {
          if (value.state == InfoStates.collected) {
            Navigator.pop(context);
          }
        },
        initialData: bloc.state,
        builder: (context, snapshot) {
          switch (bloc.state.state) {
            case InfoStates.sectorReceived:
              int ripeningTime = GlobalState.plants [bloc.state.sector.plant_id].ripening_time * 24 * 60 * 60;
              double progress = boundProgress(((DateTime.now().millisecondsSinceEpoch / 1000 - bloc.state.sector.plant_timestamp) / ripeningTime) * 100);
              return SafeArea(child:Column(children: <Widget>[
                Text(
                  S.of(context).infoTrayPot(bloc.state.sector.tray_id, bloc.state.sector.id),
                  style: trayStyle,
                ),
                Text(
                  GlobalState.plants[bloc.state.sector.plant_id].name,
                  style: plantNameStyle,
                ),
                Expanded(child:CircleLayout(
                    RoundPlantImageWithProgressBar(progress),
                    List.generate(10, (index) {
                      return VitaminAndMineral(index < 5 ? ColorsRes.orangeAccent : ColorsRes.green, "Ca");
                    }),
                )),
               /* CircleList(
                  //  innerRadius: 90,
                  //  outerRadius: 130,
                    children: List.generate(10, (index) {
                      return VitaminAndMineral(index < 5 ? ColorsRes.orangeAccent : ColorsRes.green, "Ca");
                    }),
                    centerWidget: RoundPlantImageWithProgressBar(progress),
                ),*/

                Text(S.of(context).beReadyIn(25), style: FontManager.sfProText(size: 12, color: ColorsRes.orangeAccent, weight: FontWeight.normal),),
                Tabs(controller),
                Expanded(child:PageView(
                  controller: controller,
                  children: [
                    ListView(shrinkWrap: true, children: [
                      Padding(
                          padding: EdgeInsets.all(32),
                          child:Card(
                            color: ColorsRes.whiteDark,
                            child: Padding(padding: EdgeInsets.all(8), child: InfoTable(bloc.state.sector, bloc.state.tray)),
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: HarvestButton()
                      )
                    ]),
                    ListView(shrinkWrap: true, children: [
                      Padding(
                          padding: EdgeInsets.all(32),
                          child:Card(
                            color: ColorsRes.whiteDark,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index){
                                  return VitaminItem();
                                })
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: HarvestButton())
                    ]),
                  ],
                )),


              ]));
            case InfoStates.init:
              return DownloadWidget();
            case InfoStates.collected:
              break;
          }
          return Column();
        });
  }
}
