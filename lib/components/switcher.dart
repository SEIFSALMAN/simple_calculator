import 'package:flutter/material.dart';
import '../cubit/appMode/app_mode_cubit.dart';


class DarkLightSwitcher extends StatefulWidget {


  @override
  State<DarkLightSwitcher> createState() => _DarkLightSwitcherState();
}

class _DarkLightSwitcherState extends State<DarkLightSwitcher> {

  @override
  Widget build(BuildContext context) {
    bool light = AppModeCubit.get(context).isDarkMode!;
    return Switch(
      // This bool value toggles the switch.
      activeTrackColor: Colors.black26,
      inactiveTrackColor: Colors.white,
      activeColor: Colors.black,
      thumbColor: MaterialStateProperty.all(Colors.transparent),
      activeThumbImage: const AssetImage('assets/night-mode.png'),
      trackOutlineColor: MaterialStateProperty.all(Colors.grey),
      inactiveThumbImage: const AssetImage('assets/day_mode.png'),
      value: light,
      onChanged: (bool value) {
        setState(() {
          AppModeCubit.get(context).changeAppMode();
          light = value;
        });
      },
    );
  }
}
