import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/fortune_teller/fortuner_message/view_model/fortuner_message_view_model.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/translate.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AlarafApiService());
  locator.registerLazySingleton(() => AlarafUser());
  locator.registerLazySingleton(() => TranslateService());
  locator.registerLazySingleton(() => FortunerMessageViewModel());
}
