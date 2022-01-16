import 'package:ai_fresh_plant/base/state.dart';
import 'package:ai_fresh_plant/models/models.dart';

class InfoBlocState extends BaseState<InfoStates>{
  static InfoBlocState _instance = InfoBlocState.init();
  Sector sector;
  Tray tray;

  InfoBlocState._({
    this.sector,
    this.tray,
    InfoStates state
  }) : super(state){
    _instance = this;
  }


  factory InfoBlocState.init() => InfoBlocState._(state: InfoStates.init);
  factory InfoBlocState.sectorReceived(Sector sector, Tray tray) =>  InfoBlocState._copyWith(state: InfoStates.sectorReceived, sector: sector, tray: tray);
  factory InfoBlocState.collected() => InfoBlocState._copyWith(state: InfoStates.collected);

  factory InfoBlocState._copyWith({
    InfoStates state,
    Sector sector,
    Tray tray
  }){
    return InfoBlocState._(
      state: state ?? _instance.state,
      sector: sector ?? _instance.sector,
      tray: tray ?? _instance.tray
    );
  }
}

enum InfoStates{
  init, sectorReceived, collected
}