import 'package:food_facts/repositories/auth_repository.dart';
import 'package:food_facts/repositories/notification_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt
    ..registerSingleton<NotificationRepository>(NotificationRepository())
    ..registerSingleton<AuthRepository>(AuthRepository());
}
