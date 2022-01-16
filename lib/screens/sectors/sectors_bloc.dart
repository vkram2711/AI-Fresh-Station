import 'dart:developer';
import 'package:ai_fresh_plant/base/action.dart';
import 'package:ai_fresh_plant/base/bloc.dart';
import 'package:ai_fresh_plant/base/state.dart';
import 'package:ai_fresh_plant/models/models.dart';
import 'package:ai_fresh_plant/screens/add_plant/add_action.dart';
import 'package:ai_fresh_plant/screens/info/info_action.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_action.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_data.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_state.dart';
import 'package:date_format/date_format.dart';

class SectorBloc extends Bloc<SectorsBlocState, SectorsAction>{
  SectorRepo repo = SectorRepo();
  SectorBloc(int trayId) : super(() => SectorsBlocState.init(trayId));

  @override
  Future<void> mapEventToState(SectorsAction event) async {
    print("date ${state.selectedId}");
    print("state ${state.state}");
    switch(event.action){
      case SectorsActionTypes.sectorsLoaded:
        List<Plant> plants = await repo.getPlants();
        GlobalState.plants = plants;
        state = SectorsBlocState.sectorsLoaded(event.sectors, event.jobs);

        break;
      case SectorsActionTypes.sectorCollected:

        state.sectors.sectors[event.sectorId] = Sector(id: event.sectorId, plant_timestamp: 0, plant_id: -1, health: " ", humidity: 0, tray_id: 0);
        log(state.sectors.toString());

        state = SectorsBlocState.sectorCollected(event.outEvent);
        break;
      case SectorsActionTypes.sectorSelected:
        state = SectorsBlocState.infoOpened(event.sectorId, event.scheduled);
        break;

      case SectorsActionTypes.addJob:
        state.jobs.add(event.job);
        state = SectorsBlocState.jobAdded();
        break;
      case SectorsActionTypes.sectorRequest:
          print("sector request: ${state.selectedId} ${state.sectors.sectors}");
          InfoAction action;
          if(!state.scheduled) action = InfoAction.sectorReceived(state.sectors.sectors[state.selectedId], state.sectors.tray);
          else {
            Job job;
            for(int i = 0; i < state.jobs.length; i++){
              if(state.jobs[i].pot_id == state.selectedId) job = state.jobs[i];
            }

            action = InfoAction.sectorReceived(Sector(id: job.pot_id, plant_timestamp: job.timestamp, plant_id: job.plant_id, tray_id: job.tray_id, humidity: 0, health: "OK"), state.sectors.tray);
          }
          outConnector.sendCallbackEvent<InfoAction>(action);
          break;

      case SectorsActionTypes.sectorIdRequest:
        print("sector id request: ${state.selectedId} ${state.trayId}");

        outConnector.sendCallbackEvent(AddAction.receiveSectorId(state.trayId,
            state.selectedId, state.date));
        break;
      case SectorsActionTypes.addOpen:
        state = SectorsBlocState.addOpened(event.sectorId);
        break;
      case SectorsActionTypes.dateSelected:
        state = SectorsBlocState.dateSelected(event.date);
    }
  }

  @override
  void dispose() {

  }

  @override
  Future<void> initEventToState() async {
    Sectors sectors = await repo.getSectors(GlobalState.token, state.trayId);
    List<Job> jobs = await repo.getJobs(GlobalState.token, state.trayId);
    state.sectors = sectors;
    mapEventToState(SectorsAction.sectorsLoaded(sectors, jobs));
  }
}