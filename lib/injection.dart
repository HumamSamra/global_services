import 'package:get_it/get_it.dart';
import 'package:global_services/core/storage/storage_service.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
configureDependencies() async {
  getIt.registerSingleton<StorageService>(await StorageService.init());
  getIt.init();
}
