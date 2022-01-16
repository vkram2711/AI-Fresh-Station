import 'package:ai_fresh_plant/base/action.dart';
import 'package:ai_fresh_plant/base/connector.dart';
import 'package:ai_fresh_plant/base/state.dart';

import '../utils.dart';

typedef S ItemCreator<S>();


abstract class Bloc<T extends BaseState, R extends Action> {
  BlocStream<T> blocStream = BlocStream();

  Future<void> mapEventToState(R event);
  Future<void> initEventToState();

  Connector outConnector;
  Connector ownConnector;

  void attach(Connector connector){
    outConnector = connector;
  }

  void dispose();
  ItemCreator<T> creator;
  T _state;
  T get state => _state;


  set state(T value) {
    _state = value;
    blocStream.eventOut = value;
  }

  Bloc(this.creator) {
    this._state = creator();
    initEventToState();
  }

  Bloc.withConnector(this.creator, parentBloc){
    ownConnector = Connector(this, parentBloc);
  }
}