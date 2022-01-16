import 'package:ai_fresh_plant/base/state.dart';
import 'package:ai_fresh_plant/constants.dart';
import 'package:ai_fresh_plant/generated/i18n.dart';
import 'package:ai_fresh_plant/models/models.dart';
import 'package:ai_fresh_plant/screens/add_plant/widgets/add_screen.dart';
import 'package:ai_fresh_plant/screens/info/widgets/info_screen.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_action.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_bloc.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_state.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_utils.dart';
import 'package:ai_fresh_plant/screens/sectors/widgets/sectors_widget.dart';
import 'package:ai_fresh_plant/screens/trays/widgets/trays_screen.dart';
import 'package:ai_fresh_plant/widgets/base_widgets.dart';
import 'package:ai_fresh_plant/widgets/calendar/widgets/calendar.dart';
import 'package:ai_fresh_plant/widgets/plant_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';

class SectorPage extends StatelessWidget{
  final int selectedTrayId;

  SectorPage(this.selectedTrayId);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => SectorBloc(selectedTrayId),
      dispose: (context, value) => value.dispose(),
      child: SectorScreen(),
    );
  }
}

class SectorScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SectorScreen();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _SectorScreen extends State<SectorScreen>{

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<SectorBloc>(context, listen: false);
    return StreamBuilderWithListener<SectorsBlocState>(
        stream: bloc.blocStream.stream,
        listener: (value) {
          if(bloc.state.state == SectorStates.infoOpened)
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoScreenPage(bloc, bloc.state.scheduled)));
            //scaffoldKey.currentState.showBottomSheet((context) => InfoScreenPage(bloc, bloc.state.scheduled));

          if(bloc.state.state == SectorStates.addOpened)
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPage(bloc, false)));
          //scaffoldKey.currentState.showBottomSheet((context) => AddPage(bloc, false));
        },
        initialData: bloc.state,
        builder: (context, snapshot) {

          print(bloc.state.sectors);
          print(bloc.state.state);
          switch(bloc.state.state) {
            case SectorStates.init:
              return DownloadWidget();
            case SectorStates.sectorsOpened:
              return SectorsWidget();
            case SectorStates.addOpened:
              return SectorsWidget();
            case SectorStates.infoOpened:
              return SectorsWidget();
              break;
          }
          return Scaffold(body: Text("Error"));
        });
  }
}

class SectorsWidget extends StatelessWidget{
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<SectorBloc>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        body: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate([
              Calendar(SectorsUtils.predictFinishDate(GlobalState.plants, bloc.state.sectors.sectors))
            ],
          ),),

          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing:  8,
                childAspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height),
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int i){
                  return constructPlantItem(bloc.state.sectors.sectors[i], context);
                },
              childCount: bloc.state.sectors.sectors.length,
            ),
          )

        ]
        )
    );
  }

  Widget constructPlantItem(Sector sector, BuildContext context) {
    var bloc = Provider.of<SectorBloc>(context, listen: false);

    if (sector.plant_id != -1) {
      int ripeningTime = GlobalState.plants[sector.plant_id].ripening_time*24*60*60;
      double progress = ((bloc.state.date.millisecondsSinceEpoch/1000 - sector.plant_timestamp)/ripeningTime)*100;
      if (progress <=101 && progress >= 0) {
        if (progress > 100) {
          progress = 100;
        }
        return PlantSector(sector, progress);
      } else{
        return ReadyPlantSector(sector);
      }
    } else {

      for(final job in bloc.state.jobs){
        if(job.pot_id == sector.id) {

          int ripeningTime = GlobalState.plants[job.plant_id].ripening_time*24*60*60;
          double progress = ((bloc.state.date.millisecondsSinceEpoch/1000 - job.timestamp/1000)/ripeningTime)*100;
          if (progress <=101 && progress >= 0) {
            if (progress > 100) {
              progress = 100;
            }
            return ScheduledPlantSector(job, progress);
          }
          /*

          print(progress);
          if (progress <=101 && progress >= 0) {
            if (progress > 100) {
              progress = 100;
            }

            return ScheduledPlantSector(job, progress);
          } else {

            return  ScheduledPlantSector(job, progress);//PlantSector(Sector(id: job.pot_id, plant_timestamp: job.timestamp, plant_id: job.plant_id), progress);
            */
            return ScheduledPlantSector(job, 0.0);
          //}
        }
      }
      return AddPlantSector(sector);
    }
  }
}