import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../CacheHelper.dart';

part 'app_mode_state.dart';

class AppModeCubit extends Cubit<AppModeState> {
  AppModeCubit() : super(AppModeInitial());

  static AppModeCubit get(context) => BlocProvider.of(context);
  bool? isDarkMode = false;


  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDarkMode = fromShared;
      emit(AppModeChangedState());
    } else {
      isDarkMode = !isDarkMode!;
      CacheHelper.putMode(key: 'isDark', value: isDarkMode!)
          .then((value) => emit(AppModeChangedState()));
    }
  }
}
