
import 'dart:developer';

import 'package:ai_fresh_plant/base/bloc.dart';
import 'package:ai_fresh_plant/base/connector.dart';
import 'package:ai_fresh_plant/base/state.dart';
import 'package:ai_fresh_plant/screens/info/info_action.dart';
import 'package:ai_fresh_plant/screens/info/info_data.dart';
import 'package:ai_fresh_plant/screens/info/info_state.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_action.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class InfoBloc<P extends SectorBloc> extends Bloc<InfoBlocState, InfoAction>{
  Connector connector;
  P parentBloc;
  InfoBloc(this.parentBloc) : super(()=> InfoBlocState.init());

  
  InfoRepo repo = InfoRepo();

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> initEventToState() {
   // var bloc = Provider.of<SectorBloc>(context, listen: false);
   // state.sector = bloc.state.sectors[bloc.state.selectedId];
    ownConnector = Connector<InfoBloc, SectorBloc>(this, parentBloc);
    ownConnector.sendEvent<SectorsAction>(SectorsAction.sectorRequest());
  }

  @override
  Future<void> mapEventToState(InfoAction event) async {
    print("info action ${event}");
    switch(event.action){
      case InfoActionsTypes.collect:
        repo.collect(GlobalState.token, state.sector.tray_id, state.sector.id);
        ownConnector.sendEvent<SectorsAction>(SectorsAction.sectorCollected(event.collectedId));
        state = InfoBlocState.collected();
        break;
      case InfoActionsTypes.sectorReceived:
        print("info screen sector: ${event.sector} tray ${event.tray}" );
        state = InfoBlocState.sectorReceived(event.sector,  event.tray);
        break;
    }
  }
}