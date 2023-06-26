// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../app/api_source.dart' as _i5;
import '../home/bloc/home_bloc.dart' as _i9;
import '../home/repository/home_api.dart' as _i7;
import '../home/repository/home_repository.dart' as _i6;
import '../home/repository/home_use_case.dart' as _i8;
import '../utils/connectivity/connectivity_adapter.dart' as _i4;
import 'module.dart' as _i10;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dIModule = _$DIModule();
  gh.factory<_i3.Client>(() => dIModule.client);
  gh.factory<_i4.Connectivity>(() => _i4.ConnectivityAdapter());
  gh.factory<String>(
    () => dIModule.baseUrl,
    instanceName: 'baseUrl',
  );
  gh.singleton<_i5.ApiSource>(_i5.ApiSource(
    gh<String>(instanceName: 'baseUrl'),
    gh<_i3.Client>(),
    gh<_i4.Connectivity>(),
  ));
  gh.factory<_i6.HomeRepository>(
      () => _i7.HomeRepositoryImpl(gh<_i5.ApiSource>()));
  gh.factory<_i8.HomeUseCase>(
      () => _i8.HomeUseCaseImpl(gh<_i6.HomeRepository>()));
  gh.factory<_i9.HomeBloc>(() => _i9.HomeBloc(gh<_i8.HomeUseCase>()));
  return getIt;
}

class _$DIModule extends _i10.DIModule {}
