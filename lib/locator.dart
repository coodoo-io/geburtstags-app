import 'package:geburtstags_app/core/api/birthday.api.dart';
import 'package:geburtstags_app/core/repositories/birthday.repo.dart';
import 'package:geburtstags_app/core/stores/birthday.store.dart';
import 'package:geburtstags_app/core/viewmodels/birthday.viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  locator.registerLazySingleton<BirthdayStore>(() => BirthdayStore());
  locator.registerLazySingleton<BirthdayApi>(() => BirthdayApi());
  locator.registerLazySingleton<BirthdayRepo>(() => BirthdayRepo());

  locator.registerLazySingleton(() => BirthdayViewModel());
  // locator.registerFactory(() => SubscribersViewModel());
}
