import 'package:ai_fresh_plant/base/bloc.dart';
import 'package:ai_fresh_plant/base/connector.dart';
import 'package:ai_fresh_plant/base/state.dart';
import 'package:ai_fresh_plant/models/models.dart';
import 'package:ai_fresh_plant/screens/add_plant/add_action.dart';
import 'package:ai_fresh_plant/screens/add_plant/add_data.dart';
import 'package:ai_fresh_plant/screens/add_plant/add_state.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_action.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_bloc.dart';

class AddBloc<P extends SectorBloc> extends Bloc<AddBlocState, AddAction>{
  P parentBloc;
  AddBloc(this.parentBloc, bool withSector) : super(()=> AddBlocState.init(withSector));
  AddRepo repo = AddRepo();

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> initEventToState() {
    ownConnector = Connector<AddBloc, SectorBloc>(this, parentBloc);
    ownConnector.sendEvent<SectorsAction>(SectorsAction.sectorIdRequest());
  }

  @override
  Future<void> mapEventToState(AddAction event) {
    print("plantId ${state.plantId}");
    switch(event.action){
      case AddActionTypes.next:
        if(state.currentPage < 2) state.currentPage++;
        if(state.withSector){

        } else {
          switch(state.currentPage){
            case 0:
              state = AddBlocState.plantSelection();
              break;
            case 1:
              state = AddBlocState.dateSelection();
              break;
          }
        }
        break;
      case AddActionTypes.back:
        if (state.currentPage > 0) state.currentPage--;
        if(state.withSector){

        } else {
          switch(state.currentPage){
            case 0:
              state = AddBlocState.plantSelection();
              break;
            case 1:
              state = AddBlocState.dateSelection();
              break;
          }
        }
        break;
      case AddActionTypes.receiveSectorId:
        print("Receive tray: ${event.trayId} sector ${event.sectorId}");
        state = AddBlocState.sectorIdReceived(event.trayId, event.sectorId, event.date);

        break;
      case AddActionTypes.plantIdChange:
        state = AddBlocState.plantSelected(state.plantId == event.plantId ? -1 : event.plantId);
        break;
      case AddActionTypes.timestampChange:
        state = AddBlocState.dateSelected(event.timestamp);
        break;
      case AddActionTypes.submit:
        state = AddBlocState.submited();
        repo.addPlant(state.plantId, state.trayId, state.sectorId, GlobalState.token, state.timestamp);
        ownConnector.sendEvent(SectorsAction.addJob(Job(pot_id: state.sectorId, timestamp: state.timestamp,  plant_id: state.plantId, tray_id: state.trayId)));
            /*Sector(id: state.sectorId,
                plant_timestamp: state.timestamp,
                plant_id: state.plantId,
                health: "OK",
                humidity: 0,
                tray_id: state.trayId), state.sectorId));*/
        break;
    }
    print("trayId: ${state.trayId} potId: ${state.sectorId}");
  }
}