import 'package:ai_fresh_plant/base/state.dart';
import 'package:ai_fresh_plant/generated/i18n.dart' as Res;
import 'package:ai_fresh_plant/models/models.dart';
import 'package:ai_fresh_plant/widgets/plant_progress_bar.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../utils.dart';
import '../sectors_action.dart';
import '../sectors_bloc.dart';

final TextStyle percents = TextStyle(fontFamily: Constants.fontProDisplay,
    color: HexColor.fromHex("#6eb775"),
    fontSize: 14); //14px
final TextStyle name = TextStyle(fontFamily: Constants.fontProDisplay,
    color: HexColor.fromHex("#787878"),
    fontWeight: FontWeight.w500,
    fontSize: 14); // 14 px
final TextStyle pot = TextStyle(fontFamily: Constants.fontProDisplay,
    color: HexColor.fromHex("#c4c4c4"),
    fontSize: 11); //11px
final TextStyle dateStyle = TextStyle(fontFamily: Constants.fontProDisplay,
  color: Colors.lightGreenAccent,
  fontSize: 21, //21px
  fontWeight: FontWeight.w900
);

class AddPlantSector extends StatelessWidget{
  final Sector sector;

  AddPlantSector(this.sector);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<SectorBloc>(context, listen: false);

    return  Center(
        child: GestureDetector(
          onTap: () {
            bloc.mapEventToState(SectorsAction.addOpen(sector.id));
          },
          child: Container(
            width: 70, //70px
            height: 100, //100px
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 22, //22px
                    vertical: 37 //37px
                ),
                child: SvgPicture.asset("assets/images/add_icon.svg")),
            decoration: BoxDecoration(
                border: Border.all(color: HexColor.fromHex("#dcf8e5"), width: 2)
            ),
          ),
        ));
  }
}

class ReadyPlantSector extends StatelessWidget {
  final Sector sector;

  ReadyPlantSector(this.sector);

  @override
  Widget build(BuildContext context) {

    return SectorSelectedListener(sector.id,
        scheduled: false,
        child: Stack(children: <Widget>[
            Opacity(opacity: 0.35, child:
              PlantBaseSector(sector, 100)),
            Container(color: Colors.black38,),
            Padding(
                padding: EdgeInsets.only(bottom: 16), //16px
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text("READY", style: dateStyle, )
                      )
                    ])
                )
    ]));
  }

}

class ScheduledPlantSector extends StatelessWidget {
  final Job job;
  final double progress;


  ScheduledPlantSector(this.job, this.progress );

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMicrosecondsSinceEpoch(job.timestamp * 1000);
    var formattedDate = formatDate(date, [dd, '.' , mm]);
    return SectorSelectedListener(
        job.pot_id,
        scheduled: true,
        child: Stack(children: <Widget>[
          Opacity(opacity: 0.35, child:
              PlantBaseSector(Sector(id: job.pot_id, plant_timestamp: job.timestamp, plant_id: job.plant_id), progress)),
          Container(color: Colors.black38,),
          Padding(padding: EdgeInsets.only(bottom: 16), //16px
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[ Center(child: Text(formattedDate, style: dateStyle, ))]))
    ]));
  }
}

class PlantSector extends StatelessWidget {
  final Sector sector;
  final double progress;

  PlantSector(this.sector, this.progress);

  @override
  Widget build(BuildContext context) {
    return SectorSelectedListener(sector.id, scheduled: false, child: PlantBaseSector(sector, progress));
  }
}


class PlantBaseSector extends StatelessWidget{
  final Sector sector;
  final double progress;

  PlantBaseSector(this.sector, this.progress);

  @override
  Widget build(BuildContext context) {
    return Column(

          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(Res.S.of(context).percent(progress.round()), style: percents,),
            Expanded(child: PlantImageWithProgressBar(progress),),
            Text(GlobalState.plants[sector.plant_id].name, style: name, textAlign: TextAlign.center,),
            Text(Res.S.of(context).pot(sector.id + 1), style: pot,)
    ], );
  }
}

class SectorSelectedListener extends StatelessWidget {
  final Widget child;
  final int id;
  final bool scheduled;
  SectorSelectedListener(this.id, {@required this.child, @required this.scheduled});

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<SectorBloc>(context, listen: false);
    return GestureDetector(
        onTap: () {
          bloc.mapEventToState(SectorsAction.sectorSelected(id, scheduled));
        },
      child: child,
    );
  }
}