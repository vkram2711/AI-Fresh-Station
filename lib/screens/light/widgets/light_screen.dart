import 'package:ai_fresh_plant/screens/light/widgets/sun_switch_widget.dart';
import 'package:ai_fresh_plant/utils.dart';
import 'package:ai_fresh_plant/screens/light/light_action.dart';
import 'package:ai_fresh_plant/screens/light/light_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../light_bloc.dart';

class LightPage extends StatelessWidget{
  LightPage();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => LightBloc(),
      dispose: (context, value) => value.dispose(),
      child: LightScreen(),
    );
  }
}

class LightScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LightScreenState();
 }

class _LightScreenState extends State<LightScreen> {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<LightBloc>(context, listen: false);
    return StreamBuilderWithListener<LightBlocState>(
        stream: bloc.blocStream.stream,
        listener: (value) {
        },
        initialData: bloc.state,
        builder: (context, snapshot) {

          var state = bloc.state;

          print(state.state);
          if(state.state == LightStates.init){
            return Column();
          } else {
            return LightWidget();
           }
        });
  }
}

class LightWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SunSwitchWidget();
}

class _LightWidget extends State<LightWidget>{

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<LightBloc>(context, listen: false).state;

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Semantics(
          container: true,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Switch(
                  activeColor: HexColor.fromHex("FFE792"),
                  onChanged: (value) {
                    state = Provider.of<LightBloc>(context, listen: false).state;
                    var event;
                    if(state.light )  event = LightAction.offAction(); else event = LightAction.onAction();
                    Provider.of<LightBloc>(context, listen: false).mapEventToState(event);
                  },
                  value: state.light,
                ),
                Text("light", style: FontManager.sfProText(size: 16),)
              ]),
        )
    );
  }
}