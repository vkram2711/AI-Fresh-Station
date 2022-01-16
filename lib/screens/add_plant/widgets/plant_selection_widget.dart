import 'package:ai_fresh_plant/base/state.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../add_action.dart';
import '../add_bloc.dart';

class PlantList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<AddBloc<SectorBloc>>(context, listen: false);

    return ListView.builder(
        itemCount: GlobalState.plants.length,
        itemBuilder: (context, i) {
          return GestureDetector(
              onTap: (){
                bloc.mapEventToState(AddAction.plantIdChange(i));
              },
              child: Container(
                  color: bloc.state.plantId == i ? HexColor.fromHex("#79C38A") : Colors.white,
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/vegetable_icon.png",
                        width: 48,
                        height: 48,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8
                          ),
                          child: Text(
                            GlobalState.plants[i].name,
                            style: FontManager.sfProText(
                                size: 16,
                                color: bloc.state.plantId == i ? Colors.white : Colors.black),
                          )),
                    ],

                  )));
        });
  }
}