import 'package:injectable/injectable.dart';

import '../model/catbreeds.dart';
import 'home_repository.dart';

@Injectable(as: HomeUseCase)
class HomeUseCaseImpl implements HomeUseCase {
  final HomeRepository _homeRepository;

  HomeUseCaseImpl(this._homeRepository);

  @override
  Future<List<CatbreedsModel>> getCatbreeds() {
    return _homeRepository.getCatbreeds();
  }

}

mixin HomeUseCase {
  Future<List<CatbreedsModel>> getCatbreeds();
}
