import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hydrosync/infrastructure/datasources/greenhouse_realtime_firebase_datasource.dart';
import 'package:hydrosync/infrastructure/repositories/greenhouse_repository_impl.dart';

final greenhouseRepositoryProvider = Provider((ref){
  return GreenhouseRepositoryImpl(datasource: GreenhouseRealtimeFirebaseDatasource());
});