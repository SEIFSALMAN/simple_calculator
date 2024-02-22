import 'package:bloc/bloc.dart';
import 'package:cv_projects/screens/landscape_calculator_screen.dart';
import 'package:cv_projects/screens/portrait_calculator_screen.dart';
import 'package:cv_projects/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CacheHelper.dart';
import 'components/bloc_observer.dart';
import 'cubit/appMode/app_mode_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  var isDark = CacheHelper.getData(key: "isDark");
  print("isDark : $isDark");

  if (isDark == null) {
    isDark = false;
  }
  else {
    isDark = isDark;
  }
  runApp(MyApp(isDark));
}

class MyApp extends StatefulWidget {
  final bool isDark;

  MyApp(this.isDark);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
            AppModeCubit()
              ..changeAppMode(fromShared: widget.isDark)),
      ],
      child: BlocConsumer<AppModeCubit, AppModeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            themeMode: AppModeCubit.get(context).isDarkMode!
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            home: OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  return PortraitCalculatorScreen();
                } else {
                  return LandscapeCalculatorScreen();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
