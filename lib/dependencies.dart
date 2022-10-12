import 'package:get_it/get_it.dart';
import 'package:notification_background/local_data_source.dart';
import 'dart:async';

import 'package:notification_background/objectbox.g.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> slInit() async {
  await registerSharedDep(sl);
  sl.registerLazySingleton<LocalDB>(() => LocalDBImpl(store: sl.get<Store>()));
}



Future<void> registerSharedDep(GetIt sl) async {
  final store = await _getStore;
  sl.registerLazySingleton(() {
    return store;
  });
}
Future<Store> get _getStore async {
  final appdirectory = await getApplicationDocumentsDirectory();
  if (Store.isOpen(join(appdirectory.path, "objectBoxs"))) {
    return Store.attach(getObjectBoxModel(), join(appdirectory.path, "objectBoxs"));
  } else {
    return await openStore(
      directory: join(appdirectory.path, "objectBoxs"),
    );
  }
}