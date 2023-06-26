import 'package:injectable/injectable.dart';

import '../model/catbreeds.dart';

@injectable
mixin HomeRepository {

  Future<List<CatbreedsModel>> getCatbreeds();

}
