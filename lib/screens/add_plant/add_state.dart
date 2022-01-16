
import 'package:ai_fresh_plant/base/state.dart';
import 'package:flutter/cupertino.dart';

class AddBlocState extends BaseState<AddStates>{
  static AddBlocState _instance;

  int sectorId;
  int trayId;
  int plantId = -1;
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  int currentPage = 0;
  bool withSector = false;
  DateTime initialDate;
  PageController controller;

  AddBlocState._({
        this.sectorId,
        this.trayId,
        this.plantId,
        this.timestamp,
        this. withSector,
        this.currentPage,
        this.controller,
        this.initialDate,
        AddStates state
      }) : super(state){
    if(controller == null) controller = PageController(initialPage: currentPage, keepPage: false);
    _instance = this;
  }

  factory AddBlocState.init(bool withSector) => AddBlocState._(state: AddStates.init, withSector: withSector, currentPage: 0, plantId: -1, timestamp: DateTime.now().millisecondsSinceEpoch);
  factory AddBlocState.sectorIdReceived(int trayId, int sectorId, DateTime initialDate) => AddBlocState._copyWith(state: AddStates.init, trayId: trayId, sectorId: sectorId, initialDate: initialDate);
  factory AddBlocState.plantSelected(int plantId) => AddBlocState._copyWith(state:  AddStates.plantSelection, plantId: plantId);
  factory AddBlocState.dateSelected(int timestamp) => AddBlocState._copyWith(state:  AddStates.dateSelection, timestamp: timestamp);
  factory AddBlocState.plantSelection() => AddBlocState._copyWith(state: AddStates.plantSelection);
  factory AddBlocState.dateSelection() => AddBlocState._copyWith(state: AddStates.dateSelection);
  factory AddBlocState.submited() => AddBlocState._copyWith(state: AddStates.submited);

  factory AddBlocState._copyWith({
    int sectorId,
    int trayId,
    int plantId,
    int timestamp,
    bool withSector,
    int currentPage,
    PageController controller,
    DateTime initialDate,
    AddStates state
  }) {
     return AddBlocState._(
        sectorId: sectorId ?? _instance.sectorId,
        trayId: trayId ?? _instance.trayId,
        plantId: plantId ?? _instance.plantId,
        timestamp: timestamp ?? _instance.timestamp,
        withSector: withSector ?? _instance.withSector,
        currentPage: currentPage ?? _instance.currentPage,
        controller: controller ?? _instance.controller,
        initialDate: initialDate ?? _instance.initialDate,
        state: state ?? _instance.state
      );
  }
}

enum AddStates{
  init, sectorIdReceived, plantSelection, dateSelection, submited
}