import 'package:ai_fresh_plant/base/action.dart';

class AddAction extends Action<AddActionTypes>{
  int sectorId;
  int trayId;

  int plantId;
  int timestamp;
  DateTime date;
  int currentPage;

  //AddAction.plant(this.trayId, this.sectorId, this.plantId, this.timestamp) : super(AddActionTypes.plant);
  AddAction.receiveSectorId(this.trayId, this.sectorId, this.date) : super(AddActionTypes.receiveSectorId);
  AddAction.timestampChange(this.timestamp) : super(AddActionTypes.timestampChange);
  AddAction.plantIdChange(this.plantId) : super(AddActionTypes.plantIdChange);
  AddAction.submit() : super(AddActionTypes.submit);
  AddAction.next() : super(AddActionTypes.next);
  AddAction.back() : super(AddActionTypes.back);
}

/**
 * Actions for plant add(seed) screen
 * receiveSectorId
 * timestampChange
 * plantIdChange
 * submit
 */
enum AddActionTypes{
  receiveSectorId, timestampChange, plantIdChange, next, back, submit,
}